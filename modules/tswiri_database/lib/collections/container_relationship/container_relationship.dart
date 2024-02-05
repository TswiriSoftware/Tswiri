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

  late String containerUUID;

  /// Parent container UUID if this is empty then this container is a root container.
  late String? parentUUID;

  @override
  bool operator ==(Object other) {
    return other is ContainerRelationship &&
        id == other.id &&
        containerUUID == other.containerUUID &&
        containerUUID == other.containerUUID &&
        parentUUID == other.parentUUID;
  }

  @override
  String toString() {
    return '\ncontainerUID: $containerUUID, parentUID: $parentUUID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUUID,
        'parentUID': parentUUID,
      };

  ContainerRelationship fromJson(Map<String, dynamic> json) {
    return ContainerRelationship()
      ..id = json['id']
      ..containerUUID = json['containerUID']
      ..parentUUID = json['parentUID'];
  }

  @override
  int get hashCode => id.hashCode;
}
