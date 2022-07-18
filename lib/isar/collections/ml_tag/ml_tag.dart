import 'package:isar/isar.dart';
import 'package:sunbird_v2/isar/isar_database.dart';
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
  bool operator ==(Object other) {
    return other is MlTag &&
        id == other.id &&
        photoID == other.photoID &&
        textID == other.textID &&
        confidence == other.confidence &&
        blackListed == other.blackListed &&
        tagType == other.tagType;
  }

  @override
  String toString() {
    return '\ntag: ${isar!.texts.getSync(textID)?.text}, confidence: $confidence, blacklisted: $blackListed, photoID: $photoID';
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

  @override
  int get hashCode => id.hashCode;
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
