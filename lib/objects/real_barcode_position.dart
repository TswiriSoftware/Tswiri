import 'dart:ui';

//TODO: add desctiption & definition

///Used to map out all scanned Data
///
///1. uid                  : String 1
///
///2. interBarcodeOffset   : Offset? (dx, dy)
///
///3. timestamp            : int? millisSinceEpoch
class RealBarcodePosition {
  ///This is the uid of the barcode ex. '1' or '2'
  String uid;

  ///This is the offset between this barcode and the origin (0,0)
  Offset? interBarcodeOffset;

  int? numberOfBarcodesFromOrigin;

  double distanceFromCamera;

  ///This is the timestamp of when the barcode was scanned
  int? timestamp;
  RealBarcodePosition(this.uid, this.interBarcodeOffset,
      this.numberOfBarcodesFromOrigin, this.distanceFromCamera, this.timestamp);

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
    return '$uid, $interBarcodeOffset, $numberOfBarcodesFromOrigin, $timestamp';
  }
}
