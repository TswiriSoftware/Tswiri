// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:flutter_google_ml_kit/objects/working_barcode.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_on_image_data.dart';
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
///Take note that all calculations are done relative the actual image size
barcodeRawOnImageDataInjector(
  List<Barcode> barcodes,
  InputImageData inputImageData,
  Box<dynamic> rawOnImageDataBox,
  Map lookupTableMap,
) {
//TODO: Write documentation for all functions.

  Map<String, WorkingBarcode> scannedBarcodes = {};
  Map<String, InterBarcodeOnImageData> interBarcodeOffsetList = {};

  for (final Barcode barcode in barcodes) {
    bool checkIfBarcodeIsValid() =>
        barcode.value.displayValue != null && barcode.value.boundingBox != null;

    if (checkIfBarcodeIsValid()) {
      WorkingBarcode workingBarcode = WorkingBarcode(
          displayValue: barcode.value.displayValue!,
          onImageBarcodeCenterOffset: calcOnImageBarcodeCenterPoint(
              barcode, inputImageData.size, inputImageData.imageRotation),
          aveBarcodeDiagonalLengthOnImage:
              averageBarcodeDiagonalLength(barcode),
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

          double aveDiagonalSideLength =
              (barcodeStart.aveBarcodeDiagonalLengthOnImage +
                      barcodeEnd.aveBarcodeDiagonalLengthOnImage) /
                  2;

          InterBarcodeOnImageData interBarcodeOffset = InterBarcodeOnImageData(
              startBarcodeID: barcodeStart.displayValue,
              endBarcodeID: barcodeEnd.displayValue,
              aveDiagonalLength: aveDiagonalSideLength,
              interBarcodeOffsetonImage: calculateOffsetBetweenTwoPoints(
                  barcodeEnd.onImageBarcodeCenterOffset,
                  barcodeStart.onImageBarcodeCenterOffset),
              timestamp: barcodeStart.timestamp);

          interBarcodeOffsetList.putIfAbsent(
              '${barcodeStart.displayValue}_${barcodeEnd.displayValue}',
              () => interBarcodeOffset);
        }
      }
    }

    interBarcodeOffsetList.forEach((uid, interBarcodeOffset) {
      OnImageInterBarcodeData onImageInterBarcodeOffsets =
          OnImageInterBarcodeData(
        uid: uid,
        uidStart: interBarcodeOffset.startBarcodeID,
        uidEnd: interBarcodeOffset.endBarcodeID,
        interBarcodeOffset: TypeOffset(
            x: interBarcodeOffset.interBarcodeOffsetonImage.dx,
            y: interBarcodeOffset.interBarcodeOffsetonImage.dy),
        aveDiagonalLength: interBarcodeOffset.aveDiagonalLength,
        timestamp: interBarcodeOffset.timestamp,
      );

      rawOnImageDataBox.put(uid, onImageInterBarcodeOffsets);
    });
  }
}
