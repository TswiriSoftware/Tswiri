import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/painting.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/image_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/image_processor_config.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/painter_message.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/master_grid.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

import '../../../objects/reworked/on_image_data.dart';

void imageProcessor(List init) {
  //1. InitalMessage.
  int id = init[0]; //[0] ID.
  SendPort sendPort = init[1]; //[1] SendPort.
  String isarDirectory = init[2]; //[2] Isar directory
  double focalLength = init[3]; //[3] focalLength
  String selectedBarcodeUID = init[4]; //[4] SelectedContainer BarcodeUID
  double defualtBarcodeSize = init[5]; //[5] Default Barcode Size.

  //2. ReceivePort.
  ReceivePort receivePort = ReceivePort();
  sendPort.send([
    'Sendport', //[0] Identifier.
    receivePort.sendPort, //[1] Sendport
  ]);

  //3. Isar Connection.
  Isar isarDatabase = openIsar(directory: isarDirectory, inspector: false);
  List<BarcodeProperty> barcodeProperties =
      isarDatabase.barcodePropertys.where().findAllSync();

  //4. Spawn MasterGrid.
  MasterGrid masterGrid = MasterGrid(isarDatabase: isarDatabase);

  List<Coordinate> coordinates =
      masterGrid.calculateCoordinates(); //Calculate coordinates.

  List<Relationship> relationshipTrees =
      masterGrid.relationshipTrees; //Calculate relationshipsTrees.

  String? soughtGridID;
  List<String>? soughtBarcodeUIDs;
  Coordinate? soughtBarcodeCoordinate;
  Relationship? soughtContainerRelationship;
  List<Coordinate>? soughtBarcodeCoordinates;
  Offset? soughtBarcodeOffset;

  if (coordinates.any((element) => element.barcodeUID == selectedBarcodeUID)) {
    soughtBarcodeCoordinate = coordinates
        .firstWhere((element) => element.barcodeUID == selectedBarcodeUID);

    soughtGridID = soughtBarcodeCoordinate.gridID;

    soughtBarcodeCoordinates =
        coordinates.where((element) => element.gridID == soughtGridID).toList();

    soughtBarcodeUIDs =
        soughtBarcodeCoordinates.map((e) => e.barcodeUID).toList();

    soughtBarcodeOffset = Offset(
      soughtBarcodeCoordinate.coordinate!.x,
      soughtBarcodeCoordinate.coordinate!.y,
    );

    soughtContainerRelationship = relationshipTrees.firstWhere(
        (element) => element.barcodeUID == soughtBarcodeCoordinate!.barcodeUID);
  } else {
    sendPort.send([
      'error', //[0] Identifier.
      'nogrid', //[1] Error Type.
    ]);
  }

  //5. Spawn BarcodeScanner.
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  //6. Image Config
  InputImageData? inputImageData;
  Size? absoluteSize;
  Size? canvasSize;

  void configureInputImageData(message) {
    //Decode Message.
    ImageProcessorConfig config = ImageProcessorConfig.fromMessage(message);
    //Configure InputImageData.
    inputImageData = InputImageData(
      size: config.absoluteSize,
      imageRotation: InputImageRotation.Rotation_90deg,
      inputImageFormat: config.inputImageFormat,
      planeData: null,
    );
    absoluteSize = config.absoluteSize;
    canvasSize = config.canvasSize;

    log('I$id: InputImageData Configured');
  }

  void processImage(message) async {
    if (inputImageData != null && canvasSize != null && absoluteSize != null) {
      //1. Decode Message.
      ImageMessage imageDataMessage = ImageMessage.fromMessage(message);

      //2. Decode ImageBytes.
      InputImage inputImage = InputImage.fromBytes(
          bytes: imageDataMessage.bytes, inputImageData: inputImageData!);

      //3. Scan Image.
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      //4. Initiate Painter Message variables.
      List<PainterBarcodeObject> painterData = [];
      double? averageBarcodeDiagonalLength;
      Offset? averageOffsetToBarcode;

      List<OnImageBarcodeData> onImageBarcodeDatas = [];

      bool? unkownPosition;

      for (Barcode barcode in barcodes) {
        ///1. Caluclate barcode OnScreen CornerPoints.
        List<Offset> conrnerPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.value.cornerPoints!;
        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);

          conrnerPoints.add(Offset(x, y));
        }

        //2. Build onImageBarcodeData.
        OnImageBarcodeData onImageBarcodeData = OnImageBarcodeData(
          barcodeUID: barcode.value.displayValue!,
          onImageCornerPoints: [
            Offset(cornerPoints[0].x.toDouble(), cornerPoints[0].y.toDouble()),
            Offset(cornerPoints[1].x.toDouble(), cornerPoints[1].y.toDouble()),
            Offset(cornerPoints[2].x.toDouble(), cornerPoints[2].y.toDouble()),
            Offset(cornerPoints[3].x.toDouble(), cornerPoints[3].y.toDouble()),
          ],
          timestamp: message[3],
          accelerometerData: imageDataMessage.accelerometerData,
        );

        //Check if the soughtGrid is not null.
        if (soughtGridID != null && soughtBarcodeUIDs != null) {
          log('SoughtGrid Valid');
          if (soughtBarcodeUIDs.contains(barcode.value.displayValue)) {
            log('Calculating arrow');
            //TODO: Calculate Arrow.
            //i. Calculate phone angle.
            double phoneAngle =
                onImageBarcodeData.accelerometerData.calculatePhoneAngle();

            //ii. Calculate screenCenterPoint.
            Offset screenCenterPoint = rotateOffset(
                offset: Offset(inputImageData!.size.height / 2,
                    inputImageData!.size.width / 2),
                angleRadians: phoneAngle);

            //iii. Calculate Barcode Center Point.
            Offset barcodeCenterPoint = rotateOffset(
                offset: onImageBarcodeData.barcodeCenterPoint,
                angleRadians: phoneAngle);

            //iv. Calculate offset to Screen Center.
            Offset offsetToScreenCenter =
                barcodeCenterPoint - screenCenterPoint;

            //v. Calculate OnImageDiagonalLength.
            double onImageDiagonalLength =
                onImageBarcodeData.barcodeDiagonalLength;

            if (averageBarcodeDiagonalLength == null) {
              averageBarcodeDiagonalLength = onImageDiagonalLength;
            } else {
              averageBarcodeDiagonalLength =
                  (averageBarcodeDiagonalLength + onImageDiagonalLength) / 2;
            }

            //vi. Find real barcode Size if it exists.
            double barcodeDiagonalLength = defualtBarcodeSize;
            if (barcodeProperties.any((element) =>
                element.barcodeUID == barcode.value.displayValue)) {
              barcodeDiagonalLength = barcodeProperties
                  .firstWhere((element) =>
                      element.barcodeUID == barcode.value.displayValue)
                  .size;
            }

            //vii. Calculate the startBarcodeMMperPX.
            double startBarcodeMMperPX =
                onImageDiagonalLength / barcodeDiagonalLength;

            //viii. Calcualte the realOffsetToScreenCenter.
            Offset realOffsetToScreenCenter =
                offsetToScreenCenter / startBarcodeMMperPX;

            //ix. Find the barcode position.
            Coordinate barcodePosition = coordinates.firstWhere(
                (element) => element.barcodeUID == barcode.value.displayValue);

            //x. Calculate the realScreenCenter.
            Offset realScreenCenter = Offset(barcodePosition.coordinate!.x,
                    barcodePosition.coordinate!.y) -
                realOffsetToScreenCenter;

            Offset offsetToBarcode = soughtBarcodeOffset! - realScreenCenter;

            //Calculate the average offset to selectedBarcode.
            if (averageOffsetToBarcode == null) {
              averageOffsetToBarcode = offsetToBarcode;
            } else {
              averageOffsetToBarcode =
                  (averageOffsetToBarcode + offsetToBarcode) / 2;
            }

            unkownPosition = false;
          } else {
            //1. Identify the Grid.
            if (coordinates.any((element) =>
                element.barcodeUID == barcode.value.displayValue)) {
              //Find the coordinate of the barcode.
              Coordinate currentCoordiante = coordinates.firstWhere((element) =>
                  element.barcodeUID == barcode.value.displayValue);

              if (relationshipTrees.any((element) =>
                  element.barcodeUID == currentCoordiante.barcodeUID)) {
                Relationship currentRelationship = relationshipTrees.firstWhere(
                    (element) =>
                        element.barcodeUID == currentCoordiante.barcodeUID);

                log(currentRelationship.toString());
                log(soughtContainerRelationship.toString());
              }

              unkownPosition = false;
            }
          }
        }

        //////////////////////////

        onImageBarcodeDatas.add(onImageBarcodeData);

        PainterBarcodeObject barcodePainterData = PainterBarcodeObject(
          barcodeUID: barcode.value.displayValue!,
          conrnerPoints: conrnerPoints,
        );

        painterData.add(barcodePainterData);
      }

      //TODO: Invertigate.

      // if (unkownPosition == null && barcodes.isNotEmpty) {
      //   sendPort.send([
      //     'error', //[0] Identifier.
      //     'unkownposition', //[1] Error Type.
      //   ]);
      // }

      PainterMesssage painterMessage = PainterMesssage(
        averageDiagonalLength: averageBarcodeDiagonalLength ?? 100,
        painterData: painterData,
        averageOffsetToBarcode: averageOffsetToBarcode ?? const Offset(0, 0),
      );

      sendPort.send(painterMessage.toMessage());
    }
  }

  receivePort.listen((message) {
    if (message[0] == 'ImageProcessorConfig') {
      configureInputImageData(message);
    } else if (message[0] == 'ImageDataMessage') {
      processImage(message);
    }
  });
}
