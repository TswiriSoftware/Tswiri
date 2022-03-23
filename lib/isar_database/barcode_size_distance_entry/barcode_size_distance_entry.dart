import 'package:isar/isar.dart';
part 'barcode_size_distance_entry.g.dart';

@Collection()
class BarcodeSizeDistanceEntry {
  int id = Isar.autoIncrement;

  ///Diagonal size.
  late double diagonalSize;

  ///Distance from camera.
  late double distanceFromCamera;

  @override
  String toString() {
    return 'diagonalSize: $diagonalSize,\ndistanceFromCamera: $distanceFromCamera,\n';
  }
}
