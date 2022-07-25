import 'dart:convert';

import 'package:isar/isar.dart';
part 'barcode_batch.g.dart';

@Collection()
@Name("BarcodeBatch")
class BarcodeBatch {
  int id = Isar.autoIncrement;

  //Generation Time.
  @Name("timestamp")
  late int timestamp;

  ///Range Start.
  @Name("startUID")
  late int startUID;

  ///Range End.
  @Name("endUID")
  late int endUID;

  ///Barcode Size.
  @Name("size")
  late double size;

  ///List of barcodeUID's.
  @Name("barcodeUIDs")
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
