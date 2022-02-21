import 'package:flutter/rendering.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Calculates the average distance from the camera of 2 barcodes
double calcAveDisFromCamera(
    double qrCodeStartDistanceFromCamera, double qrCodeEndDistanceFromCamera) {
  return (qrCodeStartDistanceFromCamera + qrCodeEndDistanceFromCamera) / 2;
}

///Calculates how far the barcode is from the camera given calibration data (imageSizes: for sorting, Lookuptable: for Distance from camera)
double calaculateDistanceFormCamera(
    double barcodeDiagonalSizeOnImage, SharedPreferences prefs) {
  double m = prefs.getDouble('m') ?? 0;
  double c = prefs.getDouble('c') ?? 0;
  debugPrint('y = x*$m +$c');

  double distanceFromCamera = barcodeDiagonalSizeOnImage * m + c;

  return distanceFromCamera;
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
