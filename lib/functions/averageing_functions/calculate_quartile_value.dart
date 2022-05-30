//Calculates the quartile value.
import 'package:flutter_google_ml_kit/isar_database/barcodes/interbarcode_vector_entry/interbarcode_vector_entry.dart';

double calculateQuartileValue(
    List<InterBarcodeVectorEntry> similarInterBarcodeOffsets,
    int quartile1Index,
    double median) {
  return (similarInterBarcodeOffsets[quartile1Index].vector3.length + median) /
      2;
}
