import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';

///Calculates the average distance from the camera of 2 barcodes
double calcAveDisFromCamera(
    double qrCodeStartDistanceFromCamera, double qrCodeEndDistanceFromCamera) {
  return (qrCodeStartDistanceFromCamera + qrCodeEndDistanceFromCamera) / 2;
}

///Returns the list of imageSizes
List<double> getImageSizes(Map lookupTableMap) {
  List<double> imageSizesLookupTable = [];
  lookupTableMap.forEach((key, value) {
    DistanceFromCameraLookupEntry data = value;
    double test = data.onImageBarcodeDiagonalLength;
    imageSizesLookupTable.add(test);
  });

  return imageSizesLookupTable;
}

///This converts the onImage offset to a realOffset
Offset convertOnImageOffsetToRealOffset(
    {required Offset onImageInterBarcodeOffset,
    required double aveDiagonalSideLength}) {
  return onImageInterBarcodeOffset / aveDiagonalSideLength;
}
