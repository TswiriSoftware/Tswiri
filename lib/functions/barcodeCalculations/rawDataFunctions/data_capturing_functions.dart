import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/on_image_barcode.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Calculates the absolute average side length of 2 barcodes
double calcAverageAbsoluteSideLength(
    OnImageBarcode qrCodeEnd, OnImageBarcode qrCodeStart) {
  return 1 /
      ((qrCodeEnd.aveBarcodeDiagonalLengthOnImage +
              qrCodeStart.aveBarcodeDiagonalLengthOnImage) /
          2);
}

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

///Determines the end barcode.
///'If the list reaches the last barcode it will wraparound to the first barcode.'
///
OnImageBarcode determineEndQrcode(
    int i, Map<String, OnImageBarcode> scannedBarcodes) {
  OnImageBarcode qrCodeEnd;
  if (i != scannedBarcodes.length - 1) {
    qrCodeEnd = scannedBarcodes.values.elementAt(i + 1);
  } else {
    qrCodeEnd = scannedBarcodes.values.elementAt(0);
  }
  return qrCodeEnd;
}
