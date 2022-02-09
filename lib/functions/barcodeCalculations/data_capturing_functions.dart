import 'dart:ui';
import 'package:google_ml_kit/google_ml_kit.dart';

///Calculates the absolute side length of a single barcode
double calculateAverageBarcodeDiagonalLength(BarcodeValue barcodeValue) {
  Rect a = Rect.fromLTRB(
      barcodeValue.boundingBox!.left,
      barcodeValue.boundingBox!.top,
      barcodeValue.boundingBox!.right,
      barcodeValue.boundingBox!.bottom);

  double diagonal1 = (a.bottomRight - a.topLeft).distance;

  double diagonal2 = (a.bottomLeft - a.topRight).distance;

  return (diagonal1 + diagonal2) / 2;
}

///Calculates the OnImage center point of the barcode given the barcode and inputImageData
Offset calculateBarcodeCenterPoint(BarcodeValue barcodeValue) {
  final barcodeCentreX =
      (barcodeValue.boundingBox!.left + barcodeValue.boundingBox!.right) / 2;
  final barcodeCentreY =
      (barcodeValue.boundingBox!.top + barcodeValue.boundingBox!.bottom) / 2;

  final Offset centerOffset = Offset(barcodeCentreX, barcodeCentreY);

  return centerOffset;
}
