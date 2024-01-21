import 'package:isar/isar.dart';
part 'photo_label.g.dart';

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
@Name("PhotoLabel")
class PhotoLabel {
  Id id = Isar.autoIncrement;

  ///Photo ID.
  @Name("photoID")
  late int photoID;

  ///The text tag.
  @Name("tagTextID")
  @Index()
  late int tagTextID;

  @override
  bool operator ==(Object other) {
    return other is PhotoLabel &&
        id == other.id &&
        photoID == other.photoID &&
        tagTextID == other.tagTextID;
  }

  @override
  String toString() {
    return 'photoID: $photoID, textID: $tagTextID';
  }

  Map toJson() => {'id': id, 'tagID': photoID, 'textID': tagTextID};

  PhotoLabel fromJson(Map<String, dynamic> json) {
    return PhotoLabel()
      ..id = json['id']
      ..photoID = json['tagID']
      ..tagTextID = json['textID'];
  }

  @override
  int get hashCode => id.hashCode;
}
