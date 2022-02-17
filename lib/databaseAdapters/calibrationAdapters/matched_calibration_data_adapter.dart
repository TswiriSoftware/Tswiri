import 'package:hive/hive.dart';
part 'matched_calibration_data_adapter.g.dart';

@HiveType(typeId: 1)

///Contains
///
///double : objectSize
///
///double : distanceFromCamera
class MatchedCalibrationDataHiveObject extends HiveObject {
  MatchedCalibrationDataHiveObject({
    required this.objectSize,
    required this.distanceFromCamera,
  });

  @HiveField(0)
  late double objectSize;

  @HiveField(1)
  late double distanceFromCamera;

  getList() {
    return [objectSize, distanceFromCamera];
  }

  @override
  String toString() {
    return '$objectSize, $distanceFromCamera';
  }
}
