import 'dart:convert';

import 'package:isar/isar.dart';
part 'generated_barcodes.g.dart';

@Collection()
class BarcodeBatch {
  int id = Isar.autoIncrement;

  //Generation Time
  late int timestamp;

  ///Range Start
  late int startUID;

  ///Range End
  late int endUID;

  //Barcode Size
  late double size;

  late List<String> barcodeUIDs;

  @override
  String toString() {
    return '\ntimestamp: $timestamp, from: $startUID to $endUID, size: $size';
  }

  Map toJson() => {
        'id': id,
        'timestamp': timestamp,
        'rangeStart': startUID,
        'rangeEnd': endUID,
        'size': size,
        'barcodeUIDs': jsonEncode(barcodeUIDs)
      };

  BarcodeBatch fromJson(Map<String, dynamic> json) {
    return BarcodeBatch()
      ..id = json['id']
      ..timestamp = json['timestamp'] as int
      ..startUID = json['rangeStart'] as int
      ..endUID = json['rangeEnd'] as int
      ..size = json['size'] as double
      ..barcodeUIDs =
          (jsonDecode(json['barcodeUIDs']) as List<dynamic>).cast<String>();
  }
}
