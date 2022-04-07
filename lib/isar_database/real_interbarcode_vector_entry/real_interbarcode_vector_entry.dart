import 'package:isar/isar.dart';
part 'real_interbarcode_vector_entry.g.dart';

@Collection()
class RealInterBarcodeVectorEntry {
  int id = Isar.autoIncrement;

  //Related barcodeUID.
  late String startBarcodeUID;

  late String endBarcodeUID;

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
}
