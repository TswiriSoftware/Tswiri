import 'package:hive/hive.dart';
part 'calibration_accelerometer_data_adapter.g.dart';


//TODO: Delete

@HiveType(typeId: 3)
class CalibrationAccelerometerDataHiveObject extends HiveObject {
  CalibrationAccelerometerDataHiveObject({
    required this.timestamp,
    required this.deltaT,
    required this.accelerometerData,
    required this.distanceMoved,
  });

  @HiveField(0)
  late int timestamp;

  @HiveField(1)
  late int deltaT;

  @HiveField(2)
  late double accelerometerData;

  @HiveField(3)
  late double distanceMoved;

  getList() {
    return [timestamp, deltaT, accelerometerData, distanceMoved];
  }

  @override
  String toString() {
    return '$timestamp, $deltaT, $accelerometerData, $distanceMoved';
  }
}
