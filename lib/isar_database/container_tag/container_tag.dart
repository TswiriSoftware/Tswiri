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
}
