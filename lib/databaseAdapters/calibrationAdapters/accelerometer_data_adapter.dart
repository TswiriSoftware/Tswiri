import 'package:hive/hive.dart';
part 'accelerometer_data_adapter.g.dart';

@HiveType(typeId: 3)
class AccelerometerDataHiveObject extends HiveObject {
  AccelerometerDataHiveObject({
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
