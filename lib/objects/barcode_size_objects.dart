import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataFunctions/data_capturing_functions.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Timestamp and Barcode;
class BarcodeData {
  BarcodeData({
    required this.timestamp,
    required this.barcode,
  });

  ///Time of Creation
  int timestamp;

  ///Barcode value (this includes size etc.)
  Barcode barcode;

  double get averageBarcodeDiagonalLength {
    double averageBarcodeDiagonalLength =
        calculateAverageBarcodeDiagonalLength(barcode.value);

    return averageBarcodeDiagonalLength;
  }
}

///Timestamp and averageBarcodeDiagonalLength
class OnImageBarcodeSize {
  OnImageBarcodeSize({
    required this.timestamp,
    required this.averageBarcodeDiagonalLength,
  });

  ///Time of Creation
  int timestamp;

  ///Barcode value (this includes size etc.)
  double averageBarcodeDiagonalLength;

  @override
  String toString() {
    return '$timestamp, $averageBarcodeDiagonalLength';
  }
}
