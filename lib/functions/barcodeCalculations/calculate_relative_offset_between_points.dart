import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';

///Calculates relative offset between bacrcodes using the absolute offset between the barcodes and the absolute side length of the barcodes.
Offset calculateRelativeOffsetBetweenBarcodes(
    Offset absoluteOffsetBetweenBarcodes, double absoluteSizeOfBarcodes) {
  Offset relativeOffsetBetweenBarcodes =
      (absoluteOffsetBetweenBarcodes) * absoluteSizeOfBarcodes;
  Offset rounded = Offset(
      relativeOffsetBetweenBarcodes.dx, relativeOffsetBetweenBarcodes.dy);
  return rounded;
}
