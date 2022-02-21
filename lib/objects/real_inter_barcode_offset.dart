import 'dart:ui';

///Contains 2 barcode ID's and the offset bewteen the barcodes
///
///1. uid                : 1_2
///
///2. uidStart           : 1
///
///3. uidEnd             : 2
///
///4. interBarcodeOffset : Offset(dx, dy)
///
///5. distanceFromCamera : 150 (mm)
///
///6. phone orientation  : radians
///
///7. timestamp          : millisSinceEpoch
class RealInterBarcodeOffset {
  RealInterBarcodeOffset(
      {required this.uid,
      required this.uidStart,
      required this.uidEnd,
      required this.realInterBarcodeOffset,
      required this.startBarcodeDistanceFromCamera,
      required this.endBarcodeDistanceFromCamera,
      required this.timestamp,
      this.checksOut});

  ///uidStart_uidEnd
  String uid;

  ///ID of the Start Barcode.
  String uidStart;

  ///ID of the End Barcode.
  String uidEnd;

  ///Offset from start Barcode TO end Barcode
  Offset realInterBarcodeOffset;

  ///Distance from the camera
  double startBarcodeDistanceFromCamera;

  ///Distance from the camera
  double endBarcodeDistanceFromCamera;

  ///Timestamp of when it was created.
  int timestamp;

  ///confirmed as correct
  bool? checksOut;

  @override
  bool operator ==(Object other) {
    return other is RealInterBarcodeOffset && hashCode == other.hashCode;
  }

  @override
  int get hashCode => (uid).hashCode;

  @override
  String toString() {
    return '$uid, ${realInterBarcodeOffset.dx}, ${realInterBarcodeOffset.dy}, $timestamp';
  }
}
