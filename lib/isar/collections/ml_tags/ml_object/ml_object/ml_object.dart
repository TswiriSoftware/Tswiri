import 'dart:ui';

import 'package:isar/isar.dart';
part 'ml_object.g.dart';

@Collection()
@Name("MLObject")
class MLObject {
  int id = Isar.autoIncrement;

  ///PhotoID.
  @Name("photoID")
  late int photoID;

  ///Bounding Box.
  ///The boundingBox. use rect.fromLTRB
  @Name("boundingBox")
  late List<double> boundingBox;

  @override
  String toString() {
    return '\nObjectID: $id, PhotoID: $photoID, BoundingBox: $boundingBox';
  }

  @override
  bool operator ==(Object other) {
    return other is MLObject &&
        id == other.id &&
        photoID == other.photoID &&
        boundingBox == other.boundingBox;
  }

  Map toJson() => {
        'id': id,
        'photoID': photoID,
        'blackListed': boundingBox,
      };

  MLObject fromJson(Map<String, dynamic> json) {
    return MLObject()
      ..id = json['id']
      ..photoID = json['photoID']
      ..boundingBox = json['blackListed'];
  }

  @override
  int get hashCode => id.hashCode;

  Rect getBoundingBox() {
    return Rect.fromLTRB(
        boundingBox[0], boundingBox[1], boundingBox[2], boundingBox[3]);
  }
}
