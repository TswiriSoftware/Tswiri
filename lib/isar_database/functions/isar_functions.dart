import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo/container_photo.dart';
import 'package:flutter_google_ml_kit/isar_database/container_photo_thumbnail/container_photo_thumbnail.dart';
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

///Isar dir
Directory? isarDirectory;

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
      BarcodeSizeDistanceEntrySchema,
      ContainerPhotoThumbnailSchema,
    ],
    directory: isarDirectory!.path,
    inspector: true,
  );
  return isar;
}

void createBasicContainerTypes() {
  if (isarDatabase!.containerTypes.where().findAllSync().length <= 1) {
    isarDatabase!.writeTxnSync(
      (database) {
        database.containerTypes.putSync(
            ContainerType()
              ..id = 1
              ..containerType = 'area'
              ..containerDescription =
                  '- An Area is a stationary container with a marker.\n- which can contain all other types of containers.'
              ..canContain = ['shelf', 'box', 'drawer']
              ..moveable = false
              ..markerToChilren = true
              ..containerColor = const Color(0xFFff420e).value.toString(),
            replaceOnConflict: true);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 2
              ..containerType = 'shelf'
              ..containerDescription =
                  '- A Shelf is a stationary container with a marker.\n- which can contain Boxes and/or Drawers.'
              ..canContain = ['box', 'drawer']
              ..moveable = false
              ..markerToChilren = true
              ..containerColor = const Color(0xFF89da59).value.toString(),
            replaceOnConflict: true);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 3
              ..containerType = 'drawer'
              ..containerDescription =
                  '- A Drawer is a stationary container.\n- which can container shelfs or boxes.'
              ..canContain = ['box', 'shelf']
              ..moveable = false
              ..markerToChilren = false
              ..containerColor = Colors.blue.value.toString(),
            replaceOnConflict: true);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 4
              ..containerType = 'box'
              ..containerDescription = '- A Box is a moveable container.'
              ..canContain = ['box', 'shelf']
              ..moveable = true
              ..markerToChilren = false
              ..containerColor = const Color(0xFFF98866).value.toString(),
            replaceOnConflict: true);
      },
    );
  }
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

///Get containerTypeColor from containerUID.
Color getContainerColor({required String containerUID}) {
  String? containerType = isarDatabase!.containerEntrys
      .filter()
      .containerUIDMatches(containerUID)
      .findFirstSync()!
      .containerType;

  Color containerTypeColor = Color(int.parse(isarDatabase!.containerTypes
          .filter()
          .containerTypeMatches(containerType)
          .findFirstSync()!
          .containerColor))
      .withOpacity(1);

  return containerTypeColor;
}

///Get containerEntry from containerUID
ContainerEntry getContainerEntry({required String containerUID}) {
  return isarDatabase!.containerEntrys
      .filter()
      .containerUIDMatches(containerUID)
      .findFirstSync()!;
}
