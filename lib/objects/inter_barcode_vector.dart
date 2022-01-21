import 'package:vector_math/vector_math.dart';

class InterBarcodeVector {
  InterBarcodeVector({
    required final this.startQrCode,
    required final this.endQrCode,
    required final this.vector,
  });

  final String startQrCode;
  final String endQrCode;
  final Vector2 vector;
}

//TODO: convert to named