import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_data.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:vector_math/vector_math.dart' as vm;

void navigatorImageProcessorIsolate(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  InputImageData? inputImageData;
  Size? screenSize;
  Map<String, double>? barcodeProperties;
  SendPort? gridSendPort;

  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  void processImage(var message) async {
    if (inputImageData != null &&
        screenSize != null &&
        barcodeProperties != null) {
      InputImage inputImage = InputImage.fromBytes(
          bytes:
              (message[1] as TransferableTypedData).materialize().asUint8List(),
          inputImageData: inputImageData!);

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      List<dynamic> barcodeData = [];

      for (Barcode barcode in barcodes) {
        ///s1. Caluclate barcode OnScreen CornerPoints.
        List<Offset> offsetPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.value.cornerPoints!;
        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);

          offsetPoints.add(Offset(x, y));
        }

        ///2. Build onImageBarcodeData.
        OnImageBarcodeData onImageBarcodeData = OnImageBarcodeData(
            barcodeUID: barcode.value.displayValue!,
            onImageCornerPoints: [
              Offset(
                  cornerPoints[0].x.toDouble(), cornerPoints[0].y.toDouble()),
              Offset(
                  cornerPoints[1].x.toDouble(), cornerPoints[1].y.toDouble()),
              Offset(
                  cornerPoints[2].x.toDouble(), cornerPoints[2].y.toDouble()),
              Offset(
                  cornerPoints[3].x.toDouble(), cornerPoints[3].y.toDouble()),
            ],
            timestamp: message[3],
            accelerometerData: AccelerometerData(
                accelerometerEvent: vm.Vector3(
                  message[2][0] as double,
                  message[2][1] as double,
                  message[2][2] as double,
                ),
                userAccelerometerEvent: vm.Vector3(
                  message[2][3] as double,
                  message[2][4] as double,
                  message[2][5] as double,
                )));

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

        Offset realOffset = offsetToScreenCenter / startBarcodeMMperPX;

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
            // Accelerometer Data [3].
            message[2][0], //accelerometerEvent.x
            message[2][1], //accelerometerEvent.y
            message[2][2], //accelerometerEvent.z
            message[2][3], //userAccelerometerEvent.x
            message[2][4], //userAccelerometerEvent.y
            message[2][5], //userAccelerometerEvent.z
          ],
          message[3], // timeStamp [4].
          [
            // Offset to Screen Center [5].
            realOffset.dx,
            realOffset.dy,
          ],
          onImageDiagonalLength //OnImage Diagonal Length [6].
        ]);
      }
      //log(barcodeData.toString());

      sendPort.send(barcodeData);
      if (gridSendPort != null) {
        gridSendPort!.send(barcodeData);
      }
    }
  }

  receivePort.listen(
    (message) {
      if (message is SendPort) {
        gridSendPort = message;
        log('Grid Port Received.');
      } else if (message[0] == 'compute') {
        //Process the image.
        processImage(message);
      } else if (message is List) {
        log('configured');
        //Configure InputImageData.
        inputImageData = InputImageData(
          size: Size(message[0], message[1]),
          imageRotation: InputImageRotation.Rotation_90deg,
          inputImageFormat: InputImageFormat.values.elementAt(message[2]),
          planeData: null,
        );

        barcodeProperties = message[5];

        screenSize = Size(message[3], message[4]);

        sendPort.send('configured');
      }
    },
  );
}
