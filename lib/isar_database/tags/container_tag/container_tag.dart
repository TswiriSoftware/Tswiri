import 'package:isar/isar.dart';
part 'container_tag.g.dart';

@Collection()
class ContainerTag {
  int id = Isar.autoIncrement;

  //ContainerUID
  late String containerUID;

  //Tag
  late int textTagID;

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $textTagID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'tagID': textTagID,
      };

  ContainerTag fromJson(Map<String, dynamic> json) {
    return ContainerTag()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..textTagID = json['tagID'] as int;
  }
}
