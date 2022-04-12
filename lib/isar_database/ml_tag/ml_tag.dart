import 'package:isar/isar.dart';
part 'ml_tag.g.dart';

@Collection()
class MlTag {
  int id = Isar.autoIncrement;

  late String tag;

  @MlTagTypeConverter()
  late mlTagType tagType;

  @override
  String toString() {
    return 'tag: $tag';
  }

  Map toJson() => {
        'id': id,
        'tag': tag,
        'tagType': tagType.name,
      };

  MlTag fromJson(Map<String, dynamic> json) {
    return MlTag()
      ..id = json['id']
      ..tag = json['tag']
      ..tagType = mlTagType.values.byName(json['tagType']);
  }
}

enum mlTagType {
  objectLabel,
  imageLabel,
  text,
}

class MlTagTypeConverter extends TypeConverter<mlTagType, int> {
  const MlTagTypeConverter(); // Converters need to have an empty const constructor

  @override
  mlTagType fromIsar(int object) {
    return mlTagType.values[object];
  }

  @override
  int toIsar(mlTagType object) {
    return object.index;
  }
}
