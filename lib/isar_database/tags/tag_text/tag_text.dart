import 'package:isar/isar.dart';
part 'tag_text.g.dart';

@Collection()
class TagText {
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

  TagText fromJson(Map<String, dynamic> json) {
    return TagText()
      ..id = json['id']
      ..tag = json['tag'];
  }
}
