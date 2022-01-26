import 'package:flutter/material.dart';

class WorkingBarcode {
  WorkingBarcode(
      {required this.displayValue,
      required this.barcodeCenterOffset,
      required this.absoluteAverageBarcodeSideLength,
      required this.distanceFromCamera,
      required this.timestamp});

  final String displayValue;
  final Offset barcodeCenterOffset;
  late double
      absoluteAverageBarcodeSideLength; //TODO: Pixels ?? This is the average pixel size of the object
  late double distanceFromCamera; //Unit: millimetres
  final int timestamp; //Timestamp

  @override
  String toString() {
    return '$displayValue, $barcodeCenterOffset, $distanceFromCamera, $timestamp';
  }
}

