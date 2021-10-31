import 'package:hive/hive.dart';
part 'qrcodes.g.dart';

@HiveType(typeId: 0)
class QrCodes extends HiveObject {
  @HiveField(0)
  late String uid;

  @HiveField(1)
  late DateTime createdDated;
}
