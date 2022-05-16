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
  String toString() {
    return 'boundingBox: $boundingBox, mlTagID: $mlTagID';
  }

  // Map toJson() => {
  //       'id': id,
  //       'boundingBox': boundingBox,
  //     };

  // TagBoundingBox fromJson(Map<String, dynamic> json) {
  //   return TagBoundingBox()
  //     ..id = json['id']
  //     ..boundingBox = (json['boundingBox'] as List<dynamic>).cast<double>();
  // }
}
