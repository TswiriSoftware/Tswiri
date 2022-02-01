// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/objects/on_image_barcode.dart';
import 'package:flutter_google_ml_kit/objects/on_image_inter_barcode_data.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

class BarcodeRawOnImageInjector {
  BarcodeRawOnImageInjector(
      this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
}

///Captures a collection of barcodes from a "single frame" and inserts them into a database.
///Take note that all calculations are done relative to the actual image size
barcodeRawOnImageDataInjector(
  List<Barcode> barcodes,
  InputImageData inputImageData,
  Box<dynamic> rawOnImageDataBox,
  List<OnImageInterBarcodeDataHiveObject> allBarcodeData,
) {
//TODO: Write documentation for all functions.

  Map<String, OnImageBarcode> scannedBarcodes = {};
  Map<String, OnImageInterBarcodeData> interBarcodeDataList = {};

  for (final Barcode barcode in barcodes) {
    bool checkIfBarcodeIsValid() =>
        barcode.value.displayValue != null && barcode.value.boundingBox != null;

    if (checkIfBarcodeIsValid()) {
      OnImageBarcode onImageBarcode = OnImageBarcode(
          displayValue: barcode.value.displayValue!,
          onImageBarcodeCenterOffset:
              calculateOnImageBarcodeCenterPoint(barcode),
          aveBarcodeDiagonalLengthOnImage:
              averageBarcodeDiagonalLength(barcode),
          timestamp: DateTime.now().millisecondsSinceEpoch);

      scannedBarcodes.putIfAbsent(
          onImageBarcode.displayValue, () => onImageBarcode);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
  if (scannedBarcodes.length >= 2) {
    for (var i = 0; i < scannedBarcodes.length; i++) {
      OnImageBarcode barcodeStart = scannedBarcodes.values.elementAt(i);
      for (var k = 0; k < scannedBarcodes.length; k++) {
        if (barcodeStart.displayValue != i.toString()) {
          OnImageBarcode barcodeEnd = determineEndQrcode(i, scannedBarcodes);

          OnImageInterBarcodeData interBarcodeData = OnImageInterBarcodeData(
              startBarcodeID: barcodeStart.displayValue,
              endBarcodeID: barcodeEnd.displayValue,
              startDiagonalLength: barcodeStart.aveBarcodeDiagonalLengthOnImage,
              endDiagonalLength: barcodeEnd.aveBarcodeDiagonalLengthOnImage,
              interBarcodeOffsetonImage: calculateOffsetBetweenTwoPoints(
                  barcodeEnd.onImageBarcodeCenterOffset,
                  barcodeStart.onImageBarcodeCenterOffset),
              timestamp: barcodeStart.timestamp);

          interBarcodeDataList.putIfAbsent(
              '${barcodeStart.displayValue}_${barcodeEnd.displayValue}',
              () => interBarcodeData);
        }
      }
    }

    interBarcodeDataList.forEach((uid, interBarcodeInstance) {
      OnImageInterBarcodeDataHiveObject interBarcodeData =
          OnImageInterBarcodeDataHiveObject(
        uid: uid,
        uidStart: interBarcodeInstance.startBarcodeID,
        uidEnd: interBarcodeInstance.endBarcodeID,
        interBarcodeOffset:
            offsetToTypeOffset(interBarcodeInstance.interBarcodeOffsetonImage),
        startDiagonalLength: interBarcodeInstance.startDiagonalLength,
        endDiagonalLength: interBarcodeInstance.endDiagonalLength,
        timestamp: interBarcodeInstance.timestamp,
      );
      allBarcodeData.add(interBarcodeData);
      rawOnImageDataBox.put(uid, interBarcodeData);
    });
  }
}
