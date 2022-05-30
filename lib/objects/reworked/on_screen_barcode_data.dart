import 'package:flutter/cupertino.dart';

///Barcode Screen Data contains data related to the on screen image
///
///1. String        : displayValue
///
///2. List<Offset>  : cornerPoints
///
///3. Offset        : center
///
///4. double        : barcodeOnScreenUnits
///
///

class OnScreenBarcodeData {
  OnScreenBarcodeData(
      {required final this.displayValue,
      required final this.cornerPoints,
      required final this.center,
      required final this.barcodeOnScreenUnits});

  ///The BarcodeID
  final String displayValue;

  ///The 4 corner points of the barcode
  final List<Offset> cornerPoints;

  ///The barcode's center offset
  final Offset center;

  ///The barcode's size (On Screen Units)
  final double barcodeOnScreenUnits;
}
