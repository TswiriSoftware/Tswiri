import 'dart:ui';

class DisplayPoint {
  DisplayPoint({
    required this.isMarker,
    required this.barcodeID,
    required this.barcodePosition,
    required this.realBarcodePosition,
  });
  String barcodeID;
  bool isMarker;
  Offset barcodePosition;
  List<double> realBarcodePosition;
}
