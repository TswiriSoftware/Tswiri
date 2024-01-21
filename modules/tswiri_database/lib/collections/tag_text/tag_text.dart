import 'package:isar/isar.dart';
part 'tag_text.g.dart';

///TODO: finish commenting.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///
@Collection()
@Name("TagText")
class TagText {
  ///TagTextID.
  Id id = Isar.autoIncrement;

  ///Text.
  @Name("text")
  @Index(unique: true)
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

  @override
  int get hashCode => id.hashCode;
}
