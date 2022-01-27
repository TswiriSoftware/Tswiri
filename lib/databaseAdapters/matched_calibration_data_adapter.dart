import 'package:hive/hive.dart';
part 'matched_calibration_data_adapter.g.dart';

@HiveType(typeId: 4)
class CalibrationData extends HiveObject {
  CalibrationData({
    required this.objectSize,
    required this.distance,
  });

  @HiveField(0)
  late double objectSize;

  @HiveField(1)
  late double distance;

  getList() {
    return [objectSize, distance];
  }

  @override
  String toString() {
    return '$objectSize, $distance';
  }
}
