import 'package:isar/isar.dart';
part 'container_type.g.dart';

@Collection()
class ContainerType {
  ///ID
  int id = Isar.autoIncrement;

  ///ContainerUID.
  late String containerType;

  ///ContaunerDescription.
  late String containerDescription;

  ///Can this container be moved.
  late bool moveable;

  ///Is this container's barcode a marker by defaut.
  late bool markerToChilren;

  ///List of containers that this container can contain.
  late List<String> canContain;

  ///Container color.
  late String containerColor;

  @override
  String toString() {
    return 'containerType: $containerType,\ncontainerDescription: $containerDescription,\nmoveable: $moveable,\ncanContain: $canContain,\ncolor $containerColor';
  }
}
