import 'dart:ui';

///Contains
///
///String : uid
///
///Offset : interBarcodeOffset
///
///double : distance form camera
class RealBarcodePosition {
  ///This is the uid of the barcode ex. '1' or '2'.
  String uid;

  ///This is the offset between this barcode and the origin (0,0).
  Offset? offset;

  ///Distance from the camera.
  double zOffset;

  ///This is the timestamp of when the barcode was scanned
  int? timestamp;
  RealBarcodePosition(
      {required this.uid,
      this.offset,
      required this.zOffset,
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
    return '$uid, $offset, $timestamp';
  }
}
