import 'dart:ui';

class BarcodeMarker {
  BarcodeMarker({
    required final this.id,
    required final this.position,
    required final this.fixed,
  });

  final String id;
  final bool fixed;
  final Offset position;
}
