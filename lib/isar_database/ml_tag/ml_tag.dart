import 'package:isar/isar.dart';
part 'ml_tag.g.dart';

@Collection()
class MlTag {
  int id = Isar.autoIncrement;

  late String tag;

  @override
  String toString() {
    return 'tag: $tag';
  }
}
