import 'dart:convert';
import 'package:vector_math/vector_math.dart';
import 'package:isar/isar.dart';
part 'coordinate_entry.g.dart';

@Collection()
class CoordinateEntry {
  ///ID
  int id = Isar.autoIncrement;

  //timestamp
  late int timestamp;

  //Barcode UID
  late String barcodeUID;

  //Grid UID.
  late String gridUID;

  late double x;
  late double y;
  late double z;

  @override
  String toString() {
    return '\nGridUID: $gridUID, BarcodeUID: $barcodeUID, X:$x, Y:$y, Z:$z';
  }

  Vector3 vector() {
    return Vector3(x, y, z);
  }

  // Map toJson() => {
  //       'id': id,
  //       'timestamp': timestamp,
  //       'rangeStart': rangeStart,
  //       'rangeEnd': rangeEnd,
  //       'size': size,
  //       'barcodeUIDs': jsonEncode(barcodeUIDs)
  //     };

  // Coordiante fromJson(Map<String, dynamic> json) {
  //   return Coordiante()
  //     ..id = json['id']
  //     ..timestamp = json['timestamp'] as int
  //     ..rangeStart = json['rangeStart'] as int
  //     ..rangeEnd = json['rangeEnd'] as int
  //     ..size = json['size'] as double
  //     ..barcodeUIDs =
  //         (jsonDecode(json['barcodeUIDs']) as List<dynamic>).cast<String>();
  // }
}
