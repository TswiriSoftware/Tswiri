import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/views/settings/app_settings.dart';

///Calculate the milimeter value of 1 on image unit (OIU). (Pixel ?)
double calculateRealUnit({
  required double diagonalLength,
  required String barcodeUID,
  required List<BarcodeProperty> barcodeProperties,
}) {
  double barcodeDiagonalLength = defaultBarcodeDiagonalLength ?? 100;

  int index = barcodeProperties
      .indexWhere((element) => element.barcodeUID == barcodeUID);

  if (index != -1) {
    barcodeDiagonalLength = barcodeProperties[index].size;
  }

  return diagonalLength / barcodeDiagonalLength;
}
