import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/objects/grid/isolate_grid.dart';
import 'package:flutter_google_ml_kit/objects/grid/position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate/rolling_grid_position.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/message_objects/navigator_isolate_config.dart';
import 'package:flutter_google_ml_kit/objects/navigation/message_objects/navigator_isolate_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/painter_message.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:isar/isar.dart';

void imageProcessorNavigator(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  InputImageData? inputImageData;
  Size? canvasSize;

  Map<String, double>? barcodeProperties;

  SendPort? gridSendPort;

  String? selectedBarcodeUID;

  IsolateGrid? isolateGrid;
  // ignore: unused_local_variable
  Isar? isarDatabase;

  log('IsolateGrid');
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  // void test(String isarDirectory) async {
  //   isarDatabase = openIsar(directory: isarDirectory);
  //   log(isarDatabase!.containerEntrys.where().findAllSync().toString());
  // }

  // void write(int value) {
  //   isarDatabase!.writeTxnSync((isar) => isar.containerTypes.putSync(
  //       ContainerType()
  //         ..id = value
  //         ..containerType = 'area'
  //         ..containerDescription =
  //             '- An Area is a stationary container with a marker.\n- which can contain all other types of containers.\n- It is part of the childrens grid.'
  //         ..canContain = ['shelf', 'box', 'drawer']
  //         ..moveable = false
  //         ..enclosing = true
  //         ..containerColor = const Color(0xFFff420e).value.toString(),
  //       replaceOnConflict: true));
  //   log('write ' + value.toString());
  // }

  void processImage(var message) async {
    if (inputImageData != null &&
        canvasSize != null &&
        barcodeProperties != null &&
        selectedBarcodeUID != null) {
      NavigatorIsolateData navigatorIsolateData =
          NavigatorIsolateData.fromMessage(message);

      InputImage inputImage = InputImage.fromBytes(
          bytes: navigatorIsolateData.bytes, inputImageData: inputImageData!);

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      //Grid Isolate Message
      List<dynamic> barcodeData = [];

      //Painter Message
      List<PainterBarcodeObject> painterData = [];
      double? averageBarcodeDiagonalLength;
      Offset? averageOffsetToBarcode;

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
          accelerometerData: navigatorIsolateData.accelerometerData,
        );

        ///3. Calculate the offset between OnImageCenter and BarcodeCenter.

        //i. Calculate phone angle.
        double phoneAngle =
            onImageBarcodeData.accelerometerData.calculatePhoneAngle();

        //ii. Calculate screenCenterPoint.
        Offset screenCenterPoint = rotateOffset(
            offset: Offset(inputImageData!.size.height / 2,
                inputImageData!.size.width / 2),
            angleRadians: phoneAngle);

        //iii. Calculate barcodeCenterPoint.
        Offset barcodeCenterPoint = rotateOffset(
            offset: onImageBarcodeData.barcodeCenterPoint,
            angleRadians: phoneAngle);

        //iv. Calculate offset.
        Offset offsetToScreenCenter = barcodeCenterPoint - screenCenterPoint;

        double onImageDiagonalLength = onImageBarcodeData.barcodeDiagonalLength;

        //v. Calculate the RealOffset
        double barcodeDiagonalLength = barcodeProperties!['default']!;
        if (barcodeProperties!.keys.contains(barcode.value.displayValue)) {
          barcodeDiagonalLength =
              barcodeProperties![barcode.value.displayValue]!;
        }
        double startBarcodeMMperPX = onImageDiagonalLength /
            barcodeDiagonalLength; //Will have to pass in the stored barcode diagonalLength....

        Offset realOffsetToScreenCenter =
            offsetToScreenCenter / startBarcodeMMperPX;

        int index2 = isolateGrid!.positionalGrids.indexWhere((element) =>
            element.barcodes.contains(barcode.value.displayValue!));

        if (index2 != -1) {
          IsolatePositionalGrid? grid = isolateGrid!.positionalGrids[index2];

          Position barcodePosition = grid.positions
              .where(
                  (element) => element.barcodeUID == barcode.value.displayValue)
              .first;

          //Calculate real Screen Center.
          Offset realScreenCenter =
              Offset(barcodePosition.position!.x, barcodePosition.position!.y) -
                  realOffsetToScreenCenter;

          int index = grid.positions.indexWhere(
              (element) => element.barcodeUID == selectedBarcodeUID);

          if (index == -1) {
            List message = [
              'navigate', //Identifier.
              barcode.value.displayValue!, //Current Barcode.
              selectedBarcodeUID, //Selected barcode.
            ];

            sendPort.send(message);
          } else {
            Position selectedBarcodePosition = grid.positions[index];

            Offset barcodeOffset = Offset(selectedBarcodePosition.position!.x,
                selectedBarcodePosition.position!.y);

            Offset offsetToBarcode = barcodeOffset - realScreenCenter;
            //Calculate the average offset to selectedBarcode.
            if (averageOffsetToBarcode == null) {
              averageOffsetToBarcode = offsetToBarcode;
            } else {
              averageOffsetToBarcode =
                  (averageOffsetToBarcode + offsetToBarcode) / 2;
            }
          }
        }

        //Painter Message
        if (averageBarcodeDiagonalLength == null) {
          averageBarcodeDiagonalLength = onImageDiagonalLength;
        } else {
          averageBarcodeDiagonalLength =
              (averageBarcodeDiagonalLength + onImageDiagonalLength) / 2;
        }

        PainterBarcodeObject barcodePainterData = PainterBarcodeObject(
          barcodeUID: barcode.value.displayValue!,
          conrnerPoints: conrnerPoints,
        );
        painterData.add(barcodePainterData);

        barcodeData.add([
          barcode.value.displayValue, //Display value. [0]
          [
            //On Image Points [1].
            cornerPoints[0].x.toDouble(), // Point1. x
            cornerPoints[0].y.toDouble(), // Point1. y
            cornerPoints[1].x.toDouble(), // Point2. x
            cornerPoints[1].y.toDouble(), // Point2. y
            cornerPoints[2].x.toDouble(), // Point3. x
            cornerPoints[2].y.toDouble(), // Point3. y
            cornerPoints[3].x.toDouble(), // Point4. x
            cornerPoints[3].y.toDouble(), // Point5. y
          ],
          [
            message[2][0], //accelerometerEvent.x
            message[2][1], //accelerometerEvent.y
            message[2][2], //accelerometerEvent.z
            message[2][3], //userAccelerometerEvent.x
            message[2][4], //userAccelerometerEvent.y
            message[2][5], //userAccelerometerEvent.z
          ], // Accelerometer Data [2].
          onImageDiagonalLength, //OnImage Diagonal Length [3].
          barcodeDiagonalLength, //Barcode Diagonal Length. [4]
          startBarcodeMMperPX, //BarcodeMMperPX [5]
          message[3], // timeStamp [6].
        ]);
      }

      PainterMesssage painterMessage = PainterMesssage(
        averageDiagonalLength: averageBarcodeDiagonalLength ?? 100,
        painterData: painterData,
        averageOffsetToBarcode: averageOffsetToBarcode ?? const Offset(0, 0),
      );

      sendPort.send(painterMessage.toMessage());

      if (gridSendPort != null) {
        gridSendPort!.send(['process', barcodeData]);
      }
    }
  }

  receivePort.listen(
    (message) {
      if (message is SendPort) {
        gridSendPort = message;
        //log('Grid Port Received.');
        gridSendPort!.send(receivePort.sendPort);
      } else if (message[0] == 'process') {
        //Process the image.
        processImage(message);
      } else if (message[0] == 'config') {
        //log('configured');
        NavigatorIsolateConfig config =
            NavigatorIsolateConfig.fromMessage(message);

        //Configure InputImageData.
        inputImageData = InputImageData(
          size: config.absoluteSize,
          imageRotation: InputImageRotation.Rotation_90deg,
          inputImageFormat: config.inputImageFormat,
          planeData: null,
        );

        canvasSize = config.canvasSize;
        selectedBarcodeUID = config.selectedBarcodeUID;
        barcodeProperties = config.barcodeProperties;
        isolateGrid = config.grid;
        //log(config.grid.toString());

        sendPort.send('configured');
      } else if (message[0] == 'update') {
        log('updating');
        RollingGridPosition rollingGridPosition =
            RollingGridPosition.fromJson(jsonDecode(message[1]));

        isolateGrid!.positionalGrids
            .where((element) =>
                element.barcodes.contains(rollingGridPosition.barcodeUID))
            .first
            .updatePosition(rollingGridPosition);
      }
      // else if (message[0] == 'isar') {
      //   test(message[1]);
      // } else if (message[0] == 'write') {
      //   write(message[1] as int);
      // }
    },
  );
}
