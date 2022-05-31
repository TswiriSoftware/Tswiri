import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/interbarcode_vector.dart';

///2. Generate list of InterbarcodeVector. (Real)
///
///   i. Iterate through onImageInterBarcodeData and generate InterbarcodeVector. (Real)
///
List<InterBarcodeVector> createInterbarcodeVectors(
    List<OnImageInterBarcodeData> onImageInterBarcodeData,
    List<BarcodeProperty> barcodeProperties,
    double focalLength) {
  List<InterBarcodeVector> interBarcodeVectors = [];
  for (OnImageInterBarcodeData interBarcodeData in onImageInterBarcodeData) {
    // i. Iterate through onImageInterBarcodeData and generate IsolateRealInterBarcodeData.
    interBarcodeVectors.add(InterBarcodeVector.fromRawInterBarcodeData(
        interBarcodeData: interBarcodeData,
        barcodeProperties: barcodeProperties,
        focalLength: focalLength));
  }
  return interBarcodeVectors;
}
