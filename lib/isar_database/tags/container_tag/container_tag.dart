import 'package:isar/isar.dart';
part 'container_tag.g.dart';

@Collection()
class ContainerTag {
  int id = Isar.autoIncrement;

  //ContainerUID
  late String containerUID;

  //Tag
  late int textID;

  @override
  bool operator ==(Object other) {
    return other is ContainerTag &&
        id == other.id &&
        containerUID == other.containerUID &&
        textID == other.textID;
  }

  @override
  String toString() {
    return 'UID: $containerUID: Tag: $textID';
  }

  Map toJson() => {
        'id': id,
        'containerUID': containerUID,
        'tagTextID': textID,
      };

  ContainerTag fromJson(Map<String, dynamic> json) {
    return ContainerTag()
      ..id = json['id']
      ..containerUID = json['containerUID']
      ..textID = json['tagTextID'] as int;
  }

  @override
  int get hashCode => id.hashCode;
}