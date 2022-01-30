import 'package:hive/hive.dart';
part 'type_offset_adapter.g.dart';

@HiveType(typeId: 5)

///Stores the Type offset in the hive database
class TypeOffsetHiveObject extends HiveObject {
  TypeOffsetHiveObject({
    required this.x,
    required this.y,
  });

  //Offset dx value
  @HiveField(0)
  late double x;

  //Offset dy value
  @HiveField(1)
  late double y;
}
