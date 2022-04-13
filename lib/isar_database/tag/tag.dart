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

  Map toJson() => {
        'id': id,
        'tag': tag,
      };

  Tag fromJson(Map<String, dynamic> json) {
    return Tag()
      ..id = json['id']
      ..tag = json['tag'];
  }
}
