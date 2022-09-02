import 'package:isar/isar.dart';
part 'container_tag.g.dart';

///Container Tag
///
/// - User Generated.
@Collection()
@Name("ContainerTag")
class ContainerTag {
  int id = Isar.autoIncrement;

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
