import 'package:hive/hive.dart';
part 'raw_data_adapter.g.dart';

@HiveType(typeId: 0)
class QrCodes extends HiveObject {
  QrCodes(
      {required this.uid,
      required this.X,
      required this.Y,
      required this.createdDated});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late double X;

  @HiveField(2)
  late double Y;

  @HiveField(3)
  late int createdDated;

  // getList() {
  //   return [uid, X, Y, createdDated];
  // }

  @override
  String toString() {
    return '$uid, $X, $Y, $createdDated';
  }
}
