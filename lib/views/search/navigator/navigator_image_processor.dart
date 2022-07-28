// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/painting.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:math' as math;
import 'package:sunbird/classes/acceleromter_data.dart';
import 'package:sunbird/classes/on_image_barcode_data.dart';
import 'package:sunbird/functions/data_processing.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/scripts/coordinate_translator.dart';

import 'package:vector_math/vector_math_64.dart' as vm;

void navigationImageProcessor(List init) {
  //1. InitalMessage.
  int id = init[0]; //[0] ID.
  SendPort sendPort = init[1]; //[1] SendPort.
  String isarDirectory = init[2]; //[2] Isar directory.
  // double focalLength = init[3]; //[3] focalLength //Not Required anymore ?
  String selectedBarcodeUID = init[4]; //[4] SelectedContainer BarcodeUID
  double defualtBarcodeSize = init[5]; //[5] Default Barcode Size.
  int selectedBarcodeGrid = init[6]; //SelectedBarcodeGridUID.

  //2. ReceivePort.
  ReceivePort receivePort = ReceivePort();
  sendPort.send([
    'Sendport', //[0] Identifier.
    receivePort.sendPort, //[1] Sendport
  ]);

  //3. Isar Connection.
  Isar isar = initiateIsar(directory: isarDirectory, inspector: false);
  List<CatalogedBarcode> barcodeProperties =
      isar.catalogedBarcodes.where().findAllSync();

  //5. Spawn BarcodeScanner.
  BarcodeScanner barcodeScanner = BarcodeScanner(
    formats: [
      BarcodeFormat.qrCode,
    ],
  );

  //6. Image Config
  InputImageData? inputImageData;
  Size? absoluteSize;
  Size? canvasSize;

  //7. GridProcessor
  SendPort? gridProcessor;

  //8. All Coordinates.
  List<CatalogedCoordinate> coordinates =
      isar.catalogedCoordinates.where().findAllSync();

  //9. Target Coordinate
  CatalogedCoordinate targetCoordinate = coordinates
      .firstWhere((element) => element.barcodeUID == selectedBarcodeUID);

  void _processImage(message) async {
    if (inputImageData != null && canvasSize != null) {
      InputImage inputImage = InputImage.fromBytes(
        bytes:
            (message[1] as TransferableTypedData).materialize().asUint8List(),
        inputImageData: inputImageData!,
      );

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      double? averageOnImageBarcodeSize;
      Offset? averageOffsetToBarcode;
      List onImageBarcodeDatas = [];

      List<dynamic> barcodeToPaint = [];

      for (Barcode barcode in barcodes) {
        List<Offset> conrnerPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.cornerPoints!;
        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);

          conrnerPoints.add(Offset(x, y));
        }

        //Add selected Bacode data.
        if (selectedBarcodeUID == barcode.displayValue) {
          barcodeToPaint = [
            barcode.displayValue, //Display value. [0]
            [
              //On Screen Points [1]
              conrnerPoints[0].dx,
              conrnerPoints[0].dy,
              conrnerPoints[1].dx,
              conrnerPoints[1].dy,
              conrnerPoints[2].dx,
              conrnerPoints[2].dy,
              conrnerPoints[3].dx,
              conrnerPoints[3].dy,
            ],
          ];
        }

        //Build onImageBarcodeData.
        OnImageBarcodeData onImageBarcodeData = OnImageBarcodeData(
          barcodeUID: barcode.displayValue!,
          onImageCornerPoints: [
            Offset(cornerPoints[0].x.toDouble(), cornerPoints[0].y.toDouble()),
            Offset(cornerPoints[1].x.toDouble(), cornerPoints[1].y.toDouble()),
            Offset(cornerPoints[2].x.toDouble(), cornerPoints[2].y.toDouble()),
            Offset(cornerPoints[3].x.toDouble(), cornerPoints[3].y.toDouble()),
          ],
          timestamp: message[3],
          accelerometerData: AccelerometerData(
            accelerometerEvent: vm.Vector3(
              message[2][0],
              message[2][1],
              message[2][2],
            ),
            userAccelerometerEvent: vm.Vector3(
              message[2][3],
              message[2][4],
              message[2][5],
            ),
          ),
        );
        onImageBarcodeDatas.add(onImageBarcodeData.toMessage());

        //Calculate phone angle.
        double phoneAngle =
            onImageBarcodeData.accelerometerData.calculatePhoneAngle();

        //Calculate screenCenterPoint.
        Offset screenCenterPoint = rotateOffset(
            offset: Offset(inputImageData!.size.height / 2,
                inputImageData!.size.width / 2),
            angleRadians: phoneAngle);

        //Calculate Barcode Center Point.
        Offset barcodeCenterPoint = rotateOffset(
            offset: onImageBarcodeData.barcodeCenterPoint,
            angleRadians: phoneAngle);

        //Calculate offset to Screen Center.
        Offset offsetToScreenCenter = barcodeCenterPoint - screenCenterPoint;

        //Calculate OnImageDiagonalLength.
        double onImageDiagonalLength = onImageBarcodeData.barcodeDiagonalLength;

        //Update averageOnImageBarcodeSize.
        if (averageOnImageBarcodeSize == null) {
          averageOnImageBarcodeSize = onImageDiagonalLength;
        } else {
          averageOnImageBarcodeSize =
              (averageOnImageBarcodeSize + onImageDiagonalLength) / 2;
        }

        //Find real barcode Size if it exists.
        double barcodeDiagonalLength = defualtBarcodeSize;
        if (barcodeProperties
            .any((element) => element.barcodeUID == barcode.displayValue)) {
          barcodeDiagonalLength = barcodeProperties
              .firstWhere(
                  (element) => element.barcodeUID == barcode.displayValue)
              .size;
        }

        //Calculate the startBarcodeMMperPX.
        double startBarcodeMMperPX =
            onImageDiagonalLength / barcodeDiagonalLength;

        //Calcualte the realOffsetToScreenCenter.
        Offset realOffsetToScreenCenter =
            offsetToScreenCenter / startBarcodeMMperPX;

        int coordinateIndex = coordinates.indexWhere(
            (element) => element.barcodeUID == barcode.displayValue);

        if (coordinateIndex != -1) {
          //Coordiante found.
          CatalogedCoordinate catalogedCoordinate =
              coordinates[coordinateIndex];

          if (catalogedCoordinate.gridUID == selectedBarcodeGrid) {
            //In the correct grid.
            Offset realScreenCenter = Offset(catalogedCoordinate.coordinate!.x,
                    catalogedCoordinate.coordinate!.y) -
                realOffsetToScreenCenter;

            Offset offsetToBarcode = Offset(
                  targetCoordinate.coordinate!.x,
                  targetCoordinate.coordinate!.y,
                ) -
                realScreenCenter;

            averageOffsetToBarcode ??= offsetToBarcode;
          } else {
            //In the wrong grid. TODO: implement interGrid Navigation if possible else Throw message.
          }
        } else {
          //Coordiante not found. TODO: Possibly let the user know this barcode has not been scanned. Scafold message ?

        }
      }

      List painterMessage = [
        'painterMessage', // [0]
        averageOnImageBarcodeSize ?? defaultBarcodeSize, // [1].
        //Average Offset to barcode [2].
        [
          averageOffsetToBarcode?.dx ?? 0,
          averageOffsetToBarcode?.dy ?? 0,
        ],
        barcodeToPaint, // Selected Barcode on Screen Points [3].
      ];

      sendPort.send(painterMessage);

      if (gridProcessor != null) {
        gridProcessor!.send(onImageBarcodeDatas);
      }
    }
  }

  receivePort.listen((message) {
    if (message[0] == 'ImageProcessorConfig') {
      //Abosulte Image Size.
      absoluteSize = Size(message[1], message[2]);

      //Canvas size.
      canvasSize = Size(message[4], message[5]);

      //InputImageData.
      inputImageData = InputImageData(
        size: absoluteSize!,
        imageRotation: InputImageRotation.rotation90deg,
        inputImageFormat: InputImageFormat.values.elementAt(message[3]),
        planeData: null,
      );

      //Grid Processor.
      gridProcessor = message[6];

      log('I$id: InputImageData Configured');
    } else if (message[0] == 'process') {
      _processImage(message);
    } else if (message[0] == 'update') {
      CatalogedCoordinate newCoordinate =
          catalogedCoordinateFromMessage(message);

      //Find the coordinate that has moved.
      int index = coordinates.indexWhere(
          (element) => element.barcodeUID == newCoordinate.barcodeUID);

      if (index != -1) {
        //If it exsits remove it and add the new coordiante.
        coordinates.removeAt(index);
        coordinates.add(newCoordinate);

        if (targetCoordinate.barcodeUID == newCoordinate.barcodeUID) {
          //If the target coordinate has moved update it.
          targetCoordinate = newCoordinate;
        }
      } else {
        coordinates.add(newCoordinate);
      }
    }
  });
}
