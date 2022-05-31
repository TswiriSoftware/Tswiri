import 'dart:ui';

///This is used to display a grid to scale on a canvas
class DisplayPoint {
  DisplayPoint(
      {required this.barcodeUID,
      required this.screenPosition,
      required this.realPosition});

  ///BarcodeUID. [String]
  String barcodeUID;

  ///On Screen Position. [Offset]
  Offset screenPosition;

  ///Real position. [List]
  List<double> realPosition;

  @override
  String toString() {
    return 'Barcode: $barcodeUID';
  }
}
