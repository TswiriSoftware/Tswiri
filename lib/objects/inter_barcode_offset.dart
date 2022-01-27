import 'package:flutter/gestures.dart';

class InterBarcodeOffset {
  InterBarcodeOffset({
    required final this.startQrCode,
    required final this.endQrCode,
    required final this.offset,
  });

  final String startQrCode;
  final String endQrCode;
  final Offset offset;
}

//TODO: convert to named