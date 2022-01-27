import 'package:hive/hive.dart';
part 'calibration_data_adapter.g.dart';

@HiveType(typeId: 2)
class CalibrationData extends HiveObject {
  CalibrationData({
    required this.averageDiagonalLength,
    required this.timestamp,
  });

  @HiveField(0)
  late double averageDiagonalLength;

  @HiveField(1)
  late int timestamp;

  // getList() {
  //   return [X, timestamp];
  // }
}
