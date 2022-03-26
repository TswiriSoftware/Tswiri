import 'package:isar/isar.dart';
part 'container_type.g.dart';

@Collection()
class ContainerType {
  ///ID
  int id = Isar.autoIncrement;

  ///ContainerUID
  late String containerType;

  ///Is children structured ?
  ///If a container is structured it means that its children has to be are structured.
  late bool structured;

  //Can this container be its childrens origin ?
  //If it can then it needs a barcode.
  late bool canBeOrigin;

  ///List of containers that this container can contain.
  late List<String> canContain;

  ///Container color.
  late String containerColor;

  @override
  String toString() {
    return 'containerType: $containerType,\nstructured: $structured,\ncanContain: $canContain,\ncolor $containerColor';
  }
}
