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

  @override
  String toString() {
    return '''-------------------------------------
containerType: $containerType,
containerDescription: $containerDescription,
moveable: $moveable, canContain: $canContain
color $containerColor
-------------------------------------\n''';
  }

  Map toJson() => {
        'id': id,
        'containerType': containerType,
        'containerDescription': containerDescription,
        'moveable': moveable,
        'enclosing': enclosing,
        'canContain': canContain,
        'containerColor': containerColor,
      };

  ContainerType fromJson(Map<String, dynamic> json) {
    return ContainerType()
      ..id = json['id']
      ..containerType = json['containerType']
      ..containerDescription = json['containerDescription']
      ..enclosing = json['enclosing']
      ..canContain = (json['canContain'] as List<dynamic>).cast<String>()
      ..moveable = json['moveable']
      ..containerColor = json['containerColor'];
  }
}
