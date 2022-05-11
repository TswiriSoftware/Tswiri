import 'package:isar/isar.dart';
part 'tag_bounding_box.g.dart';

@Collection()
class TagBoundingBox {
  int id = Isar.autoIncrement;

  ///BoundingBoxID.
  late int boundingBoxID;

  ///The boundingBox. use rect.fromLTRB
  late List<double> boundingBox;

  @override
  String toString() {
    return 'boundingBox: $boundingBox';
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
