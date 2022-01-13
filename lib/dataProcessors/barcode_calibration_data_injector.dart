// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/accelerometer_data_adapter.dart';
import 'package:flutter_google_ml_kit/database/calibration_data_adapter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
    if (barcode.value.displayValue != null &&
        barcode.value.boundingBox != null) {
      var disPxX =
          (barcode.value.boundingBox!.left - barcode.value.boundingBox!.right)
              .abs();
      var disPxY =
          (barcode.value.boundingBox!.top - barcode.value.boundingBox!.bottom)
              .abs();

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      CalibrationData calibrationDataInstance =
          CalibrationData(X: disPxX, Y: disPxY, timestamp: timestamp);
      calibrationDataBox.put(timestamp.toString(), calibrationDataInstance);
    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
  }
}

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
