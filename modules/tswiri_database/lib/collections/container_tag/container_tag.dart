import 'package:isar/isar.dart';
part 'container_tag.g.dart';

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
@Name("ContainerTag")
class ContainerTag {
  Id id = Isar.autoIncrement;

  //ContainerUID
  @Name("containerUID")
  late String containerUID;

  //Tag
  @Name("tagTextID")
  late int tagTextID;

  @override
  bool operator ==(Object other) {
    return other is ContainerTag &&
        id == other.id &&
        containerUID == other.containerUID &&
        tagTextID == other.tagTextID;
  }

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $tagTextID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'tagTextID': tagTextID,
      };

  ContainerTag fromJson(Map<String, dynamic> json) {
    return ContainerTag()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..tagTextID = json['tagTextID'] as int;
  }

  @override
  int get hashCode => id.hashCode;
}
