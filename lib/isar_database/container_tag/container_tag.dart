import 'package:isar/isar.dart';
part 'container_tag.g.dart';

@Collection()
class ContainerTag {
  int id = Isar.autoIncrement;

  //ContainerUID
  late String containerUID;

  //Tag
  late int tagID;

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $tagID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'tagID': tagID,
      };

  ContainerTag fromJson(Map<String, dynamic> json) {
    return ContainerTag()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..tagID = json['tagID'] as int;
  }
}
