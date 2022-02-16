import 'dart:ui';

class RealBarcodePosition {
  ///This is the uid of the barcode ex. '1' or '2'.
  String uid;

  ///This is the offset between this barcode and the origin (0,0).
  Offset? interBarcodeOffset;

  ///Distance from the camera.
  double distanceFromCamera;

  ///This is the timestamp of when the barcode was scanned
  int? timestamp;
  RealBarcodePosition(
      {required this.uid,
      this.interBarcodeOffset,
      required this.distanceFromCamera,
      this.timestamp});

  @override
  bool operator ==(Object other) {
    return other is RealBarcodePosition && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    // ignore: todo
    // TODO: implement toString
    return '$uid, $interBarcodeOffset, $timestamp';
  }
}
