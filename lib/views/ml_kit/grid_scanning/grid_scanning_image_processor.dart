import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'dart:math' as math;

import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:tswiri_database/functions/other/coordinate_translator.dart';

void gridScanningImageProcessor(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  InputImageData? inputImageData;
  Size? screenSize;

  BarcodeScanner barcodeScanner = BarcodeScanner(
    formats: [
      BarcodeFormat.qrCode,
    ],
  );

  void processImage(var message) async {
    if (inputImageData != null && screenSize != null) {
      InputImage inputImage = InputImage.fromBytes(
          bytes:
              (message[1] as TransferableTypedData).materialize().asUint8List(),
          inputImageData: inputImageData!);

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      List<dynamic> barcodeData = [];

      for (Barcode barcode in barcodes) {
        List<Offset> offsetPoints = <Offset>[];
        List<math.Point<num>> cornerPoints = barcode.cornerPoints!;
        for (var point in cornerPoints) {
          double x = translateX(point.x.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);
          double y = translateY(point.y.toDouble(),
              inputImageData!.imageRotation, screenSize!, inputImageData!.size);

          offsetPoints.add(Offset(x, y));
        }

        barcodeData.add(
          [
            barcode.displayValue, //Display value. [0]
            [
              //On Screen Points [1][]
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
              //On Image Points [2][]
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
              // Accelerometer Data [3]
              message[2][0], //accelerometerEvent.x
              message[2][1], //accelerometerEvent.y
              message[2][2], //accelerometerEvent.z
              message[2][3], //userAccelerometerEvent.x
              message[2][4], //userAccelerometerEvent.y
              message[2][5], //userAccelerometerEvent.z
            ],
            message[3], // timeStamp [4]
          ],
        );
      }
      sendPort.send(barcodeData);
    }
  }

  receivePort.listen(
    (message) {
      if (message[0] == 'compute') {
        //Process the image.
        processImage(message);
      } else if (message is List) {
        log('configured');
        //Configure InputImageData.
        inputImageData = InputImageData(
          size: Size(message[1], message[0]),
          imageRotation: InputImageRotation.rotation90deg,
          inputImageFormat: InputImageFormat.values.elementAt(message[2]),
          planeData: null,
        );

        screenSize = Size(message[3], message[4]);

        sendPort.send('configured');
      }
    },
  );
}
