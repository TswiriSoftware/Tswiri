import 'dart:math';
import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/coordinateTranslator/coordinate_translator.dart';
import 'package:flutter_google_ml_kit/objects/working_barcode.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

///Calculates the absolute average side length of 2 barcodes
double calcAverageAbsoluteSideLength(
    WorkingBarcode qrCodeEnd, WorkingBarcode qrCodeStart) {
  return 1 /
      ((qrCodeEnd.aveBarcodeDiagonalLengthOnImage +
              qrCodeStart.aveBarcodeDiagonalLengthOnImage) /
          2);
}

///Calculates the average distance from the camera of 2 barcodes
double calcAveDisFromCamera(
    double qrCodeStartDistanceFromCamera, double qrCodeEndDistanceFromCamera) {
  return (qrCodeStartDistanceFromCamera + qrCodeEndDistanceFromCamera) / 2;
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

///Calculates the absolute center point of the barcode given the barcode and inputImageData
Offset calcOnImageBarcodeCenterPoint(
    Barcode barcode, Size absoluteImageSize, InputImageRotation rotation) {
  final boundingBoxLeft = translateXOnimage(
      barcode.value.boundingBox!.left, rotation, absoluteImageSize);
  final boundingBoxTop = translateYOnImage(
      barcode.value.boundingBox!.top, rotation, absoluteImageSize);
  final boundingBoxRight = translateXOnimage(
      barcode.value.boundingBox!.right, rotation, absoluteImageSize);
  final boundingBoxBottom = translateYOnImage(
      barcode.value.boundingBox!.bottom, rotation, absoluteImageSize);

  final barcodeCentreX = (boundingBoxLeft + boundingBoxRight) / 2;
  final barcodeCentreY = (boundingBoxTop + boundingBoxBottom) / 2;

  final Offset centerOffset = Offset(barcodeCentreX, barcodeCentreY);

  return centerOffset;
}

///Calculates how far the barcode is from the camera given calibration data (imageSizes: for sorting, Lookuptable: for Distance from camera)
double calaculateDistanceFormCamera(double barcodeDiagonalSizeOnImage,
    Map lookupTable, List<double> imageSizes) {
  var greaterThan = imageSizes
      .where((element) => element >= barcodeDiagonalSizeOnImage)
      .toList()
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

///Returns the list of imageSizes
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
