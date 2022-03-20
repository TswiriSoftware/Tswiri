import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/isar_dir.dart';
import 'package:flutter_google_ml_kit/isar/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar/container_type/container_type.dart';
import 'package:isar/isar.dart';

import '../../globalValues/global_colours.dart';
import '../container_isar/container_isar.dart';

Isar openIsar() {
  Isar isar = Isar.openSync(
    schemas: [
      ContainerEntrySchema,
      ContainerRelationshipSchema,
      ContainerTypeSchema
    ],
    directory: isarDirectory!.path,
    inspector: true,
  );
  return isar;
}

Isar? closeIsar(Isar? database) {
  if (database != null) {
    if (database.isOpen) {
      database.close();
      return null;
    }
  }
  return null;
}

//Get containerTypeColor from containerID
Color getContainerTypeColor({required Isar database, required int id}) {
  String contaienrType = database.containerEntrys.getSync(id)!.containerType;

  return Color(int.parse(database.containerTypes
          .filter()
          .containerTypeMatches(contaienrType)
          .findFirstSync()!
          .containerColor))
      .withOpacity(1);
}

//Get containerID from containerUID if it exists.
int? getContainerID(
    {required IsarCollection<ContainerEntry> containerEntrys,
    required String containerUID}) {
  return containerEntrys
      .filter()
      .containerUIDMatches(containerUID)
      .findFirstSync()
      ?.id;
}

ContainerEntry? getParentContainerEntry(
    {required Isar database, required String currentContainerUID}) {
  String? parentContainerUID = database.containerRelationships
      .filter()
      .containerUIDMatches(currentContainerUID)
      .findFirstSync()
      ?.parentUID;
  if (parentContainerUID != null) {
    ContainerEntry? parentContainerEntry = database.containerEntrys
        .filter()
        .containerUIDMatches(parentContainerUID)
        .findFirstSync();
    return parentContainerEntry;
  }
  return null;
}

ContainerRelationship? getContainerRelationship(
    {required Isar database, String? currentContainerUID}) {
  if (currentContainerUID != null) {
    return database.containerRelationships
        .filter()
        .containerUIDMatches(currentContainerUID)
        .findFirstSync();
  }
  return null;
}

List<String>? getContainerChildren(
    {required Isar database, required String currentContainerUID}) {
  return database.containerRelationships
      .filter()
      .parentUIDMatches(currentContainerUID)
      .containerUIDProperty()
      .findAllSync();
}

////////////////////////////////////////////
String? getContainerName(
    {required Isar database, required String containerUID}) {
  return database.containerEntrys
      .filter()
      .containerUIDMatches(containerUID)
      .findFirstSync()
      ?.name;
}

String? getContainerDescription(
    {required Isar database, required String? containerUID}) {
  if (containerUID != null) {
    return database.containerEntrys
        .filter()
        .containerUIDMatches(containerUID)
        .findFirstSync()
        ?.description;
  }
  return null;
}

///Temporary.
void createBoxTypes() {
  Isar database = openIsar();

  database.writeTxnSync((database) {
    database.containerTypes.putSync(
        ContainerType()
          ..id = 1
          ..containerType = 'area'
          ..canContain = ['shelf', 'box', 'drawer']
          ..structured = true
          ..containerColor = poppyOrange.value.toString(),
        replaceOnConflict: true);

    database.containerTypes.putSync(
        ContainerType()
          ..id = 2
          ..containerType = 'shelf'
          ..canContain = ['box', 'drawer']
          ..structured = true
          ..containerColor = Colors.blue.value.toString(),
        replaceOnConflict: true);

    database.containerTypes.putSync(
        ContainerType()
          ..id = 3
          ..containerType = 'drawer'
          ..canContain = ['box', 'shelf']
          ..structured = true
          ..containerColor = springGreen.value.toString(),
        replaceOnConflict: true);

    database.containerTypes.putSync(
        ContainerType()
          ..id = 4
          ..containerType = 'box'
          ..canContain = ['box', 'shelf']
          ..structured = true
          ..containerColor = petalOrange.value.toString(),
        replaceOnConflict: true);
  });

  database.close();
}
