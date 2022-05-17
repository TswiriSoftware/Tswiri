import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:isar/isar.dart';

double calculateDistanceFromCamera(
    {required double barcodeOnImageDiagonalLength,
    required String barcodeUID,
    required double focalLength,
    required Isar isarDatabase}) {
  //If the barcode has not been generated. use default barcode size.
  double barcodeDiagonalLength = isarDatabase.barcodePropertys
          .filter()
          .barcodeUIDMatches(barcodeUID)
          .findFirstSync()
          ?.size ??
      defaultBarcodeDiagonalLength ??
      100;

  //Calculate the distance from the camera
  double distanceFromCamera =
      focalLength * barcodeDiagonalLength / barcodeOnImageDiagonalLength;

  return distanceFromCamera;
}
