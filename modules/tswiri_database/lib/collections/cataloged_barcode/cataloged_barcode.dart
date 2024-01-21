import 'dart:math';

import 'package:isar/isar.dart';
part 'cataloged_barcode.g.dart';

///This stores details about a specific barcode.
///
/// - ```barcodeUID``` (num_timestamp).
/// - ```size``` (mm).
/// - ```batchID``` The batch this barcode is part of.
@Collection()
@Name("CatalogedBarcode")
class CatalogedBarcode {
  Id id = Isar.autoIncrement;

  ///UID (num_timestamp)
  @Name("barcodeUID")
  late String barcodeUID;

  ///Width (mm)
  @Name("width")
  late double width;

  ///Height (mm)
  @Name("height")
  late double height;

  ///Side length (mm)
  @Name("batchID")
  late int batchID;

  @override
  bool operator ==(Object other) {
    return other is CatalogedBarcode &&
        id == other.id &&
        barcodeUID == other.barcodeUID &&
        height == other.height &&
        width == other.width;
  }

  @override
  String toString() {
    return 'UID: $barcodeUID, h: $height, w: $width mm \n';
  }

  ///To json
  Map toJson() =>
      {'id': id, 'barcodeUID': barcodeUID, 'height': height, 'width': width};

  ///From Json
  CatalogedBarcode fromJson(Map<String, dynamic> json) {
    return CatalogedBarcode()
      ..id = json['id']
      ..barcodeUID = json['barcodeUID']
      ..height = json['height'] as double
      ..width = json['width'] as double;
  }

  ///To map
  ///UID : diagonal side length.
  Map<String, double> toMap() => {
        barcodeUID: diagonalSideLength(),
      };

  @override
  int get hashCode => barcodeUID.hashCode;

  double diagonalSideLength() {
    return sqrt((pow(width, 2)) + (pow(height, 2)));
  }
}
