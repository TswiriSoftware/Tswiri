import 'package:isar/isar.dart';
part 'barcode_property.g.dart';

@Collection()
class BarcodeProperty {
  int id = Isar.autoIncrement;

  late String barcodeUID;

  late double size;

  @override
  String toString() {
    return 'barcodeUID: $barcodeUID: size(mm): $size';
  }

  Map toJson() => {
        'id': id,
        'barcodeUID': barcodeUID,
        'size': size,
      };

  BarcodeProperty fromJson(Map<String, dynamic> json) {
    return BarcodeProperty()
      ..id = json['id']
      ..barcodeUID = json['barcodeUID']
      ..size = json['size'] as double;
  }
}
