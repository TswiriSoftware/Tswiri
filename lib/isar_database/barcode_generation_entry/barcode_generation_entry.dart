import 'package:isar/isar.dart';
part 'barcode_generation_entry.g.dart';

@Collection()
class BarcodeGenerationEntry {
  ///ID
  int id = Isar.autoIncrement;

  //timestamp
  late int timestamp;

  ///ContainerUID
  late int rangeStart;

  ///ParentUID
  late int rangeEnd;

  @override
  String toString() {
    return 'timestamp: $timestamp,\n from: $rangeStart to $rangeEnd';
  }
}
