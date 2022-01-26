import 'dart:math';
import 'dart:ui';

import 'package:flutter_google_ml_kit/VisionDetectorViews/painters/coordinates_translator.dart';
import 'package:flutter_google_ml_kit/functions/coordinateTranslator/coordinate_translator.dart';
import 'package:flutter_google_ml_kit/objects/qr_code.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

double calculateAvePixelSizeOfBarcodes(WorkingBarcode qrCodeEnd, WorkingBarcode qrCodeStart) {
  return 1 / ((qrCodeEnd.absoluteAverageBarcodeSideLength + qrCodeStart.absoluteAverageBarcodeSideLength) / 2);
}

double calcAveDisFromCamera(
    double qrCodeStartDistanceFromCamera, double qrCodeEndDistanceFromCamera) {
  return (qrCodeStartDistanceFromCamera + qrCodeEndDistanceFromCamera) / 2;
}

/// 
double absoluteAverageBarcodeSideLength(Barcode barcode) {
  return ((barcode.value.boundingBox!.left - barcode.value.boundingBox!.right)
              .abs() +
          (barcode.value.boundingBox!.top - barcode.value.boundingBox!.bottom)
              .abs()) /
      2;
}

Offset calculateBarcodeCenterPoint(
    Barcode barcode, InputImageData inputImageData, Size screenSize) {
  InputImageRotation rotation = InputImageRotation.Rotation_90deg;
  Size absoluteImageSize = inputImageData.size;

  final boundingBoxLeft = translateXFixed(
      barcode.value.boundingBox!.left, rotation, screenSize, absoluteImageSize);
  final boundingBoxTop = translateYFixed(
      barcode.value.boundingBox!.top, rotation, screenSize, absoluteImageSize);
  final boundingBoxRight = translateXFixed(
      barcode.value.boundingBox!.right, rotation, screenSize, absoluteImageSize);
  final boundingBoxBottom = translateYFixed(
      barcode.value.boundingBox!.bottom, rotation, screenSize, absoluteImageSize);

  final barcodeCentreX = (boundingBoxLeft + boundingBoxRight) / 2;
  final barcodeCentreY = (boundingBoxTop + boundingBoxBottom) / 2;

  final Offset centerOffset = Offset(barcodeCentreX, barcodeCentreY);

  return centerOffset;
}

double calaculateDistanceFormCamera(Rect boundingBox,
    Offset barcodeCenterOffset, Map lookupTable, List<double> imageSizes) {
  double imageSize = (((boundingBox.left - boundingBox.right).abs() +
          (boundingBox.top - boundingBox.bottom).abs()) /
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

WorkingBarcode determineEndQrcode(int i, Map<String, WorkingBarcode> scannedBarcodes) {
  WorkingBarcode qrCodeEnd;
  if (i != scannedBarcodes.length - 1) {
    qrCodeEnd = scannedBarcodes.values.elementAt(i + 1);
  } else {
    qrCodeEnd = scannedBarcodes.values.elementAt(0);
  }
  return qrCodeEnd;
}
