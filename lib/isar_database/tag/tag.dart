import 'package:isar/isar.dart';
part 'tag.g.dart';

@Collection()
class Tag {
  int id = Isar.autoIncrement;

  late String tag;

  @override
  String toString() {
    return 'tag: $tag';
  }
}
