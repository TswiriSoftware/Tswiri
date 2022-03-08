import 'package:hive/hive.dart';
part 'distance_from_camera_lookup_entry.g.dart';

@HiveType(typeId: 1)

///Contains
///
///double : objectSize
///
///double : distanceFromCamera
class DistanceFromCameraLookupEntry extends HiveObject {
  DistanceFromCameraLookupEntry({
    required this.onImageBarcodeDiagonalLength,
    required this.distanceFromCamera,
    required this.actualBarcodeDiagonalLengthKey,
  });

  @HiveField(0)
  late double onImageBarcodeDiagonalLength;

  @HiveField(1)
  late double distanceFromCamera;

  @HiveField(2)
  late double actualBarcodeDiagonalLengthKey;

  getList() {
    return [onImageBarcodeDiagonalLength, distanceFromCamera];
  }

  @override
  String toString() {
    return '$onImageBarcodeDiagonalLength, $distanceFromCamera';
  }
}
