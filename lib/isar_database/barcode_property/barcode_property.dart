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
}
