import 'package:isar/isar.dart';
part 'container_type.g.dart';

@Collection()
class ContainerType {
  ///ID
  int id = Isar.autoIncrement;

  ///ContainerUID.
  late String containerType;

  ///Container Description.
  late String containerDescription;

  ///Can this container be moved.
  late bool moveable;

  ///Is this container's barcode a marker by defaut.
  late bool enclosing; //Rename enclosing

  ///List of containers that this container can contain.
  late List<String> canContain;

  ///Container color.
  late String containerColor;

  ///A Origin

  @override
  String toString() {
    return '''-------------------------------------
containerType: $containerType,
containerDescription: $containerDescription,
moveable: $moveable, canContain: $canContain,
color $containerColor
-------------------------------------\n''';
  }

  Map toJson() => {
        'id': id,
        'containerType': containerType,
        'containerDescription': containerDescription,
        'moveable': moveable,
        'markerToChilren': enclosing,
        'canContain': canContain,
        'containerColor': containerColor,
      };

  ContainerType fromJson(Map<String, dynamic> json) {
    return ContainerType()
      ..id = json['id']
      ..canContain = (json['canContain'] as List<dynamic>).cast<String>()
      ..containerColor = json['containerColor']
      ..containerDescription = json['containerDescription']
      ..containerType = json['containerType']
      ..enclosing = json['markerToChilren']
      ..moveable = json['moveable'];
  }
}
