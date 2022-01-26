import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/qr_code.dart';

///Calculates the absolute Offset Between 2 endBarcode and startBarcode
Offset calculateAbsoluteOffsetBetweenBarcodes(
    WorkingBarcode startPoint, WorkingBarcode endPoint) {
  return endPoint.barcodeAbsoluteCenterOffset -
      startPoint.barcodeAbsoluteCenterOffset;
}
