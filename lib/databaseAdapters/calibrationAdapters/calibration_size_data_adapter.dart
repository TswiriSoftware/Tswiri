import 'package:hive/hive.dart';
part 'calibration_size_data_adapter.g.dart';

@HiveType(typeId: 2)
class CalibrationSizeDataHiveObject extends HiveObject {
  CalibrationSizeDataHiveObject({
    required this.timestamp,
    required this.averageDiagonalLength,
  });

  @HiveField(0)
  late String timestamp;

  @HiveField(1)
  late double averageDiagonalLength;
}
