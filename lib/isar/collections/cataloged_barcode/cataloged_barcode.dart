import 'package:isar/isar.dart';
part 'cataloged_barcode.g.dart';

///Barcode Property
///
/// - BarcodeUID (num_timestamp)
///
/// - Barcode Side Legth (mm)
@Collection()
@Name("CatalogedBarcode")
class CatalogedBarcode {
  int id = Isar.autoIncrement;

  ///UID (num_timestamp)
  @Name("barcodeUID")
  late String barcodeUID;

  ///Side length (mm)
  @Name("size")
  late double size;

  ///Side length (mm)
  @Name("batchID")
  late int batchID;

  @override
  bool operator ==(Object other) {
    return other is CatalogedBarcode &&
        id == other.id &&
        barcodeUID == other.barcodeUID &&
        size == other.size;
  }

  @override
  String toString() {
    return 'UID: $barcodeUID, Side length: $size mm \n';
  }

  ///To json
  Map toJson() => {
        'id': id,
        'barcodeUID': barcodeUID,
        'size': size,
      };

  ///From Json
  CatalogedBarcode fromJson(Map<String, dynamic> json) {
    return CatalogedBarcode()
      ..id = json['id']
      ..barcodeUID = json['barcodeUID']
      ..size = json['size'] as double;
  }

  ///To map
  ///UID : Size
  Map<String, double> toMap() => {
        barcodeUID: size,
      };

  @override
  int get hashCode => barcodeUID.hashCode;
}
