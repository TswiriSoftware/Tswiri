import 'package:isar/isar.dart';
part 'camera_calibration_entry.g.dart';

///Camera Calibration Entry
///
/// - ```diagonalSize``` Diagonal Size  of the barcode (mm).
/// - ```distanceFromCamera``` Distance from Camera (mm).
@Collection()
@Name("CameraCalibrationEntry")
class CameraCalibrationEntry {
  Id id = Isar.autoIncrement;

  ///Diagonal size.
  @Name("diagonalSize")
  late double diagonalSize;

  ///Distance from camera.
  @Name("distanceFromCamera")
  late double distanceFromCamera;

  @override
  bool operator ==(Object other) {
    return other is CameraCalibrationEntry &&
        id == other.id &&
        diagonalSize == other.diagonalSize &&
        distanceFromCamera == other.distanceFromCamera;
  }

  @override
  String toString() {
    return 'diagonalSize: $diagonalSize,\ndistanceFromCamera: $distanceFromCamera,\n';
  }

  Map toJson() => {
        'id': id,
        'diagonalSize': diagonalSize,
        'distanceFromCamera': distanceFromCamera,
      };

  CameraCalibrationEntry fromJson(Map<String, dynamic> json) {
    return CameraCalibrationEntry()
      ..id = json['id']
      ..diagonalSize = json['diagonalSize'] as double
      ..distanceFromCamera = json['distanceFromCamera'] as double;
  }

  @override
  int get hashCode => id.hashCode;
}
