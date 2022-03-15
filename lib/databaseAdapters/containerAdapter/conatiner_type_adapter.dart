import 'package:hive/hive.dart';
part 'conatiner_type_adapter.g.dart';

@HiveType(typeId: 9)
enum ContainerType {
  @HiveField(0)
  area,

  @HiveField(1)
  cabinet,

  @HiveField(2)
  drawer,

  @HiveField(3)
  shelf,

  @HiveField(4)
  box,

  @HiveField(5)
  custom,
}

String containerTypeToString({required ContainerType containerType}) {
  switch (containerType) {
    case ContainerType.area:
      return 'Area';
    case ContainerType.box:
      return 'Box';
    default:
      return '';
  }
}
