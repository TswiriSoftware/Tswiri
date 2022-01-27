import 'dart:ui';

class BarcodeMarker {
  BarcodeMarker({
    required final this.id,
    required final this.offset,
    required final this.fixed,
  });

  final String id;
  final bool fixed;
  final Offset offset;
}
