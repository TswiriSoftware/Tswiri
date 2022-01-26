import 'package:flutter/material.dart';

///Used to create a
class WorkingBarcode {
  WorkingBarcode(
      {required this.displayValue,
      required this.barcodeAbsoluteCenterOffset,
      required this.absoluteAverageBarcodeSideLength,
      required this.distanceFromCamera,
      required this.timestamp});

  final String displayValue;
  final Offset barcodeAbsoluteCenterOffset;
  late double
      absoluteAverageBarcodeSideLength; //TODO: Pixels ?? This is the average pixel size of the object
  late double distanceFromCamera; //Unit: millimetres
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$displayValue, $barcodeAbsoluteCenterOffset, $distanceFromCamera, $timestamp';
  }
}
