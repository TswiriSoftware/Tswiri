import 'package:isar/isar.dart';
part 'real_interbarcode_vector_entry.g.dart';

@Collection()
class RealInterBarcodeVectorEntry {
  int id = Isar.autoIncrement;

  //Related barcodeUID.
  late String startBarcodeUID;

  late String endBarcodeUID;

  //X vector.
  late double x;
  //Y vector.
  late double y;
  //Z vector.
  late double z;

  @override
  String toString() {
    return '\nstartBarcodeUID: $startBarcodeUID,\nendBarcodeUID: $endBarcodeUID,\nX: $x, Y: $y, Z: $z';
  }
}
