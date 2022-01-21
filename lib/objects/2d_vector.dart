
import 'dart:math';
import 'package:vector_math/vector_math.dart';

class InterBarcodeVector {
  InterBarcodeVector(
    @required this.startQrCode,
    @required this.endQrCode,
    @required this.vector,
  );

  final String startQrCode;
  final String endQrCode;
  final Vector2 vector;

}

//TODO: convert to named