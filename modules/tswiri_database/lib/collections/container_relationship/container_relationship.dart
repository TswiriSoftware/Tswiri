import 'package:isar/isar.dart';
part 'container_relationship.g.dart';

///TODO: finish commenting.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///

@Collection()
@Name("ContainerRelationship")
class ContainerRelationship {
  Id id = Isar.autoIncrement;

  late String parentContainerUUID;
  late String containerUUID;

  @override
  bool operator ==(Object other) {
    return other is ContainerRelationship &&
        id == other.id &&
        containerUUID == other.containerUUID &&
        containerUUID == other.containerUUID &&
        parentContainerUUID == other.parentContainerUUID;
  }

  @override
  String toString() {
    return '\ncontainerUID: $containerUUID, parentUID: $parentContainerUUID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUUID,
        'parentUID': parentContainerUUID,
      };

  ContainerRelationship fromJson(Map<String, dynamic> json) {
    return ContainerRelationship()
      ..id = json['id']
      ..containerUUID = json['containerUID']
      ..parentContainerUUID = json['parentUID'];
  }

  ContainerRelationship clone() {
    return ContainerRelationship()
      ..id = id
      ..containerUUID = containerUUID
      ..parentContainerUUID = parentContainerUUID;
  }

  @override
  int get hashCode => id.hashCode;
}
