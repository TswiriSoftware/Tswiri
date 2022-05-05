import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_position.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/message_objects/navigator_isolate_config.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/message_objects/navigator_isolate_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/message_objects/painter_message.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';

void imageProcessorNavigator(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  InputImageData? inputImageData;
  Size? canvasSize;
  Map<String, double>? barcodeProperties;
  SendPort? gridSendPort;
  String? selectedBarcodeUID;
  List<IsolateGridObject>? initialGrids;

  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

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

      List<dynamic> barcodeData = [];

      //Painter Message
      List<dynamic> painterData = [];
      double? averageBarcodeDiagonalLength;
      Offset? averageOffsetToBarcode;

      for (Barcode barcode in barcodes) {
        ///1. Caluclate barcode OnScreen CornerPoints.
        List<Offset> offsetPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.value.cornerPoints!;
        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, canvasSize!, inputImageData!.size);

          offsetPoints.add(Offset(x, y));
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

        //Select relevant grid.
        IsolateGridObject grid = initialGrids!
            .where((element) =>
                element.getBarcodes().contains(barcode.value.displayValue))
            .first;

        GridPosition barcodePosition = grid.gridPositions
            .where(
                (element) => element.barcodeUID == barcode.value.displayValue)
            .first;

        //Calculate real Screen Center.
        Offset realScreenCenter =
            Offset(barcodePosition.position!.x, barcodePosition.position!.y) -
                realOffsetToScreenCenter;

        GridPosition selectedBarcodePosition = grid.gridPositions
            .where((element) => element.barcodeUID == selectedBarcodeUID)
            .first;

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

        //Painter Message
        if (averageBarcodeDiagonalLength == null) {
          averageBarcodeDiagonalLength = onImageDiagonalLength;
        } else {
          averageBarcodeDiagonalLength =
              (averageBarcodeDiagonalLength + onImageDiagonalLength) / 2;
        }

        painterData.add([
          barcode.value.displayValue, //Display value. [0]
          [
            //On Screen Points [1].
            offsetPoints[0].dx,
            offsetPoints[0].dy,
            offsetPoints[1].dx,
            offsetPoints[1].dy,
            offsetPoints[2].dx,
            offsetPoints[2].dy,
            offsetPoints[3].dx,
            offsetPoints[3].dy,
          ],
          [
            realOffsetToScreenCenter.dx,
            realOffsetToScreenCenter.dy,
          ], // Offset to Screen Center [2].
        ]);

        barcodeData.add([
          barcode.value.displayValue, //Display value. [0]
          [
            //On Screen Points [1].
            offsetPoints[0].dx,
            offsetPoints[0].dy,
            offsetPoints[1].dx,
            offsetPoints[1].dy,
            offsetPoints[2].dx,
            offsetPoints[2].dy,
            offsetPoints[3].dx,
            offsetPoints[3].dy,
          ],
          [
            //On Image Points [2].
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
          ], // Accelerometer Data [3].
          [
            realOffsetToScreenCenter.dx,
            realOffsetToScreenCenter.dy,
          ], // Offset to Screen Center [4].
          onImageDiagonalLength, //OnImage Diagonal Length [5].
          barcodeDiagonalLength, //final double dialogballegth; [6]
          startBarcodeMMperPX, //BarcodeMMperPX [7]
          message[3], // timeStamp [8].
        ]);
      }
      //log(barcodeData.toString());

      PainterMesssage painterMessage = PainterMesssage(
        averageDiagonalLength: averageBarcodeDiagonalLength ?? 100,
        painterData: painterData,
        averageOffsetToBarcode: averageOffsetToBarcode ?? Offset(0, 0),
      );

      sendPort.send(painterMessage.toMessage());

      //log(initialGrids.toString());

      if (gridSendPort != null) {
        gridSendPort!.send(['compute', barcodeData]);
      }
    }
  }

  receivePort.listen(
    (message) {
      if (message is SendPort) {
        gridSendPort = message;
        log('Grid Port Received.');
        gridSendPort!.send(sendPort);
      } else if (message[0] == 'process') {
        //Process the image.
        processImage(message);
      } else if (message[0] == 'config') {
        log('configured');
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
        initialGrids = config.initialGrids;

        sendPort.send('configured');
      }
    },
  );
}
