import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';

///Origin has a position of 0, 0.
RealBarcodePosition origin(List<RealBarcodePosition> realBarcodePositions) {
  return RealBarcodePosition(
    uid: '1',
    interBarcodeOffset: const Offset(0, 0),
    timestamp: 0,
    distanceFromCamera: realBarcodePositions
        .where((element) => element.uid == '1')
        .first
        .distanceFromCamera,
  );
}
