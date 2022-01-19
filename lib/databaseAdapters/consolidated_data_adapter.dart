import 'package:hive/hive.dart';
part 'consolidated_data_adapter.g.dart';

@HiveType(typeId: 1)
class ConsolidatedData extends HiveObject {
  ConsolidatedData(
      {required this.uid,
      required this.X,
      required this.Y,
      required this.timeStamp,
      required this.fixed});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late double X;

  @HiveField(2)
  late double Y;

  @HiveField(3)
  late int timeStamp;

  @HiveField(4)
  late bool fixed;

  getList() {
    return [uid, X, Y, fixed];
  }

  @override
  String toString() {
    return '$uid, $X, $Y, $fixed';
  }
}
