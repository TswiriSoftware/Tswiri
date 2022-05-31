import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/interbarcode_time_entry/interbarcode_time_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/object_bounding_box.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';
import 'package:isar/isar.dart';
import '../../isar_database/containers/container_entry/container_entry.dart';

///Isar dir
Directory? isarDirectory;

Isar? isarDatabase;

Isar openIsar({String? directory, bool? inspector}) {
  Isar isar = Isar.openSync(
    schemas: [
      ContainerEntrySchema, //1
      ContainerRelationshipSchema, //2
      ContainerTypeSchema, //3
      MarkerSchema, //4
      BarcodePropertySchema, //5
      BarcodeGenerationEntrySchema, //6
      //InterBarcodeVectorEntrySchema, //7
      InterBarcodeTimeEntrySchema, //8
      BarcodeSizeDistanceEntrySchema, //9
      PhotoSchema, //10
      ContainerTagSchema, //11
      MlTagSchema, //12
      ObjectBoundingBoxSchema, //13
      TagTextSchema, //14
      UserTagSchema, //15
      CoordinateEntrySchema //16
    ],
    directory: directory ?? isarDirectory!.path,
    inspector: inspector ?? true,
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
                  '- An Area is a stationary container with a marker.\n- which can contain all other types of containers.\n- It is part of the childrens grid.'
              ..canContain = ['shelf', 'box', 'drawer']
              ..moveable = false
              ..enclosing = false
              ..containerColor = const Color(0xFFff420e).value.toString(),
            replaceOnConflict: false);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 2
              ..containerType = 'shelf'
              ..containerDescription =
                  '- A Shelf is a stationary container with a marker.\n- which can contain Boxes and/or Drawers.\n- It is part of the childrens grid.'
              ..canContain = ['box', 'drawer']
              ..moveable = false
              ..enclosing = false
              ..containerColor = const Color(0xFF89da59).value.toString(),
            replaceOnConflict: false);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 3
              ..containerType = 'drawer'
              ..containerDescription =
                  '- A Drawer is a stationary container.\n- which can contain boxes.\n- It does not form part of the childrens grid.'
              ..canContain = ['box']
              ..moveable = false
              ..enclosing = true
              ..containerColor = Colors.blue.value.toString(),
            replaceOnConflict: false);

        database.containerTypes.putSync(
            ContainerType()
              ..id = 4
              ..containerType = 'box'
              ..containerDescription = '- A Box is a moveable container.'
              ..canContain = ['box']
              ..moveable = true
              ..enclosing = true
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
