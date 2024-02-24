import 'dart:math';

import 'package:isar/isar.dart';
part 'cataloged_barcode.g.dart';

///This stores details about a specific barcode.
///
/// - ```barcodeUID``` (num_timestamp).
/// - ```size``` (mm).
/// - ```batchID``` The batch this barcode is part of.
/// - ```diagonalSideLength``` (mm).
@Collection()
@Name("CatalogedBarcode")
class CatalogedBarcode {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String barcodeUUID;
  late String batchUUID;
  late double width; // (mm)
  late double height; // (mm)

  @override
  bool operator ==(Object other) {
    return other is CatalogedBarcode &&
        id == other.id &&
        barcodeUUID == other.barcodeUUID &&
        height == other.height &&
        width == other.width;
  }

  @override
  String toString() {
    return 'UUID: $barcodeUUID, h: $height, w: $width mm \n';
  }

  Map toJson() => {
        'id': id,
        'barcodeUID': barcodeUUID,
        'height': height,
        'width': width,
        'batchUuid': batchUUID,
      };

  CatalogedBarcode fromJson(Map<String, dynamic> json) {
    return CatalogedBarcode()
      ..id = json['id']
      ..barcodeUUID = json['barcodeUID']
      ..height = json['height'] as double
      ..width = json['width'] as double
      ..batchUUID = json['batchUuid'];
  }

  /// UID : diagonal side length.
  Map<String, double> toMap() {
    return {barcodeUUID: diagonalSideLength};
  }

  @override
  int get hashCode => barcodeUUID.hashCode;

  double get diagonalSideLength {
    return sqrt((pow(width, 2)) + (pow(height, 2)));
  }
}
