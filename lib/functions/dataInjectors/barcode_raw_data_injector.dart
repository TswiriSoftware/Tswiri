// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/calculate_pixel_offset_between_points.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';
import 'package:flutter_google_ml_kit/objects/working_barcode.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_on_image_data.dart';
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
  Map<String, InterBarcodeOnImageData> interBarcodeOffsetList = {};

  //Map lookupTableMap = lookupTableBox.toMap();

  for (final Barcode barcode in barcodes) {
    bool checkIfBarcodeIsValid() =>
        barcode.value.displayValue != null && barcode.value.boundingBox != null;

    if (checkIfBarcodeIsValid()) {
      Offset barcodeOnImageCenterOffset = calcOnImageBarcodeCenterPoint(
          barcode, inputImageData.size, inputImageData.imageRotation);

      WorkingBarcode workingBarcode = WorkingBarcode(
          displayValue: barcode.value.displayValue!,
          barcodeCenterOffsetOnImage: barcodeOnImageCenterOffset,
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

          Offset interBarcodeOffsetOnImage = calculateOffsetBetweenBarcodes(
              barcodeEnd.barcodeCenterOffsetOnImage,
              barcodeStart.barcodeCenterOffsetOnImage);

          double aveDiagonalSideLength =
              (barcodeStart.aveBarcodeDiagonalLengthOnImage +
                      barcodeEnd.aveBarcodeDiagonalLengthOnImage) /
                  2;

          InterBarcodeOnImageData interBarcodeOffset = InterBarcodeOnImageData(
              startBarcodeID: barcodeStart.displayValue,
              endBarcodeID: barcodeEnd.displayValue,
              aveDiagonalSideLength: aveDiagonalSideLength,
              interBarcodeOffsetonImage: interBarcodeOffsetOnImage,
              timestamp: barcodeStart.timestamp);

          interBarcodeOffsetList.putIfAbsent(
              '${barcodeStart.displayValue}_${barcodeEnd.displayValue}',
              () => interBarcodeOffset);
        }
      }
    }

    interBarcodeOffsetList.forEach((key, value) {
      OnImageInterBarcodeData onImageInterBarcodeOffsets =
          OnImageInterBarcodeData(
        uid: key,
        uidStart: value.startBarcodeID,
        uidEnd: value.endBarcodeID,
        interBarcodeOffset: TypeOffset(
            x: value.interBarcodeOffsetonImage.dx,
            y: value.interBarcodeOffsetonImage.dy),
        aveDiagonalLength: value.aveDiagonalSideLength,
        timestamp: value.timestamp,
      );

      rawDataBox.put(key, onImageInterBarcodeOffsets);
    });
  }
}
