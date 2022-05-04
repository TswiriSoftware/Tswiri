import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/translating/offset_rotation.dart';
import 'package:flutter_google_ml_kit/isolate/painter_data.dart';
import 'package:flutter_google_ml_kit/objects/navigation/grid_object.dart';
import 'package:flutter_google_ml_kit/objects/navigation/isolate_grid_object.dart';
import 'package:flutter_google_ml_kit/objects/reworked/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/reworked/on_image_data.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:vector_math/vector_math.dart' as vm;

void navigatorImageProcessorIsolate(SendPort sendPort) {
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
        selectedBarcodeUID != null &&
        initialGrids != null) {
      InputImage inputImage = InputImage.fromBytes(
          bytes:
              (message[1] as TransferableTypedData).materialize().asUint8List(),
          inputImageData: inputImageData!);

      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      List<dynamic> barcodeData = [];
      Offset? realScreenCenter;
      List<PainterBarcodeData> painterBarcodeDatas = [];

      double? averageDiagonalLength;

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
            ),
          ),
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
        if (averageDiagonalLength == null) {
          averageDiagonalLength = onImageDiagonalLength;
        } else {
          averageDiagonalLength =
              (averageDiagonalLength + onImageDiagonalLength) / 2;
        }

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

        //Update average offset to screen center.
        if (realScreenCenter == null) {
          realScreenCenter = realOffsetToScreenCenter;
        } else {
          realScreenCenter = (realScreenCenter + realOffsetToScreenCenter) / 2;
        }

        List<double> onImageOffsetPoints = [
          //On Screen Points [1].
          offsetPoints[0].dx,
          offsetPoints[0].dy,
          offsetPoints[1].dx,
          offsetPoints[1].dy,
          offsetPoints[2].dx,
          offsetPoints[2].dy,
          offsetPoints[3].dx,
          offsetPoints[3].dy,
        ];

        painterBarcodeDatas.add(
          PainterBarcodeData(
              barcodeUID: barcode.value.displayValue!,
              rect: onImageOffsetPoints),
        );
      }

      //Select applicable grid.
      IsolateGridObject workingGrid = initialGrids!
          .where(
              (element) => element.getBarcodes().contains(selectedBarcodeUID))
          .first;

      double finderCircleRadius = ((averageDiagonalLength ?? 300) / 3);

      Offset? offsetToBarcode = workingGrid.calculateOffsetToBarcde(
          realScreenCenter: realScreenCenter, barcodeUID: selectedBarcodeUID!);

      Offset arrowLineStart = Offset(0, 0);
      Offset arrowLineHead = Offset(0, 0);

      if (offsetToBarcode != null) {
        arrowLineStart = Offset(
            canvasSize!.width / 2 + finderCircleRadius, realScreenCenter!.dy);

        //End position of the arrow line
        arrowLineHead = Offset(
            arrowLineStart.dx + offsetToBarcode.distance - finderCircleRadius,
            realScreenCenter.dy);
      }

      PainterData painterData = PainterData(
        selectedBarcode: selectedBarcodeUID!,
        finderCircleRadius: finderCircleRadius,
        arrowLineStart: arrowLineStart,
        arrowLineHead: arrowLineHead,
        offsetToBarcodeAngle: offsetToBarcode?.direction ?? 0,
        canvasSize: canvasSize!,
        painterBarcodeData: painterBarcodeDatas,
      );

      //   //Calcualte position.
      // if (navigatorData.isNotEmpty) {
      //   Offset offsetToBarcode = workingGrid.calculateOffsetToBarcde(
      //       navigatorData: navigatorData, barcodeUID: containerEntry.barcodeUID!);

      //   if (offsetToBarcode.distance >= finderCircleRadius) {
      //     //Draw arrow
      //     //Start position of the arrow line.
      //     Offset arrowLineStart =
      //         Offset(screenCenter.dx + finderCircleRadius, screenCenter.dy);

      //     //End position of the arrow line
      //     Offset arrowLineHead = Offset(
      //         arrowLineStart.dx + offsetToBarcode.distance - finderCircleRadius,
      //         screenCenter.dy);

      //     //ArrowHeadtop
      //     Offset arrowHeadtop =
      //         Offset(arrowLineHead.dx - 30, arrowLineHead.dy + 20);

      //     //ArrowHeadBottom
      //     Offset arrowHeadbottom =
      //         Offset(arrowLineHead.dx - 30, arrowLineHead.dy - 20);

      //     //Translate canvas to screen center.
      //     canvas.translate(screenCenter.dx, screenCenter.dy);
      //     //Rotate the canvas.
      //     canvas.rotate(offsetToBarcode.direction);
      //     //Translate the canvas back to original position
      //     canvas.translate(-screenCenter.dx, -screenCenter.dy);

      //     //Draw the arrow
      //     canvas.drawLine(
      //         arrowLineStart, arrowLineHead, paintEasy(Colors.blue, 3.0));
      //     canvas.drawLine(
      //         arrowLineHead, arrowHeadtop, paintEasy(Colors.blue, 3.0));
      //     canvas.drawLine(
      //         arrowLineHead, arrowHeadbottom, paintEasy(Colors.blue, 3.0));
      //   }
      // }

      sendPort.send(jsonEncode(painterData.toJson()));
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
      } else if (message[0] == 'process') {
        //Process the image.
        processImage(message);
      } else if (message[0] == 'config') {
        log('configured');
        //Configure InputImageData.
        inputImageData = InputImageData(
          size: Size(
            message[1],
            message[2],
          ), //Note width and height are flipped because of rotation.
          imageRotation: InputImageRotation.Rotation_90deg,
          inputImageFormat: InputImageFormat.values.elementAt(message[5]),
          planeData: null,
        );

        canvasSize = Size(message[3], message[4]);
        selectedBarcodeUID = message[6];
        barcodeProperties = message[7];

        //This is the initial set of grids.
        List<dynamic> parsedListJson = jsonDecode(message[8]);
        initialGrids = List<IsolateGridObject>.from(
            parsedListJson.map((e) => IsolateGridObject.fromJson(e)));

        sendPort.send('configured');
      } else if (message[0] == 'update') {
        log('grid update');
      }
    },
  );
}
        // barcodeData.add([
        //   barcode.value.displayValue, //Display value. [0]
        // [
        //   //On Screen Points [1].
        //   offsetPoints[0].dx,
        //   offsetPoints[0].dy,
        //   offsetPoints[1].dx,
        //   offsetPoints[1].dy,
        //   offsetPoints[2].dx,
        //   offsetPoints[2].dy,
        //   offsetPoints[3].dx,
        //   offsetPoints[3].dy,
        // ],
        //   [
        //     //On Image Points [2].
        //     cornerPoints[0].x.toDouble(), // Point1. x
        //     cornerPoints[0].y.toDouble(), // Point1. y
        //     cornerPoints[1].x.toDouble(), // Point2. x
        //     cornerPoints[1].y.toDouble(), // Point2. y
        //     cornerPoints[2].x.toDouble(), // Point3. x
        //     cornerPoints[2].y.toDouble(), // Point3. y
        //     cornerPoints[3].x.toDouble(), // Point4. x
        //     cornerPoints[3].y.toDouble(), // Point5. y
        //   ],
        //   [
        //     // Accelerometer Data [3].
        //     message[2][0], //accelerometerEvent.x
        //     message[2][1], //accelerometerEvent.y
        //     message[2][2], //accelerometerEvent.z
        //     message[2][3], //userAccelerometerEvent.x
        //     message[2][4], //userAccelerometerEvent.y
        //     message[2][5], //userAccelerometerEvent.z
        //   ],
        //   [
        //     // Offset to Screen Center [4].
        //     realOffset.dx,
        //     realOffset.dy,
        //   ],
        //   onImageDiagonalLength, //OnImage Diagonal Length [5].
        //   barcodeDiagonalLength, //final double dialogballegth; [6]
        //   startBarcodeMMperPX, //BarcodeMMperPX [7]
        //   message[3], // timeStamp [8].
        // ]);