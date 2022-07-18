import 'package:isar/isar.dart';
part 'barcode_property.g.dart';

///Barcode Property
///
///- BarcodeUID (num_timestamp)
///
///- Barcode Side Legth (mm)
@Collection()
class BarcodeProperty {
  int id = Isar.autoIncrement;

  ///UID (num_timestamp)
  late String barcodeUID;

  ///Side length (mm)
  late double size;

  ///==
  @override
  bool operator ==(Object other) {
    return other is BarcodeProperty &&
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
  BarcodeProperty fromJson(Map<String, dynamic> json) {
    return BarcodeProperty()
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
