import 'package:flutter/material.dart';
import 'package:tswiri_database/collections/container_type/container_type.dart';

enum DefaultContainerType {
  area(
    uuid: 'default_area_uuid',
    name: 'Area',
    description:
        "- An Area is a stationary container with a marker.\n- which can contain all other types of containers.\n- It is part of the children's grid.",
    moveable: false,
    enclosing: false,
    canContain: [
      shelfUUID,
      drawerUUID,
      boxUUID,
    ],
    preferredChild: shelfUUID,
    color: Colors.deepOrange,
    iconData: Icons.aspect_ratio_sharp,
  ),
  shelf(
    uuid: 'default_shelf_uuid',
    name: 'Shelf',
    description:
        "- A Shelf is a stationary container with a marker.\n- which can contain Boxes and/or Drawers.\n- It is part of the children's grid.",
    moveable: false,
    enclosing: false,
    canContain: [
      drawerUUID,
      boxUUID,
    ],
    preferredChild: drawerUUID,
    color: Colors.green,
    iconData: Icons.shelves,
  ),
  drawer(
    uuid: 'default_drawer_uuid',
    name: 'Drawer',
    description:
        "- A Drawer is a stationary container.\n- which can contain boxes.\n- It does not form part of the children's grid.",
    moveable: false,
    enclosing: true,
    canContain: [
      boxUUID,
    ],
    preferredChild: boxUUID,
    color: Colors.blue,
    iconData: Icons.view_module_sharp,
  ),
  box(
    uuid: 'default_box_uuid',
    name: 'Box',
    description: "A box is a movable container.",
    moveable: true,
    enclosing: true,
    canContain: [
      boxUUID,
    ],
    preferredChild: '',
    color: Color(0xFFF98866),
    iconData: Icons.inventory_2_outlined,
  );

  const DefaultContainerType({
    required this.uuid,
    required this.name,
    required this.description,
    required this.moveable,
    required this.enclosing,
    required this.canContain,
    required this.preferredChild,
    required this.color,
    required this.iconData,
  });

  final String uuid;
  final String name;
  final String description;
  final bool moveable;
  final bool enclosing;
  final List<String> canContain;
  final String preferredChild;
  final Color color;
  final IconData iconData;

  static const areaUUID = 'default_area_uuid';
  static const shelfUUID = 'default_shelf_uuid';
  static const drawerUUID = 'default_drawer_uuid';
  static const boxUUID = 'default_box_uuid';
}

List<ContainerType> generateDefaultContainerTypes() {
  final types = DefaultContainerType.values.map(
    (e) {
      return ContainerType()
        ..uuid = e.uuid
        ..canContain = e.canContain
        ..color = IsarColor(value: e.color.value)
        ..description = e.description
        ..enclosing = e.enclosing
        ..iconData = IsarIcon(
          codePoint: e.iconData.codePoint,
          fontFamily: e.iconData.fontFamily,
        )
        ..moveable = e.moveable
        ..name = e.name
        ..preferredChild = e.preferredChild;
    },
  ).toList();

  return types;
}
