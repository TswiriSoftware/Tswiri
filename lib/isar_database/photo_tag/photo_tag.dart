import 'package:isar/isar.dart';
part 'photo_tag.g.dart';

@Collection()
class PhotoTag {
  int id = Isar.autoIncrement;

  late String photoPath;

  late int tagUID;

  late double confidence;

  ///Use Rect.fromLTRB to construct a rect.
  late List<double>? boundingBox;

  @override
  String toString() {
    return 'photoPath: $photoPath, tagUID: $tagUID';
  }
}
