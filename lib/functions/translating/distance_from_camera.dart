import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/views/settings/app_settings.dart';

double calculateDistanceFromCamera(
    {required double barcodeOnImageDiagonalLength,
    required String barcodeUID,
    required double focalLength,
    //required Isar isarDatabase,
    required List<BarcodeProperty> barcodeProperties}) {
  double barcodeDiagonalLength = defaultBarcodeDiagonalLength ?? 100;

  int index = barcodeProperties
      .indexWhere((element) => element.barcodeUID == barcodeUID);

  if (index != -1) {
    barcodeDiagonalLength = barcodeProperties[index].size;
  }

  //Calculate the distance from the camera
  double distanceFromCamera =
      focalLength * barcodeDiagonalLength / barcodeOnImageDiagonalLength;

  return distanceFromCamera;
}
