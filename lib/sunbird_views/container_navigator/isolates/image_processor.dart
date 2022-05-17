import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/painting.dart';
import 'package:flutter_google_ml_kit/functions/translating/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/image_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/image_processor_config.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_navigator/isolates/messages/painter_message.dart';
import 'dart:math' as math;
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../objects/reworked/on_image_data.dart';

void imageProcessor(List initialMessage) {
  //1. SendPort and ID.
  SendPort sendPort = initialMessage[0];
  int id = initialMessage[1];

  //2. ReceivePort.
  ReceivePort receivePort = ReceivePort();

  //3. UI-Config
  sendPort.send([
    'ip_ui_config', //Identifier [0]
    id, //ID [1]
    receivePort.sendPort, //Sendport [2]
  ]);

  //4. Open Isar.
  // Isar isar = openIsar(directory: initialMessage[2], inspector: false);

  // //5. Get Barcode Properties.
  // List<BarcodeProperty> barcodeProperties =
  //     isar.barcodePropertys.where().findAllSync();

  // //7. Get InterBarcodeVectors
  // List<InterBarcodeVectorEntry> interBarcodeVectors = isar
  //     .interBarcodeVectorEntrys
  //     .filter()
  //     .outDatedEqualTo(false)
  //     .findAllSync();

  // //6. Configure FocalLength.
  // double focalLength = initialMessage[3];

  //7. BarcodeScanner
  BarcodeScanner barcodeScanner =
      GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  //8. selectedBarcodeUID
  String? selectedBarcodeUID = initialMessage[4];

  // //9. DefualtbarcodeSize.
  // double defaultBarcodeSize = initialMessage[5];

  //10. Image Config
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

    log('IP$id: InputImageData Configured');
  }

  void processImage(message) async {
    if (inputImageData != null &&
        canvasSize != null &&
        absoluteSize != null &&
        selectedBarcodeUID != null) {
      //1. Decode Message.
      ImageMessage imageDataMessage = ImageMessage.fromMessage(message);

      //2. Decode ImageBytes.
      InputImage inputImage = InputImage.fromBytes(
          bytes: imageDataMessage.bytes, inputImageData: inputImageData!);

      //3. Scan Image.
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      //4. Compile Painter Message
      List<PainterBarcodeObject> painterData = [];
      double? averageBarcodeDiagonalLength;
      //Offset? averageOffsetToBarcode;

      List<OnImageBarcodeData> onImageBarcodeDatas = [];

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

        //3. Calculate barcodeDiagonalLength.
        double onImageDiagonalLength = onImageBarcodeData.barcodeDiagonalLength;
        onImageBarcodeDatas.add(onImageBarcodeData);

        //4. Painter Message
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
      }

      PainterMesssage painterMessage = PainterMesssage(
        averageDiagonalLength: averageBarcodeDiagonalLength ?? 100,
        painterData: painterData,
        //averageOffsetToBarcode: averageOffsetToBarcode ?? const Offset(0, 0),
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
