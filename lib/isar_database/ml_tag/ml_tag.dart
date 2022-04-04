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
}

enum mlTagType {
  objectLabel,
  imageLabel,
  text,
}

class MlTagTypeConverter extends TypeConverter<mlTagType, int> {
  const MlTagTypeConverter(); // Converters need to have an empty const constructor

  @override
  mlTagType fromIsar(int relationshipIndex) {
    return mlTagType.values[relationshipIndex];
  }

  @override
  int toIsar(mlTagType relationship) {
    return relationship.index;
  }
}
