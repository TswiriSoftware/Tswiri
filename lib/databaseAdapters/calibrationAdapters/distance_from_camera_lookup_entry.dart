import 'package:hive/hive.dart';
part 'matched_calibration_data_adapter.g.dart';

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
  });

  //TODO: actual barcode diagonal length (key) , 

  @HiveField(0)
  late double onImageBarcodeDiagonalLength;

  @HiveField(1)
  late double distanceFromCamera;

  getList() {
    return [onImageBarcodeDiagonalLength, distanceFromCamera];
  }

  @override
  String toString() {
    return '$onImageBarcodeDiagonalLength, $distanceFromCamera';
  }
}
