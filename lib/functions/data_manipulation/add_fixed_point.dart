import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:vector_math/vector_math.dart';

addFixedPoint(Map<String, BarcodeMarker> consolidatedData) {
  consolidatedData.update('1',
      (value) => BarcodeMarker(id: '1', position: Vector2(0, 0), fixed: true),
      ifAbsent: () => BarcodeMarker(
          id: '1',
          position: Vector2(0, 0),
          fixed: true)); //This is the Fixed Point
}
