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

  late double? x;
  late double? y;
  late double? z;

  @override
  String toString() {
    return '\nGridUID: $gridUID, BarcodeUID: $barcodeUID, X:$x, Y:$y, Z:$z';
  }

  Vector3? vector() {
    if (x != null && y != null && z != null) {
      return Vector3(x!, y!, z!);
    }
    return null;
  }

  Map toJson() => {
        'id': id,
        'timestamp': timestamp,
        'barcodeUID': barcodeUID,
        'gridUID': gridUID,
        'x': x,
        'y': y,
        'z': z
      };

  CoordinateEntry fromJson(Map<String, dynamic> json) {
    return CoordinateEntry()
      ..id = json['id']
      ..timestamp = json['timestamp'] as int
      ..barcodeUID = json['barcodeUID']
      ..gridUID = json['gridUID']
      ..x = json['x'] as double
      ..y = json['y'] as double
      ..z = json['z'] as double;
  }
}
