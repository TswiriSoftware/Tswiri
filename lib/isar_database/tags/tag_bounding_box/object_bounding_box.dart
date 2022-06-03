import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
part 'object_bounding_box.g.dart';

@Collection()
class ObjectBoundingBox {
  int id = Isar.autoIncrement;

  ///BoundingBoxID.
  late int mlTagID;

  ///The boundingBox. use rect.fromLTRB
  late List<double> boundingBox;

  @override
  bool operator ==(Object other) {
    return other is ObjectBoundingBox &&
        id == other.id &&
        mlTagID == other.mlTagID &&
        listEquals(boundingBox, other.boundingBox);
  }

  @override
  String toString() {
    return 'boundingBox: $boundingBox, mlTagID: $mlTagID';
  }

  Map toJson() => {
        'id': id,
        'mlTagID': mlTagID,
        'boundingBox': boundingBox,
      };

  ObjectBoundingBox fromJson(Map<String, dynamic> json) {
    return ObjectBoundingBox()
      ..id = json['id']
      ..mlTagID = json['mlTagID']
      ..boundingBox = (json['boundingBox'] as List<dynamic>).cast<double>();
  }
}
