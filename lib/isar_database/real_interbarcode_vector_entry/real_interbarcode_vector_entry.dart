import 'package:flutter_google_ml_kit/objects/reworked/real_inter_barcode_data.dart';
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
    return '\nstartBarcodeUID: $startBarcodeUID, endBarcodeUID: $endBarcodeUID,X: $x, Y: $y, Z: $z, time: $timestamp, creation: $creationTimestamp';
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

  RealInterBarcodeVectorEntry fromRealInterBarcodeData(
      RealInterBarcodeData realInterBarcodeData, int creationTimestamp) {
    return RealInterBarcodeVectorEntry()
      ..startBarcodeUID = realInterBarcodeData.startBarcodeUID
      ..endBarcodeUID = realInterBarcodeData.endBarcodeUID
      ..x = realInterBarcodeData.vector3.x
      ..y = realInterBarcodeData.vector3.y
      ..z = realInterBarcodeData.vector3.z
      ..timestamp = realInterBarcodeData.timestamp
      ..creationTimestamp = creationTimestamp;
  }
}
