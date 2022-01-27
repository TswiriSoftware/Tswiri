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
  List<Barcode> barcodes,
  InputImageData inputImageData,
  Box<dynamic> rawDataBox,
  Map lookupTableMap,
) {
//TODO: Write documentation for all functions.

  Map<String, WorkingBarcode> scannedBarcodes = {};
  Map<String, BarcodesOffset> qrCodeVectorsList = {};

  //Map lookupTableMap = lookupTableBox.toMap();
  List<double> imageSizesLookupTable = getImageSizes(lookupTableMap);

  for (final Barcode barcode in barcodes) {
    bool checkIfBarcodeIsValid() =>
        barcode.value.displayValue != null && barcode.value.boundingBox != null;

    if (checkIfBarcodeIsValid()) {
      Offset barcodeAbsoluteCenterOffset = calculateAbsoluteBarcodeCenterPoint(
          barcode, inputImageData.size, inputImageData.imageRotation);

      double distanceFromCamera = calaculateDistanceFormCamera(barcode,
           lookupTableMap, imageSizesLookupTable);

      WorkingBarcode workingBarcode = WorkingBarcode(
          displayValue: barcode.value.displayValue!,
          barcodeAbsoluteCenterOffset: barcodeAbsoluteCenterOffset,
          absoluteAverageBarcodeSideLength: absoluteBarcodeSideLength(barcode),
          distanceFromCamera: distanceFromCamera,
          timestamp: DateTime.now().millisecondsSinceEpoch);

      scannedBarcodes.putIfAbsent(
          workingBarcode.displayValue, () => workingBarcode);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
  if (scannedBarcodes.length >= 2) {
    for (var i = 0; i < scannedBarcodes.length; i++) {
      WorkingBarcode barcodeStart = scannedBarcodes.values.elementAt(i);
      for (var k = 0; k < scannedBarcodes.length; k++) {
        if (barcodeStart.displayValue != i.toString()) {
          WorkingBarcode barcodeEnd = determineEndQrcode(i, scannedBarcodes);
          String startQrCodeDisplayValue = barcodeStart.displayValue;
          String endQrCodeDisplayValue = barcodeEnd.displayValue;
          int timestamp = barcodeStart.timestamp;

          double aveDistanceFromCamera = calcAveDisFromCamera(
              barcodeStart.distanceFromCamera, barcodeEnd.distanceFromCamera);

          double aveSideLengthOfBarcodes =
              calcAverageAbsoluteSideLength(barcodeEnd, barcodeStart);

          Offset absoluteOffsetBetweenPoints =
              calculateAbsoluteOffsetBetweenBarcodes(barcodeStart, barcodeEnd);

          Offset relativeOffsetBetweenPoints =
              calculateRelativeOffsetBetweenBarcodes(
                  absoluteOffsetBetweenPoints, aveSideLengthOfBarcodes);

          BarcodesOffset qrCodeVector = BarcodesOffset(
              startQrCode: startQrCodeDisplayValue,
              endQrCode: endQrCodeDisplayValue,
              relativeOffset: relativeOffsetBetweenPoints,
              distanceFromCamera: aveDistanceFromCamera,
              timestamp: timestamp);

          qrCodeVectorsList.putIfAbsent(
              '${barcodeStart.displayValue}_${barcodeEnd.displayValue}',
              () => qrCodeVector);
        }
      }
    }

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
