import 'package:hive/hive.dart';
part 'type_offset_adapter.g.dart';

@HiveType(typeId: 5)
class TypeOffset extends HiveObject {
  TypeOffset({
    required this.x,
    required this.y,
  });

  @HiveField(0)
  late double x;

  @HiveField(1)
  late double y;
}
