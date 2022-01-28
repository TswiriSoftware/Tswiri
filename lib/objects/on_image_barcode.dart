import 'package:flutter/material.dart';

///Used to create a
class OnImageBarcode {
  OnImageBarcode(
      {required this.displayValue,
      required this.onImageBarcodeCenterOffset,
      required this.aveBarcodeDiagonalLengthOnImage,
      required this.timestamp});

  ///Barcode display value or ID.
  final String displayValue;

  ///Barcode center offset on the image.
  final Offset onImageBarcodeCenterOffset;

  ///Average diagonal length of the barcode on the image.
  late double aveBarcodeDiagonalLengthOnImage;

  ///Timestamp when the barcode was scanned.
  final int timestamp;
}
