import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:isar/isar.dart';
part 'ml_tag.g.dart';

@Collection()
class MlTag {
  int id = Isar.autoIncrement;

  ///MlTagID.
  late int photoID;

  ///TextTagID.
  late int textID;

  ///Tag Confidence.
  late double confidence;

  ///Blacklisted?
  late bool blackListed;

  ///TagID
  @MlTagTypeConverter()
  late MlTagType tagType;

  @override
  String toString() {
    return '\ntag: ${isarDatabase!.tagTexts.getSync(textID)?.text}, confidence: $confidence, blacklisted: $blackListed, photoID: $photoID';
  }

  Map toJson() => {
        'id': id,
        'photoID': photoID,
        'textID': textID,
        'confidence': confidence,
        'blackListed': blackListed,
        'tagType': tagType.name,
      };

  MlTag fromJson(Map<String, dynamic> json) {
    return MlTag()
      ..id = json['id']
      ..photoID = json['photoID']
      ..textID = json['textID']
      ..confidence = json['confidence']
      ..blackListed = json['blackListed']
      ..tagType = MlTagType.values.byName(json['tagType']);
  }
}

enum MlTagType {
  objectLabel,
  imageLabel,
  text,
}

class MlTagTypeConverter extends TypeConverter<MlTagType, int> {
  const MlTagTypeConverter();

  @override
  MlTagType fromIsar(int object) {
    return MlTagType.values[object];
  }

  @override
  int toIsar(MlTagType object) {
    return object.index;
  }
}
