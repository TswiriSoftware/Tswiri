// ignore_for_file: unnecessary_import

import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sunbird_2/isar/collections/barcode_batch/barcode_batch.dart';
import 'package:sunbird_2/isar/collections/cataloged_barcode/cataloged_barcode.dart';
import 'package:sunbird_2/isar/collections/camera_calibration/camera_calibration_entry.dart';
import 'package:sunbird_2/isar/collections/cataloged_container/cataloged_container.dart';
import 'package:sunbird_2/isar/collections/cataloged_coordinate/cataloged_coordinate.dart';
import 'package:sunbird_2/isar/collections/container_relationship/container_relationship.dart';
import 'package:sunbird_2/isar/collections/container_tag/container_tag.dart';
import 'package:sunbird_2/isar/collections/container_type/container_type.dart';
import 'package:sunbird_2/isar/collections/marker/marker.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_detected_label_text/ml_detected_label_text.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_label/ml_photo_label.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_object/ml_object/ml_object.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_object/ml_object_label/ml_object_label.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_detected_element_text/ml_detected_element_text.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_text_block/ml_text_block.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_text_element/ml_text_element.dart';
import 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_text_line/ml_text_line.dart';
import 'package:sunbird_2/isar/collections/object_label/object_label.dart';
import 'package:sunbird_2/isar/collections/photo/photo.dart';
import 'package:sunbird_2/isar/collections/photo_label/photo_label.dart';
import 'package:sunbird_2/isar/collections/tag_text/tag_text.dart';

export 'package:isar/isar.dart';
export 'package:sunbird_2/isar/collections/barcode_batch/barcode_batch.dart';
export 'package:sunbird_2/isar/collections/cataloged_barcode/cataloged_barcode.dart';
export 'package:sunbird_2/isar/collections/camera_calibration/camera_calibration_entry.dart';
export 'package:sunbird_2/isar/collections/cataloged_container/cataloged_container.dart';
export 'package:sunbird_2/isar/collections/container_relationship/container_relationship.dart';
export 'package:sunbird_2/isar/collections/container_tag/container_tag.dart';
export 'package:sunbird_2/isar/collections/container_type/container_type.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_detected_label_text/ml_detected_label_text.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_label/ml_photo_label.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_object/ml_object/ml_object.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_object/ml_object_label/ml_object_label.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_detected_element_text/ml_detected_element_text.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_text_block/ml_text_block.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_text_element/ml_text_element.dart';
export 'package:sunbird_2/isar/collections/ml_tags/ml_text/ml_text_line/ml_text_line.dart';
export 'package:sunbird_2/isar/collections/object_label/object_label.dart';
export 'package:sunbird_2/isar/collections/photo/photo.dart';
export 'package:sunbird_2/isar/collections/photo_label/photo_label.dart';
export 'package:sunbird_2/isar/collections/tag_text/tag_text.dart';

export 'package:sunbird_2/isar/collections/cataloged_coordinate/cataloged_coordinate.dart';
export 'package:sunbird_2/isar/collections/marker/marker.dart';

export 'package:sunbird_2/isar/functions/get_functions.dart';
export 'package:sunbird_2/isar/functions/create_functions.dart';
export 'package:sunbird_2/isar/functions/delete_functions.dart';

///Isar directory.
Directory? isarDirectory;

///Isar reference.
Isar? isar;

///Photo Directory
Directory? photoDirectory;

///Initiate a isar connection
///
///- From Isolate pass in Directory
Future<Isar> initiateIsar({String? directory, bool? inspector}) async {
  Isar isar = Isar.openSync(
    schemas: [
      //Barcode Batch.
      BarcodeBatchSchema,

      //Barcode Properties.
      CatalogedBarcodeSchema,

      //Camera Calibration Entry.
      CameraCalibrationEntrySchema,

      //Container Entry.
      CatalogedContainerSchema,

      //Container Relationship.
      ContainerRelationshipSchema,

      //Container Tag.
      ContainerTagSchema,

      //Container Type.
      ContainerTypeSchema,

      //ML Detected Label Text.
      MLDetectedLabelTextSchema,
      //Ml Label.
      MLPhotoLabelSchema,
      //Photo Label.
      PhotoLabelSchema,

      //Ml Object.
      MLObjectSchema,
      //ML Object Label.
      MLObjectLabelSchema,
      //Object Label.
      ObjectLabelSchema,

      //ML Detected Text Element Text.
      MLDetectedElementTextSchema,
      //ML Text Block.
      MLTextBlockSchema,
      //ML Text Element.
      MLTextElementSchema,
      //ML Text Line.
      MLTextLineSchema,

      //Photo.
      PhotoSchema,

      //Marker
      MarkerSchema,

      //Cataloged Coordinate
      CatalogedCoordinateSchema,

      //Tag Text.
      TagTextSchema,
    ],
    directory: directory ?? isarDirectory!.path,
    inspector: inspector ?? true,
  );

  // isar.writeTxnSync((isar) => isar.containerTypes.clearSync());

  String storagePath = '${(await getExternalStorageDirectory())!.path}/photos';

  if (!await Directory(storagePath).exists()) {
    photoDirectory = await Directory(storagePath).create();
  } else {
    photoDirectory = Directory(storagePath);
  }

  return isar;
}
