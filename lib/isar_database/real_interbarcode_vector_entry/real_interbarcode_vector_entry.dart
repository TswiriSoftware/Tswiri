import 'package:isar/isar.dart';
part 'real_interbarcode_vector_entry.g.dart';

@Collection()
class RealInterBarcodeVectorEntry {
  int id = Isar.autoIncrement;

  //Related barcodeUID.
  late String startBarcodeUID;

  late String endBarcodeUID;

  //TODO: implement timestamp.

  //X vector.
  late double x; //Make nullale ?
  //Y vector.
  late double y; //Make nullable ?
  //Z vector.
  late double z; //Make nullable ?

  @override
  String toString() {
    return '\nstartBarcodeUID: $startBarcodeUID,\nendBarcodeUID: $endBarcodeUID,\nX: $x, Y: $y, Z: $z';
  }

  Map toJson() => {
        'id': id,
        'startBarcodeUID': startBarcodeUID,
        'endBarcodeUID': endBarcodeUID,
        'x': x,
        'y': y,
        'z': z,
      };

  RealInterBarcodeVectorEntry fromJson(Map<String, dynamic> json) {
    return RealInterBarcodeVectorEntry()
      ..id = json['id']
      ..startBarcodeUID = json['startBarcodeUID']
      ..endBarcodeUID = json['endBarcodeUID']
      ..x = json['z'] as double
      ..y = json['y'] as double
      ..z = json['z'] as double;
  }
}
