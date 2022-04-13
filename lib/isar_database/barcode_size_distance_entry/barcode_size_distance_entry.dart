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

  Map toJson() => {
        'id': id,
        'diagonalSize': diagonalSize,
        'distanceFromCamera': distanceFromCamera,
      };

  BarcodeSizeDistanceEntry fromJson(Map<String, dynamic> json) {
    return BarcodeSizeDistanceEntry()
      ..id = json['id']
      ..diagonalSize = json['diagonalSize'] as double
      ..distanceFromCamera = json['distanceFromCamera'] as double;
  }
}
