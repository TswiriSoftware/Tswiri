import 'package:hive/hive.dart';
part 'vector_3_entry_adapter.g.dart';

@HiveType(typeId: 11)

///Stores the Type offset in the hive database
class Vector3Entry extends HiveObject {
  Vector3Entry({
    required this.x,
    required this.y,
    required this.z,
  });

  @HiveField(0)
  late double x;

  @HiveField(1)
  late double y;

  @HiveField(2)
  late double z;

  @override
  String toString() {
    // TODO: implement toString
    return 'x: $x,\ny: $y,\nz: $z';
  }
}
