import 'package:flutter/material.dart';

///Used to create a
class OnImageBarcodeData {
  OnImageBarcodeData(
      {required this.displayValue,
      required this.barcodeCenterOffset,
      required this.averageBarcodeDiagonalLength,
      required this.timestamp});

  ///Barcode display value or ID.
  final String displayValue;

  ///Barcode center offset on the image.
  final Offset barcodeCenterOffset;

  ///Average diagonal length of the barcode on the image.
  late double averageBarcodeDiagonalLength;

  ///Timestamp when the barcode was scanned.
  final int timestamp;
}
