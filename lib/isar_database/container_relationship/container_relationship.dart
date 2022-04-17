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
    return '\ncontainerUID: $containerUID, parentUID: $parentUID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'parentUID': parentUID,
      };

  ContainerRelationship fromJson(Map<String, dynamic> json) {
    return ContainerRelationship()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..parentUID = json['parentUID'];
  }
}
