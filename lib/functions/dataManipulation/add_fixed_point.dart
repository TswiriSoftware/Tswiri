import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_vector.dart';
import 'package:vector_math/vector_math.dart';

addFixedPoint(InterBarcodeVector firstPoint,
    Map<String, BarcodeMarker> consolidatedData) {
  consolidatedData.update(
      firstPoint.startQrCode,
      (value) => BarcodeMarker(
          id: firstPoint.startQrCode, position: Vector2(0, 0), fixed: true),
      ifAbsent: () => BarcodeMarker(
          id: firstPoint.startQrCode,
          position: Vector2(0, 0),
          fixed: true)); //This is the Fixed Point
}
