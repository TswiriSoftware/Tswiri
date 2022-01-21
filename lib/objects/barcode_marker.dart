import 'dart:math';
import 'package:vector_math/vector_math.dart';
class BarcodeMarker {
  BarcodeMarker(
    {required final this.id,
    required final this.position,
    required final this.fixed,}
  );

  final String id;
  final bool fixed;
  final Vector2 position;
}

