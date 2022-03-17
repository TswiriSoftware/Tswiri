import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
part 'container_type.g.dart';

@Collection()
class ContainerType {
  ///ID
  int id = Isar.autoIncrement;

  ///ContainerUID
  late String containerType;

  ///ParentUID
  late bool structured;

  ///List of containers that this container can contain.
  late List<String> canContain;

  ///Container color.
  late String containerColor;

  @override
  String toString() {
    return 'containerType: $containerType,\nstructured: $structured,\ncanContain: $canContain,\ncolor $containerColor';
  }
}
