import 'dart:ui';

class RealInterBarcodeData {
  RealInterBarcodeData(
      {required this.uid,
      required this.uidStart,
      required this.uidEnd,
      required this.interBarcodeOffset,
      required this.distanceFromCamera,
      required this.timestamp});

  String uid;
  String uidStart;
  String uidEnd;
  Offset interBarcodeOffset;
  double distanceFromCamera;
  int timestamp;
}
