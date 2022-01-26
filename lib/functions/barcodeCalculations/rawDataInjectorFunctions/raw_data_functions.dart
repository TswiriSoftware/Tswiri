import 'dart:math';
import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/coordinateTranslator/coordinate_translator.dart';
import 'package:flutter_google_ml_kit/objects/qr_code.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Calculates the average side length of 2 barcodes
double calcAverageSideLength(
    WorkingBarcode qrCodeEnd, WorkingBarcode qrCodeStart) {
  return 1 /
      ((qrCodeEnd.absoluteAverageBarcodeSideLength +
              qrCodeStart.absoluteAverageBarcodeSideLength) /
          2);
}

double calcAveDisFromCamera(
    double qrCodeStartDistanceFromCamera, double qrCodeEndDistanceFromCamera) {
  return (qrCodeStartDistanceFromCamera + qrCodeEndDistanceFromCamera) / 2;
}

///
double absoluteBarcodeSideLength(Barcode barcode) {
  return ((barcode.value.boundingBox!.left - barcode.value.boundingBox!.right)
              .abs() +
          (barcode.value.boundingBox!.top - barcode.value.boundingBox!.bottom)
              .abs()) /
      2;
}

///Calculates the absolute center point of the barcode given the barcode and inputImageData
Offset calculateBarcodeAbsoluteCenterPoint(
    Barcode barcode, InputImageData inputImageData) {
  Size absoluteImageSize = inputImageData.size;

  InputImageRotation rotation = inputImageData.imageRotation;

  final boundingBoxLeft = translateXAbsolute(
      barcode.value.boundingBox!.left, rotation, absoluteImageSize);
  final boundingBoxTop = translateYAbsolute(
      barcode.value.boundingBox!.top, rotation, absoluteImageSize);
  final boundingBoxRight = translateXAbsolute(
      barcode.value.boundingBox!.right, rotation, absoluteImageSize);
  final boundingBoxBottom = translateYAbsolute(
      barcode.value.boundingBox!.bottom, rotation, absoluteImageSize);

  final barcodeCentreX = (boundingBoxLeft + boundingBoxRight) / 2;
  final barcodeCentreY = (boundingBoxTop + boundingBoxBottom) / 2;

  final Offset centerOffset = Offset(barcodeCentreX, barcodeCentreY);

  return centerOffset;
}

///Given barcode barcode
double calaculateDistanceFormCamera(Barcode barcode, Offset barcodeCenterOffset,
    Map lookupTable, List<double> imageSizes) {
  double imageSize = (((barcode.value.boundingBox!.left -
                  barcode.value.boundingBox!.right)
              .abs() +
          (barcode.value.boundingBox!.top - barcode.value.boundingBox!.bottom)
              .abs()) /
      2);

  var greaterThan = imageSizes.where((element) => element >= imageSize).toList()
    ..sort();

  String imageSizeKey = greaterThan.first.toString();

  double distanceFromCamera =
      double.parse(lookupTable[imageSizeKey].toString().split(',').last);

  return distanceFromCamera;
}

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

List<double> getImageSizes(Map lookupTableMap) {
  List<double> imageSizesLookupTable = [];
  lookupTableMap.forEach((key, value) {
    double test = double.parse(key);
    imageSizesLookupTable.add(test);
  });

  return imageSizesLookupTable;
}

WorkingBarcode determineEndQrcode(
    int i, Map<String, WorkingBarcode> scannedBarcodes) {
  WorkingBarcode qrCodeEnd;
  if (i != scannedBarcodes.length - 1) {
    qrCodeEnd = scannedBarcodes.values.elementAt(i + 1);
  } else {
    qrCodeEnd = scannedBarcodes.values.elementAt(0);
  }
  return qrCodeEnd;
}
