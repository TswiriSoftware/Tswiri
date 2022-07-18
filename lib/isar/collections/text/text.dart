import 'package:isar/isar.dart';
part 'text.g.dart';

@Collection()
class Text {
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

  Text fromJson(Map<String, dynamic> json) {
    return Text()
      ..id = json['id']
      ..text = json['tag'];
  }

  @override
  bool operator ==(Object other) {
    return other is Text && id == other.id && text == other.text;
  }

  @override
  int get hashCode => id.hashCode;
}
