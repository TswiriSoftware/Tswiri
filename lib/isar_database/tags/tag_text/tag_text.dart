import 'package:isar/isar.dart';
part 'tag_text.g.dart';

@Collection()
class TagText {
  int id = Isar.autoIncrement;

  late String text;

  @override
  String toString() {
    return 'tag: $text';
  }

  Map toJson() => {
        'id': id,
        'tag': text,
      };

  TagText fromJson(Map<String, dynamic> json) {
    return TagText()
      ..id = json['id']
      ..text = json['tag'];
  }

  @override
  bool operator ==(Object other) {
    return other is TagText && id == other.id && text == other.text;
  }
}
