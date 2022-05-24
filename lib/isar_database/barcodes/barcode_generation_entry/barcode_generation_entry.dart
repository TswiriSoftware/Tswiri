import 'dart:convert';

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

  //Barcode Size
  late double size;

  late List<String> barcodeUIDs;

  @override
  String toString() {
    return '\ntimestamp: $timestamp, from: $rangeStart to $rangeEnd, size: $size';
  }

  Map toJson() => {
        'id': id,
        'timestamp': timestamp,
        'rangeStart': rangeStart,
        'rangeEnd': rangeEnd,
        'size': size,
        'barcodeUIDs': jsonEncode(barcodeUIDs)
      };

  BarcodeGenerationEntry fromJson(Map<String, dynamic> json) {
    return BarcodeGenerationEntry()
      ..id = json['id']
      ..timestamp = json['timestamp'] as int
      ..rangeStart = json['rangeStart'] as int
      ..rangeEnd = json['rangeEnd'] as int
      ..size = json['size'] as double
      ..barcodeUIDs =
          (jsonDecode(json['barcodeUIDs']) as List<dynamic>).cast<String>();
  }
}
