import 'package:flutter/material.dart';

///Used to create a
class WorkingBarcode {
  WorkingBarcode(
      {required this.displayValue,
      required this.barcodeCenterOffsetOnImage,
      required this.aveBarcodeDiagonalLengthOnImage,
      required this.timestamp});

  final String displayValue;
  final Offset barcodeCenterOffsetOnImage;
  late double aveBarcodeDiagonalLengthOnImage;
  final int timestamp;

  @override
  String toString() {
    return '$displayValue, $barcodeCenterOffsetOnImage, $timestamp';
  }
}
