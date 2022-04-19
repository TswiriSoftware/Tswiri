import 'package:isar/isar.dart';
part 'real_interbarcode_vector_entry.g.dart';

@Collection()
class RealInterBarcodeVectorEntry {
  int id = Isar.autoIncrement;

  //Related barcodeUID.
  late String startBarcodeUID;

  late String endBarcodeUID;

  //Timestamp.
  late int timestamp;

  //Creation Timestamp
  late int creationTimestamp;

  //X vector.
  late double x; //Make nullale ?
  //Y vector.
  late double y; //Make nullable ?
  //Z vector.
  late double z; //Make nullable ?

  @override
  String toString() {
    return '\nstartBarcodeUID: $startBarcodeUID,\nendBarcodeUID: $endBarcodeUID,\nX: $x, Y: $y, Z: $z, time: $timestamp';
  }

  Map toJson() => {
        'id': id,
        'startBarcodeUID': startBarcodeUID,
        'endBarcodeUID': endBarcodeUID,
        'x': x,
        'y': y,
        'z': z,
        'timestamp': timestamp,
        'creationTimestamp': creationTimestamp,
      };

  RealInterBarcodeVectorEntry fromJson(Map<String, dynamic> json) {
    return RealInterBarcodeVectorEntry()
      ..id = json['id']
      ..startBarcodeUID = json['startBarcodeUID']
      ..endBarcodeUID = json['endBarcodeUID']
      ..x = json['z'] as double
      ..y = json['y'] as double
      ..z = json['z'] as double
      ..timestamp = json['timestamp'] as int
      ..creationTimestamp = json['creationTimestamp'] as int;
  }
}
