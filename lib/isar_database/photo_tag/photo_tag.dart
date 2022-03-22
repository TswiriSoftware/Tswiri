import 'package:isar/isar.dart';
part 'photo_tag.g.dart';

@Collection()
class PhotoTag {
  int id = Isar.autoIncrement;

  late String photoPath;

  late int tagUID;

  @override
  String toString() {
    return 'photoPath: $photoPath, tagUID: $tagUID';
  }
}
