import 'package:flutter/cupertino.dart';

class BarcodePositionalData {
  BarcodePositionalData(
      {required final this.topRight,
      required final this.topLeft,
      required final this.bottomRight,
      required final this.bottomLeft,
      required final this.center,
      required final this.barcodePixelSize});

  final Offset topRight;
  final Offset topLeft;
  final Offset bottomRight;
  final Offset bottomLeft;
  final Offset center;
  final double barcodePixelSize;
}

//TODO: convert to named