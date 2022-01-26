// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_pixel_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_relative_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';
import 'package:flutter_google_ml_kit/objects/qr_code.dart';
import 'package:flutter_google_ml_kit/objects/qr_code_vectors.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

class BarcodeDatabaseInjector {
  BarcodeDatabaseInjector(this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
}

///Injects a collection of barcodes from a "single frame" into the database. Take note that all calculations are done relative to the screen size and not the actual image size
injectBarcodes(
  BuildContext context, //TODO: change to screenSize
  List<Barcode> barcodes, 
  InputImageData inputImageData,
  Box<dynamic> rawDataBox,
  Box<dynamic> lookupTableBox,
) {


//TODO: Write documentation for all functions. 

  Map<String, WorkingBarcode> scannedBarcodes = {};
  Map<String, QrCodesOffset> qrCodeVectorsList = {};

  Map lookupTableMap = lookupTableBox.toMap();
  List<double> imageSizesLookupTable = getImageSizes(lookupTableMap);
  //print(imageSizesLookupTable);
  Size screenSize = Size(
      MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

  for (final Barcode barcode in barcodes) {

    bool checkIfBarcodeIsValid() => barcode.value.displayValue != null &&
        barcode.value.boundingBox != null;

    if (checkIfBarcodeIsValid()) {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      double absoluteAverageBArcodeSideLength = absoluteAverageBarcodeSideLength(barcode); //TODO: move to working barcode.
      Offset barcodeCenterOffset =
          calculateBarcodeCenterPoint(barcode, inputImageData, screenSize); //TODO: move to working barcode.
      String displayValue = barcode.value.displayValue!;

      Rect barcodeBoundingBox = Rect.fromLTRB(
          barcode.value.boundingBox!.left,
          barcode.value.boundingBox!.top,
          barcode.value.boundingBox!.right,
          barcode.value.boundingBox!.bottom);

      double distanceFromCamera = calaculateDistanceFormCamera(
          barcodeBoundingBox,
          barcodeCenterOffset,
          lookupTableMap,
          imageSizesLookupTable);

      WorkingBarcode workingBarcode = WorkingBarcode(
          displayValue: displayValue,
          barcodeCenterOffset: barcodeCenterOffset,
          absoluteAverageBarcodeSideLength: absoluteAverageBArcodeSideLength,
          distanceFromCamera: distanceFromCamera,
          timestamp: timestamp);

      scannedBarcodes.putIfAbsent(workingBarcode.displayValue, () => workingBarcode);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }

  //print(qrCodeData);
  if (scannedBarcodes.length >= 2) {
    for (var i = 0; i < scannedBarcodes.length; i++) {
      WorkingBarcode qrCodeStart = scannedBarcodes.values.elementAt(i);

      for (var k = 0; k < scannedBarcodes.length; k++) {
        if (qrCodeStart.displayValue != i.toString()) {
          WorkingBarcode qrCodeEnd = determineEndQrcode(i, scannedBarcodes);
          String startQrCodeDisplayValue = qrCodeStart.displayValue;
          String endQrCodeDisplayValue = qrCodeEnd.displayValue;
          int timestamp = qrCodeStart.timestamp;

          double aveDistanceFromCamera = calcAveDisFromCamera(
              qrCodeStart.distanceFromCamera, qrCodeEnd.distanceFromCamera);

          double avePixelSizeOfBarcodes =
              calculateAvePixelSizeOfBarcodes(qrCodeEnd, qrCodeStart);

          Offset pixelOffsetBetweenPoints =
              calculatePixelOffsetBetweenPoints(qrCodeEnd, qrCodeStart);

          Offset relativeOffsetBetweenPoints =
              calculateRelativeOffsetBetweenBarcodes(
                  pixelOffsetBetweenPoints, avePixelSizeOfBarcodes);
          //print('$qrCodeStart , $qrCodeEnd, $relativeOffsetBetweenPoints');

          QrCodesOffset qrCodeVector = QrCodesOffset(
              startQrCode: startQrCodeDisplayValue,
              endQrCode: endQrCodeDisplayValue,
              relativeOffset: relativeOffsetBetweenPoints,
              distanceFromCamera: aveDistanceFromCamera,
              timestamp: timestamp);

          qrCodeVectorsList.putIfAbsent(
              '${qrCodeStart.displayValue}_${qrCodeEnd.displayValue}',
              () => qrCodeVector);
        }
      }
    }
    //print(QrCodeVectorsList.values.toIList());
    qrCodeVectorsList.forEach((key, value) {
      RelativeQrCodes _qrCodeVectors = RelativeQrCodes(
          uid: key,
          uidStart: value.startQrCode,
          uidEnd: value.endQrCode,
          x: value.relativeOffset.dx,
          y: value.relativeOffset.dy,
          timestamp: value.timestamp);
      rawDataBox.put(key, _qrCodeVectors);
    });
  }
}
