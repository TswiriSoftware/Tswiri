import 'dart:ui';

import 'package:flutter_google_ml_kit/functions/barcodeCalculations/rawDataInjectorFunctions/raw_data_functions.dart';

Offset calculateRelativeOffsetBetweenBarcodes(
    Offset pixelOffsetBetweenBarcodes, double avePixelSizeOfBarcodes) {
  Offset relativeOffsetBetweenBarcodes =
      (pixelOffsetBetweenBarcodes) * avePixelSizeOfBarcodes;
  Offset rounded = Offset(roundDouble(relativeOffsetBetweenBarcodes.dx, 6),
      roundDouble(relativeOffsetBetweenBarcodes.dy, 6));
  return rounded;
}
