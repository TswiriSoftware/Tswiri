import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class qrcodes extends HiveObject {
  @HiveField(0)
  late String UID;

  @HiveField(1)
  late DateTime createdDated;
}
