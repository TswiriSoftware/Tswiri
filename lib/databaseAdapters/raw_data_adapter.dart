import 'package:hive/hive.dart';
part 'raw_data_adapter.g.dart';

@HiveType(typeId: 0)
class RelativeQrCodes extends HiveObject {
  RelativeQrCodes(
      {required this.uid,
      required this.uidStart,
      required this.uidEnd,
      required this.x,
      required this.y,
      required this.timestamp});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late String uidStart;

  @HiveField(2)
  late String uidEnd;

  @HiveField(3)
  late double x;

  @HiveField(4)
  late double y;

  @HiveField(5)
  late int timestamp;

  // getList() {
  //   return [uid, X, Y, createdDated];
  // }

  @override
  String toString() {
    return '$uidStart, $uidEnd, $x, $y, $timestamp';
  }
}
