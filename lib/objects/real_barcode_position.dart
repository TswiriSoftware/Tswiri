import 'dart:ui';

//TODO: add desctiption & definition

///Used to map out all scanned Data
class RealBarcodePosition {
  ///This is the uid of the barcode ex. '1' or '2'
  String uid;

  ///This is the offset between this barcode and the origin (0,0)
  Offset? interBarcodeOffset;

  ///This is the timestamp of when the barcode was scanned
  ///
  int? timestamp;
  RealBarcodePosition(this.uid, this.interBarcodeOffset, this.timestamp);

  @override
  bool operator ==(Object other) {
    return other is RealBarcodePosition && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return '$uid, ${interBarcodeOffset}, $timestamp';
  }
}
