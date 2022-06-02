import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';

Offset calculateBarcodeCenterFromBoundingBox(Barcode barcode) {
  double top = barcode.boundingBox!.top;
  double bottom = barcode.boundingBox!.bottom;
  double left = barcode.boundingBox!.left;
  double right = barcode.boundingBox!.right;

  Rect boundingBox = Rect.fromLTRB(left, top, right, bottom);
  return boundingBox.center;
}
