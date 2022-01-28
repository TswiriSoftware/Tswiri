import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';

///Calculates the average distance from the camera of 2 barcodes
double calcAveDisFromCamera(
    double qrCodeStartDistanceFromCamera, double qrCodeEndDistanceFromCamera) {
  return (qrCodeStartDistanceFromCamera + qrCodeEndDistanceFromCamera) / 2;
}

///Calculates how far the barcode is from the camera given calibration data (imageSizes: for sorting, Lookuptable: for Distance from camera)
double calaculateDistanceFormCamera(double barcodeDiagonalSizeOnImage,
    Map lookupTable, List<double> imageSizes) {
  var greaterThan = imageSizes
      .where((element) => element >= barcodeDiagonalSizeOnImage)
      .toList()
    ..sort();

  String imageSizeKey = greaterThan.first.toString();
  MatchedCalibrationData calibrationData = lookupTable[imageSizeKey]!;
  double distanceFromCamera = calibrationData.distance;
  print(distanceFromCamera);
  return distanceFromCamera;
}

///Returns the list of imageSizes
List<double> getImageSizes(Map lookupTableMap) {
  List<double> imageSizesLookupTable = [];
  lookupTableMap.forEach((key, value) {
    MatchedCalibrationData data = value;
    double test = data.objectSize;
    imageSizesLookupTable.add(test);
  });

  return imageSizesLookupTable;
}

///Adds a fixed point to the realData Box
addFixedPoint(RealInterBarcodeData firstPoint,
    Map<String, BarcodeMarker> consolidatedData) {
  consolidatedData.update(
      firstPoint.uidStart,
      (value) => BarcodeMarker(
          id: firstPoint.uidStart, offset: const Offset(0, 0), fixed: true),
      ifAbsent: () => BarcodeMarker(
          id: firstPoint.uidStart,
          offset: const Offset(0, 0),
          fixed: true)); //This is the Fixed Point
}

///This converts the onImage offset to a realOffset
Offset convertOnImageOffsetToRealOffset(
    {required Offset onImageInterBarcodeOffset,
    required double aveDiagonalSideLength}) {
  return onImageInterBarcodeOffset / aveDiagonalSideLength;
}
