import 'dart:ui';

import 'package:flutter_google_ml_kit/globalValues/global_scaling_factors.dart';

/// Calculates relative offset between bacrcodes given absoluteOffsetBetweenBarcodes and absoluteSizeOfBarcodes
///
/// relativeOffsetBetweenBarcodes = absoluteOffsetBetweenBarcodes * absoluteSizeOfBarcodes * relativeScaleFactor
///
Offset calculateRelativeOffsetBetweenBarcodes(
    Offset absoluteOffsetBetweenBarcodes, double absoluteSizeOfBarcodes) {
  Offset relativeOffsetBetweenBarcodes = (absoluteOffsetBetweenBarcodes) *
      (absoluteSizeOfBarcodes * relativeScaleFactor);

  return relativeOffsetBetweenBarcodes;
}
