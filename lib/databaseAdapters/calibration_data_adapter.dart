import 'package:hive/hive.dart';
part 'calibration_data_adapter.g.dart';

@HiveType(typeId: 2)
class CalibrationData extends HiveObject {
  CalibrationData({
    required this.timestamp,
    required this.averageDiagonalLength,
  });

  @HiveField(0)
  late String timestamp;

  @HiveField(1)
  late double averageDiagonalLength;
}
