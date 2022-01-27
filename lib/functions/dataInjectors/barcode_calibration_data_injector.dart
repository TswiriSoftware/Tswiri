// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

//TODO: New Sheet.
//RealData  (Stored in box) ****** Majoroty of calulations Real Offset -> Screen Offset;  realOffset * X = screenOffset ;
//ImageData (Stored in box)) ImageOffset -> RealOffset /barcode { uid , size }
//ScreenData * rarley used (Not stored)

//Add barcode size to Database... realBarcodeSize

class BarcodeCalibrationInjector {
  BarcodeCalibrationInjector(
      this.barcodes, this.absoluteImageSize, this.rotation);

  final List<Barcode> barcodes;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
}

injectCalibrationData(
  BuildContext context,
  List<Barcode> barcodes,
  Size absoluteImageSize,
  InputImageRotation rotation,
  Box<dynamic> calibrationDataBox,
) {
  for (final Barcode barcode in barcodes) {
    bool checkIfBarcodeIsValid() =>
        barcode.value.displayValue != null && barcode.value.boundingBox != null;
    if (checkIfBarcodeIsValid()) {
      var diagonalLength = averageBarcodeDiagonalLength(barcode);

      CalibrationData calibrationDataInstance = CalibrationData(
          timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
          averageDiagonalLength: diagonalLength,
          timestampInt: DateTime.now().millisecondsSinceEpoch);

      print(calibrationDataInstance.timestamp);

      calibrationDataBox.put(
          calibrationDataInstance.timestamp, calibrationDataInstance);

      // calibrationDataBox.put(
      //     calibrationDataInstance.timestamp, calibrationDataInstance);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
}
