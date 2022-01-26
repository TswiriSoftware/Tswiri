import 'package:flutter/gestures.dart';
import 'package:vector_math/vector_math.dart';

class InterBarcodeVector {
  InterBarcodeVector({
    required final this.startQrCode,
    required final this.endQrCode,
    required final this.offset,
  });

  final String startQrCode;
  final String endQrCode;
  final Offset offset;
}

//TODO: convert to named