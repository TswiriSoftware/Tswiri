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

  late double size;

  @override
  String toString() {
    return '\ntimestamp: $timestamp, from: $rangeStart to $rangeEnd, size: $size';
  }

  Map toJson() => {
        'id': id,
        'timestamp': timestamp,
        'rangeStart': rangeStart,
        'rangeEnd': rangeEnd,
      };

  BarcodeGenerationEntry fromJson(Map<String, dynamic> json) {
    return BarcodeGenerationEntry()
      ..id = json['id']
      ..timestamp = json['timestamp'] as int
      ..rangeStart = json['rangeStart'] as int
      ..rangeEnd = json['rangeEnd'] as int;
  }
}
