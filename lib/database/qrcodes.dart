import 'package:hive/hive.dart';
import 'package:vector_math/vector_math.dart';
part 'qrcodes.g.dart';

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
    return 'x: ${vector[0]} y: ${vector[1]}, $createdDated';
  }
}
