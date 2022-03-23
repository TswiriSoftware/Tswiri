import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/isar_dir.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/photo_tag/photo_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/tag/tag.dart';
import 'package:isar/isar.dart';
import '../container_entry/container_entry.dart';

Isar? isarDatabase;

Isar openIsar() {
  Isar isar = Isar.openSync(
    schemas: [
      ContainerEntrySchema,
      ContainerRelationshipSchema,
      ContainerTypeSchema,
      MarkerSchema,
      TagSchema,
      ContainerTagSchema,
      ContainerPhotoSchema,
      BarcodePropertySchema,
      BarcodeGenerationEntrySchema,
      MlTagSchema,
      PhotoTagSchema,
      RealInterBarcodeVectorEntrySchema,
      BarcodeSizeDistanceEntrySchema
    ],
    directory: isarDirectory!.path,
    inspector: true,
  );
  return isar;
}

Isar? closeIsar(Isar? database) {
  if (database != null) {
    //   if (database.isOpen) {
    database.close();
    return null;
    //   }
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
