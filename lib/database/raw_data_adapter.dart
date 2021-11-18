import 'package:hive/hive.dart';
part 'raw_data_adapter.g.dart';

@HiveType(typeId: 0)
class QrCodes extends HiveObject {
  QrCodes(
      {required this.uid, required this.vector, required this.createdDated});

  @HiveField(0)
  late String uid;

  @HiveField(1)
  late List vector;

  @HiveField(2)
  late int createdDated;

  @override
  String toString() {
    return '$uid, {${vector[0]}, ${vector[1]}}, $createdDated';
  }
}
