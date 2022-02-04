import 'dart:ui';

///Contains 2 barcode ID's and the offset bewteen the barcodes
class RealInterBarcodeOffset {
  RealInterBarcodeOffset(
      {required this.uid,
      required this.uidStart,
      required this.uidEnd,
      required this.interBarcodeOffset,
      required this.distanceFromCamera,
      required this.timestamp});

  ///uidStart_uidEnd
  String uid;

  ///ID of the Start Barcode.
  String uidStart;

  ///ID of the End Barcode.
  String uidEnd;

  ///Offset from start Barcode TO end Barcode
  Offset interBarcodeOffset;

  ///Distance from the camera
  double distanceFromCamera;

  ///Timestamp of when it was created.
  int timestamp;

  @override
  bool operator ==(Object other) {
    return other is RealInterBarcodeOffset && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    // TODO: implement toString
    return '$uid, $interBarcodeOffset, $timestamp';
  }
}
