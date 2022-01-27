import 'package:flutter/cupertino.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_real_data.dart';

addFixedPoint(RealInterBarcodeData firstPoint,
    Map<String, BarcodeMarker> consolidatedData) {
  consolidatedData.update(
      firstPoint.uidStart,
      (value) => BarcodeMarker(
          id: firstPoint.uidStart, position: const Offset(0, 0), fixed: true),
      ifAbsent: () => BarcodeMarker(
          id: firstPoint.uidStart,
          position: const Offset(0, 0),
          fixed: true)); //This is the Fixed Point
}
