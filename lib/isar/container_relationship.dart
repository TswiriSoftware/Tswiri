import 'package:isar/isar.dart';
part 'container_relationship.g.dart';

@Collection()
class ContainerRelationship {
  ///ID
  int id = Isar.autoIncrement;

  ///ContainerUID
  late String containerUID;

  ///ParentUID
  late String? parentUID;

  @override
  String toString() {
    return 'containerUID: $containerUID,\nparentUID: $parentUID';
  }
}
