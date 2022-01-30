// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/accelerometer_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';

import '../mathfunctions/round_to_double.dart';

//TODO: New Sheet.
//RealData  (Stored in box) ****** Majoroty of calulations Real Offset -> Screen Offset;  realOffset * X = screenOffset ;
//ImageData (Stored in box)) ImageOffset -> RealOffset /barcode { uid , size }
//ScreenData * rarley used (Not stored)

//Add barcode size to Database... realBarcodeSize

injectBarcodeSizeData(
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
      CalibrationDataHiveObject calibrationDataInstance =
          CalibrationDataHiveObject(
              timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
              averageDiagonalLength: averageBarcodeDiagonalLength(barcode));

      calibrationDataBox.put(
          calibrationDataInstance.timestamp, calibrationDataInstance);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
}

injectAccelerometerData(int deltaT, double zAcceleration, double distanceMoved,
    Box accelerometerDataBox) {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  AccelerometerDataHiveObject accelerometerDataInstance =
      AccelerometerDataHiveObject(
          timestamp: timestamp,
          deltaT: deltaT,
          accelerometerData: zAcceleration,
          distanceMoved: roundDouble(distanceMoved, 5).abs());

  accelerometerDataBox.put(timestamp.toString(), accelerometerDataInstance);
}
