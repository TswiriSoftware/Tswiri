import 'package:isar/isar.dart';
part 'object_label.g.dart';
//TODO: finish comments.

///Stores details about a container (Created by user).
///
///  - ```containerUID``` Unique identifier.
///  - ```containerTypeID``` Type of container [ContainerType].
///  - ```name``` Name of the container.
///  - ```description``` Description of the container.
///  - ```barcodeUID``` Barcode linked to this container.
///
@Collection()
@Name("ObjectLabel")
class ObjectLabel {
  Id id = Isar.autoIncrement;

  ///ObjectID.
  @Name("objectID")
  late int objectID;

  ///The text tag.
  @Name("tagTextID")
  @Index()
  late int tagTextID;

  @override
  bool operator ==(Object other) {
    return other is ObjectLabel &&
        id == other.id &&
        objectID == other.objectID &&
        tagTextID == other.tagTextID;
  }

  @override
  String toString() {
    return 'photoID: $objectID, textID: $tagTextID';
  }

  Map toJson() => {'id': id, 'tagID': objectID, 'textID': tagTextID};

  ObjectLabel fromJson(Map<String, dynamic> json) {
    return ObjectLabel()
      ..id = json['id']
      ..objectID = json['tagID']
      ..tagTextID = json['textID'];
  }

  @override
  int get hashCode => id.hashCode;
}
