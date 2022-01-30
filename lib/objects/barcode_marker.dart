import 'dart:ui';

class RealBarcodeMarker {
  RealBarcodeMarker({
    required final this.id,
    required final this.offset,
    required final this.distanceFromCamera,
    required final this.fixed,
  });

  final String id;
  final bool fixed;
  final double distanceFromCamera;
  final Offset offset;
}
