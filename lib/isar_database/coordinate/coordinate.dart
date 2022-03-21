import 'package:isar/isar.dart';
part 'coordinate.g.dart';

@Collection()
class Coordinate {
  int id = Isar.autoIncrement;

  //Related barcodeUID.
  late String barcodeUID;

  //X position.
  late double x;
  //Y position.
  late double y;
  //Z position.
  late double z;

  @override
  String toString() {
    return 'barcodeUID: $barcodeUID, X: $x, Y: $y, Z: $z';
  }
}
