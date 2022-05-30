import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/painting.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/objects/navigation/image_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/image_processor_config.dart';
import 'package:flutter_google_ml_kit/objects/navigation/painter_message.dart';
import 'package:flutter_google_ml_kit/objects/grid/master_grid.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';
import '../objects/grid/processing/on_image_barcode_data.dart';

void imageProcessor(List init) {
  //1. InitalMessage.
  int id = init[0]; //[0] ID.
  SendPort sendPort = init[1]; //[1] SendPort.
  String isarDirectory = init[2]; //[2] Isar directory
  // ignore: unused_local_variable
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
  masterGrid.calculateCoordinates();

  List<Coordinate> coordinates = masterGrid.coordinates!;
  //Calculate coordinates.

  //log(masterGrid.coordinates.toString());

  List<Relationship> relationshipTrees =
      masterGrid.relationshipTrees; //Calculate relationshipsTrees.

  Relationship? soughtContainerRelationship;

  List<String> grids = coordinates.map((e) => e.gridID).toSet().toList();

  if (coordinates.any((element) => element.barcodeUID == selectedBarcodeUID)) {
    soughtContainerRelationship = relationshipTrees
        .firstWhere((element) => element.barcodeUID == selectedBarcodeUID);
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

  //7. GridProcessor
  SendPort? gridProcessor;

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
    gridProcessor = config.gridProcessor;

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
      double? averageOnImageBarcodeSize;
      Offset? averageOffsetToBarcode;

      List<OnImageBarcodeData> onImageBarcodeDatas = [];
      List gridProcessorData = [];
      List<BarcodeObject> barcodeObjects = [];

      bool foundPath = false;
      bool arrow = false;
      Relationship? barcodeRelationship;

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
        Offset offsetToScreenCenter = barcodeCenterPoint - screenCenterPoint;

        //v. Calculate OnImageDiagonalLength.
        double onImageDiagonalLength = onImageBarcodeData.barcodeDiagonalLength;

        if (averageOnImageBarcodeSize == null) {
          averageOnImageBarcodeSize = onImageDiagonalLength;
        } else {
          averageOnImageBarcodeSize =
              (averageOnImageBarcodeSize + onImageDiagonalLength) / 2;
        }

        //vi. Find real barcode Size if it exists.
        double barcodeDiagonalLength = defualtBarcodeSize;
        if (barcodeProperties.any(
            (element) => element.barcodeUID == barcode.value.displayValue)) {
          barcodeDiagonalLength = barcodeProperties
              .firstWhere(
                  (element) => element.barcodeUID == barcode.value.displayValue)
              .size;
        }

        //vii. Calculate the startBarcodeMMperPX.
        double startBarcodeMMperPX =
            onImageDiagonalLength / barcodeDiagonalLength;

        //viii. Calcualte the realOffsetToScreenCenter.
        Offset realOffsetToScreenCenter =
            offsetToScreenCenter / startBarcodeMMperPX;

        BarcodeObject barcodeObject = BarcodeObject(
            barcodeUID: barcode.value.displayValue!,
            realOffsetToScreenCenter: realOffsetToScreenCenter);

        barcodeObjects.add(barcodeObject);

        onImageBarcodeDatas.add(onImageBarcodeData);
        gridProcessorData.add(onImageBarcodeData.toMessage());

        PainterBarcodeObject barcodePainterData = PainterBarcodeObject(
          barcodeUID: barcode.value.displayValue!,
          conrnerPoints: conrnerPoints,
        );

        painterData.add(barcodePainterData);
      }

      if (gridProcessor != null) {
        gridProcessor!.send(gridProcessorData);
      }

      ///1. Identify the grid that the user is in.
      int thevalue = 0;
      String theGridId = '';
      Map<String, int> map = {for (var v in grids) v: 0};

      for (BarcodeObject barcodeObject in barcodeObjects) {
        List<String> gridIDs = coordinates
            .where((element) => element.barcodeUID == barcodeObject.barcodeUID)
            .map((e) => e.gridID)
            .toList();
        for (String gridID in gridIDs) {
          int value = map[gridID]! + 1;
          map[gridID] = value;
          if (thevalue <= value) {
            thevalue = value;
            theGridId = gridID;
          }
        }
      }

      ///2. Once Identified calculate arrow.
      List<Coordinate> gridCoordinates =
          coordinates.where((element) => element.gridID == theGridId).toList();

      if (gridCoordinates
          .any((element) => element.barcodeUID == selectedBarcodeUID)) {
        //If the user is in the correct grid.

        //ix. Find the barcode position.
        Coordinate? barcodePosition = gridCoordinates.firstWhere(
            (element) => element.barcodeUID == barcodeObjects.first.barcodeUID);

        if (barcodePosition.coordinate != null) {
          //x. Calculate the realScreenCenter.
          Offset realScreenCenter = Offset(barcodePosition.coordinate!.x,
                  barcodePosition.coordinate!.y) -
              barcodeObjects.first.realOffsetToScreenCenter;

          Coordinate selectedBarcodeCoordinate = gridCoordinates.firstWhere(
              (element) => element.barcodeUID == selectedBarcodeUID);

          if (selectedBarcodeCoordinate.coordinate != null) {
            Offset offsetToBarcode = Offset(
                  selectedBarcodeCoordinate.coordinate!.x,
                  selectedBarcodeCoordinate.coordinate!.y,
                ) -
                realScreenCenter;

            //Calculate the average offset to selectedBarcode.
            if (averageOffsetToBarcode == null) {
              averageOffsetToBarcode = offsetToBarcode;
            } else {
              averageOffsetToBarcode =
                  (averageOffsetToBarcode + offsetToBarcode) / 2;
            }
            arrow = true;
          } else {
            if (relationshipTrees.any((element) => barcodeObjects
                .map((e) => e.barcodeUID)
                .contains(element.barcodeUID))) {
              barcodeRelationship = relationshipTrees.firstWhere((element) =>
                  barcodeObjects
                      .map((e) => e.barcodeUID)
                      .contains(element.barcodeUID));
              //RelationShip found
              foundPath = true;
            }
          }
          foundPath = true;
        }
      } else {
        //If the user is in another grid.
        if (relationshipTrees.any((element) => barcodeObjects
            .map((e) => e.barcodeUID)
            .contains(element.barcodeUID))) {
          barcodeRelationship = relationshipTrees.firstWhere((element) =>
              barcodeObjects
                  .map((e) => e.barcodeUID)
                  .contains(element.barcodeUID));
          //RelationShip found
          foundPath = true;
        }
      }

      //Check if barcodes have been scanned.
      if (barcodes.isNotEmpty) {
        if (foundPath == false) {
          sendPort.send([
            'error', //[0] Identifier.
            'NoPath', //[1] Error Type.
          ]);
        } else if (foundPath == true &&
            barcodeRelationship != null &&
            soughtContainerRelationship != null &&
            arrow == false) {
          sendPort.send([
            'error', //[0] Identifier.
            'Path', //[1] Error Type.
            barcodeRelationship.treeList, //[2]
            soughtContainerRelationship.treeList, //[3]
          ]);
        }
      }

      PainterMesssage painterMessage = PainterMesssage(
        averageDiagonalLength: averageOnImageBarcodeSize ?? 100,
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
    } else if (message[0] == 'Update') {
      Coordinate coordinate = Coordinate.fromJson(jsonDecode(message[1]));
      masterGrid.updateCoordinate(coordinate);
    }
  });
}

class BarcodeObject {
  BarcodeObject({
    required this.barcodeUID,
    required this.realOffsetToScreenCenter,
  });
  final String barcodeUID;
  final Offset realOffsetToScreenCenter;
}
