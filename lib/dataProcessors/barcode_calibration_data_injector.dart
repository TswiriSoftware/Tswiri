// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';
import 'package:fast_immutable_collections/src/base/iterable_extension.dart';
import 'package:fast_immutable_collections/src/imap/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:hive/hive.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'objects.dart';

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
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  for (final Barcode barcode in barcodes) {
    if (barcode.value.displayValue != null &&
        barcode.value.boundingBox != null) {
      int timestamp = 0;
      double zAcceleration = 0;

      var disPxX =
          (barcode.value.boundingBox!.left - barcode.value.boundingBox!.right)
              .abs();
      var disPxY =
          (barcode.value.boundingBox!.top - barcode.value.boundingBox!.bottom)
              .abs();

      timestamp = DateTime.now().millisecondsSinceEpoch;

      // ----
      if (timestamp != 0) {
        var subscription = userAccelerometerEvents.listen((UserAccelerometerEvent event) {
          zAcceleration = event.z;
          CalibrationData calibrationDataInstance = CalibrationData(
              X: disPxX,
              Y: disPxY,
              AccelerometerDataZ: roundDouble(zAcceleration, 6),
              timestamp: timestamp);

          calibrationDataBox.put(timestamp.toString(), calibrationDataInstance);
        });
        subscription.cancel();
      }
      // running in isolate or somewhere on its own. 



    } else {
      throw Exception(
          'Barcode with null displayvalue or boundingbox detected ');
    }
    //userAccelerometerEvents.c
  }
  //print(calibrationDataBox.toMap().toIMap());
}

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
