import 'dart:ui';

///This is used to display a grid to scale on a canvas
class DisplayPoint {
  DisplayPoint({
    required this.barcodeUID,
    required this.screenPosition,
    required this.realPosition,
    required this.type,
  });

  ///BarcodeUID. [String]
  String barcodeUID;

  ///On Screen Position. [Offset]
  Offset screenPosition;

  ///Real position. [List]
  List<String> realPosition;

  DisplayPointType type;

  @override
  String toString() {
    return 'Barcode: $barcodeUID';
  }
}

enum DisplayPointType {
  marker,
  selected,
  normal,
  unkown,
}
