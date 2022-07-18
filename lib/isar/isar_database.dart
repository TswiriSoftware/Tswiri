import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sunbird_v2/isar/collections/barcode_properties/barcode_property.dart';
import 'package:sunbird_v2/isar/collections/container_entry/container_entry.dart';
import 'package:sunbird_v2/isar/collections/container_type/container_type.dart';
import 'package:sunbird_v2/isar/collections/generated_barcodes/generated_barcodes.dart';
import 'package:sunbird_v2/isar/collections/photo/photo.dart';

///Isar directory.
Directory? isarDirectory;

///Isar reference.
Isar? isar;

///Initiate a isar connection
///
///- From Isolate pass in Directory
Isar initiateIsar({String? directory, bool? inspector}) {
  Isar isar = Isar.openSync(
    schemas: [
      //Barcode Properties
      BarcodePropertySchema,
      //Generated Barcodes
      BarcodeBatchSchema,
      //Container Entries
      ContainerEntrySchema,
      //Container Types
      ContainerTypeSchema,
      //Photos
      PhotoSchema,
    ],
    directory: directory ?? isarDirectory!.path,
    inspector: inspector ?? true,
  );
  return isar;
}

void createBasicContainerTypes() {
  if (isar!.containerTypes.where().findAllSync().length <= 1) {
    isar!.writeTxnSync(
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
