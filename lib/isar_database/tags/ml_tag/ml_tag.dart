import 'package:isar/isar.dart';
part 'ml_tag.g.dart';

@Collection()
class MlTag {
  int id = Isar.autoIncrement;

  ///MlTagID.
  late int mlTagID;

  ///TextTagID.
  late int textTagID;

  ///Tag Confidence.
  late double confidence;

  ///TagID
  @MlTagTypeConverter()
  late mlTagType tagType;

  @override
  String toString() {
    return 'tagID: $textTagID, confidence: $confidence';
  }

  Map toJson() => {
        // 'id': id,
        // 'tagID': textTagID,
        // 'tagType': tagType.name,
      };

  // MlTag fromJson(Map<String, dynamic> json) {
  //   return MlTag()
  //     ..id = json['id']
  //     ..textTagID = json['tag']
  //     ..tagType = mlTagType.values.byName(json['tagType']);
  // }
}

enum mlTagType {
  objectLabel,
  imageLabel,
  text,
}

class MlTagTypeConverter extends TypeConverter<mlTagType, int> {
  const MlTagTypeConverter();

  @override
  mlTagType fromIsar(int object) {
    return mlTagType.values[object];
  }

  @override
  int toIsar(mlTagType object) {
    return object.index;
  }
}
