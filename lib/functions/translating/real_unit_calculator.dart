import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:isar/isar.dart';

///Calculate the milimeter value of 1 on image unit (OIU). (Pixel ?)
double calculateRealUnit(
    {required double diagonalLength, required String barcodeUID}) {
  //If the barcode has not been generated. use default barcode size.
  double barcodeDiagonalLength = isarDatabase!.barcodePropertys
          .filter()
          .barcodeUIDMatches(barcodeUID)
          .findFirstSync()
          ?.size ??
      defaultBarcodeDiagonalLength!;

  return diagonalLength / barcodeDiagonalLength;
}
