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
  bool operator ==(Object other) {
    return other is ContainerRelationship &&
        id == other.id &&
        containerUID == other.containerUID &&
        containerUID == other.containerUID &&
        parentUID == other.parentUID;
  }

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

  @override
  int get hashCode => id.hashCode;
}
