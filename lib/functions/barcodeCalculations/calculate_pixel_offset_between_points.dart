import 'dart:ui';

import 'package:flutter_google_ml_kit/objects/qr_code.dart';

Offset calculatePixelOffsetBetweenPoints(QrCode endPoint, QrCode startPoint) {
  return endPoint.barcodeCenterOffset - startPoint.barcodeCenterOffset;
}
