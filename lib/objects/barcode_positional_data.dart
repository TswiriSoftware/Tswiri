import 'package:flutter/cupertino.dart';

class BarcodeScreenData {
  BarcodeScreenData(
      {required final this.displayValue,
      required final this.boundingBox,
      required final this.center,
      required final this.absoluteBarcodeSize});

  final String displayValue;
  final Rect boundingBox;
  final Offset center;
  final double absoluteBarcodeSize;
}
