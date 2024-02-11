import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
part 'container_type.g.dart';

///Specifies details for a specific container type.
///
/// - ```containerTypeName```
/// - ```containerDescription```
/// - ```moveable```
/// - ```enclosing```
/// - ```canContain```
/// - ```preferredChildContainer```
/// - ```containerColor```
/// - ```iconData```
///
@Collection()
@Name("ContainerType")
class ContainerType {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;
  late String name;
  late String description;
  late bool moveable;

  /// Is this container's barcode a marker by default.
  late bool enclosing;

  /// List of container uuids that this container can contain.
  late List<String> canContain;

  /// UUID of the preferred child container.
  late String preferredChild;

  /// Container color.
  late IsarColor color;

  /// Container Icon.
  late IsarIcon iconData;

  @override
  String toString() {
    return '''-------------------------------------
containerType: $name,
containerDescription: $description,
moveable: $moveable, canContain: $canContain
color: $color
iconData: ${iconData.codePoint}
-------------------------------------\n''';
  }

  Map toJson() => {
        'id': id,
        'containerType': name,
        'containerDescription': description,
        'moveable': moveable,
        'enclosing': enclosing,
        'canContain': canContain,
        'containerColor': color,
      };

  ContainerType fromJson(Map<String, dynamic> json) {
    return ContainerType()
      ..id = json['id']
      ..name = json['containerType']
      ..description = json['containerDescription']
      ..enclosing = json['enclosing']
      ..canContain = (json['canContain'] as List<dynamic>).cast<String>()
      ..moveable = json['moveable']
      ..color = json['containerColor'];
  }
}

@embedded
class IsarIcon {
  final int? codePoint;
  final String? fontFamily;

  const IsarIcon({
    this.codePoint,
    this.fontFamily,
  });

  @ignore
  IconData get iconData => IconData(
        codePoint!,
        fontFamily: fontFamily,
      );
}

@embedded
class IsarColor {
  final int? value;

  @ignore
  Color get color => Color(value!);

  const IsarColor({this.value});
}

// class IconConverter extends TypeConverter<IconData, List<String>> {
//   const IconConverter(); // Converters need to have an empty const constructor

//   @override
//   IconData fromIsar(List<String> object) {
//     return IconData(
//       int.parse(object[0]),
//       fontFamily: object[1],
//     );
//   }

//   @override
//   List<String> toIsar(IconData object) {
//     return [
//       object.codePoint.toString(),
//       object.fontFamily.toString(),
//     ];
//   }
// }

// class ColorConverter extends TypeConverter<Color, String> {
//   const ColorConverter(); // Converters need to have an empty const constructor

//   @override
//   Color fromIsar(String object) {
//     return Color(int.parse(object)).withOpacity(1);
//   }

//   @override
//   String toIsar(Color object) {
//     return object.value.toString();
//   }
// }
