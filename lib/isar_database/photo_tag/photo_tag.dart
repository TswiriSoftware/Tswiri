import 'package:isar/isar.dart';
part 'photo_tag.g.dart';

@Collection()
class PhotoTag {
  int id = Isar.autoIncrement;

  late String photoPath;

  late int tagUID;

  late double confidence;

  //TODO: Implement this
  late bool blacklisted;

  ///Use Rect.fromLTRB to construct a rect.
  late List<double>? boundingBox;

  @override
  String toString() {
    return '\nphotoPath: $photoPath, tagUID: $tagUID, confidence: $confidence, boundingBox: $boundingBox';
  }

  Map toJson() => {
        'id': id,
        'photoPath': photoPath,
        'tagUID': tagUID,
        'confidence': confidence,
      };

  PhotoTag fromJson(Map<String, dynamic> json) {
    // ignore: avoid_init_to_null
    List<double>? jsonBoundingBox = null;
    if (json['boundingBox'] != null) {
      jsonBoundingBox = (json['boundingBox'] as List<dynamic>).cast<double>();
    }
    return PhotoTag()
      ..id = json['id']
      ..photoPath = json['photoPath']
      ..tagUID = json['tagUID'] as int
      ..confidence = json['confidence'] as double
      ..boundingBox = jsonBoundingBox;
  }
}
