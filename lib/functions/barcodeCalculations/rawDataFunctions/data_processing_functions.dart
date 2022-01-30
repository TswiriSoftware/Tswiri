import 'package:flutter/rendering.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_data.dart';
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
    MatchedCalibrationDataHiveObject data = value;
    double test = data.objectSize;
    imageSizesLookupTable.add(test);
  });

  return imageSizesLookupTable;
}

///Adds a fixed point to the realData Box
addFixedPoint(RealInterBarcodeData firstPoint,
    Map<String, RealBarcodeMarker> consolidatedData) {
  consolidatedData.update(
      firstPoint.uidStart,
      (value) => RealBarcodeMarker(
          id: firstPoint.uidStart,
          offset: const Offset(0, 0),
          fixed: true,
          distanceFromCamera: firstPoint.distanceFromCamera),
      ifAbsent: () => RealBarcodeMarker(
          id: firstPoint.uidStart,
          offset: const Offset(0, 0),
          fixed: true,
          distanceFromCamera:
              firstPoint.distanceFromCamera)); //This is the Fixed Point
}

///This converts the onImage offset to a realOffset
Offset convertOnImageOffsetToRealOffset(
    {required Offset onImageInterBarcodeOffset,
    required double aveDiagonalSideLength}) {
  return onImageInterBarcodeOffset / aveDiagonalSideLength;
}
