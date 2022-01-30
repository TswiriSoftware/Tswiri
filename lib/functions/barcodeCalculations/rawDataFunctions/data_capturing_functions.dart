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
double averageBarcodeDiagonalLength(Barcode barcode) {
  double diagonal1 = Offset(
          barcode.value.boundingBox!.left + barcode.value.boundingBox!.top,
          barcode.value.boundingBox!.right + barcode.value.boundingBox!.bottom)
      .distance;
  double diagonal2 = Offset(
          barcode.value.boundingBox!.right + barcode.value.boundingBox!.top,
          barcode.value.boundingBox!.left + barcode.value.boundingBox!.bottom)
      .distance;

  return (diagonal1 + diagonal2) / 2;
}

///Calculates the OnImage center point of the barcode given the barcode and inputImageData
Offset calculateOnImageBarcodeCenterPoint(Barcode barcode) {
  final barcodeCentreX =
      (barcode.value.boundingBox!.left + barcode.value.boundingBox!.right) / 2;
  final barcodeCentreY =
      (barcode.value.boundingBox!.top + barcode.value.boundingBox!.bottom) / 2;

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
