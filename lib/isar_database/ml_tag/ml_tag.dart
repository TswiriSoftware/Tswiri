import 'package:isar/isar.dart';
part 'ml_tag.g.dart';

@Collection()
class MlTag {
  int id = Isar.autoIncrement;

  late int tagUID;

  late String tag;

  @override
  String toString() {
    return 'tagUID: $tagUID, tag: $tag';
  }
}
