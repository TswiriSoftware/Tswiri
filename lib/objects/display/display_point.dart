import 'dart:ui';

///A DisplayPoint is used by a painter to represent a barcode as a point.
class DisplayPoint {
  DisplayPoint({
    required this.isMarker,
    required this.barcodeUID,
    required this.barcodePosition,
    required this.realBarcodePosition,
  });

  ///BarcodeUID. [String]
  String barcodeUID;

  ///Is it a Marker ? [bool]
  bool isMarker;

  ///On Screen Position. [Offset]
  Offset barcodePosition;

  ///Real position. [List]
  List<double> realBarcodePosition;
}
