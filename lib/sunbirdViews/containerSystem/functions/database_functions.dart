import 'dart:developer';

import 'package:hive/hive.dart';

import '../../../databaseAdapters/containerAdapter/container_entry_adapter.dart';
import '../../../globalValues/global_hive_databases.dart';

Future<void> updateContainerName(String containerUID, String name) async {
  Box<ContainerEntry> containersBox = await Hive.openBox(containersBoxName);
  ContainerEntry containerEntry = containersBox.get(containerUID)!;
  containerEntry.name = name;
  containersBox.put(containerUID, containerEntry);
}

Future<void> updateContainerDescription(
    String containerUID, String description) async {
  Box<ContainerEntry> containersBox = await Hive.openBox(containersBoxName);
  ContainerEntry containerEntry = containersBox.get(containerUID)!;
  containerEntry.description = description;
  containersBox.put(containerUID, containerEntry);
}

Future<void> updateContainerParent(
    String containerUID, String? parentUID) async {
  Box<ContainerEntry> containersBox = await Hive.openBox(containersBoxName);
  ContainerEntry containerEntry = containersBox.get(containerUID)!;
  containerEntry.parentUID = parentUID;
  containersBox.put(containerUID, containerEntry);
}

Future<void> updateContainerChildren(
    String containerUID, Set<String> children) async {
  Box<ContainerEntry> containersBox = await Hive.openBox(containersBoxName);
  ContainerEntry containerEntry = containersBox.get(containerUID)!;
  Set<String> containerChildren = containerEntry.children?.toSet() ?? {};
  containerChildren.addAll(children);
  log(containerChildren.toString());
  containerEntry.children = containerChildren.toList();
  containersBox.put(containerUID, containerEntry);
}
