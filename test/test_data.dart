import 'dart:ui';

import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_size_distance_entry/barcode_size_distance_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/photo/photo.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/container_tag/container_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/ml_tag/ml_tag.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_bounding_box/object_bounding_box.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/user_tag/user_tag.dart';

TagText tagText = TagText()
  ..id = 1
  ..text = 'test';

ContainerType containerType = ContainerType()
  ..id = 1
  ..containerType = 'area'
  ..containerDescription =
      '- An Area is a stationary container with a marker.\n- which can contain all other types of containers.\n- It is part of the childrens grid.'
  ..canContain = ['shelf', 'box', 'drawer']
  ..moveable = false
  ..enclosing = false
  ..containerColor = const Color(0xFFff420e).value.toString();

ContainerEntry containerEntry = ContainerEntry()
  ..id = 1
  ..barcodeUID = '1_101'
  ..containerType = 'area'
  ..containerUID = 'area_101'
  ..description = 'Description'
  ..name = 'Area';

ContainerRelationship containerRelationship = ContainerRelationship()
  ..id = 1
  ..containerUID = 'box_101'
  ..parentUID = 'box_101';

ContainerTag containerTag = ContainerTag()
  ..id = 1
  ..containerUID = 'area_101'
  ..textID = 1;

Marker marker = Marker()
  ..id = 1
  ..barcodeUID = '1_101'
  ..parentContainerUID = 'area_101';

MlTag mlTag = MlTag()
  ..id = 1
  ..blackListed = false
  ..confidence = 0.99
  ..id
  ..photoID = 1
  ..tagType = MlTagType.text
  ..textID = 1;

ObjectBoundingBox objectBoundingBox = ObjectBoundingBox()
  ..id = 1
  ..mlTagID = 1
  ..boundingBox = [10, 10, 10, 10];

CoordinateEntry coordinateEntry = CoordinateEntry()
  ..id = 1
  ..barcodeUID = '1_101'
  ..gridUID = 'area_101'
  ..timestamp = 11111111
  ..x = 12.0
  ..y = 14.0
  ..z = 17.0;

BarcodeSizeDistanceEntry barcodeSizeDistanceEntry = BarcodeSizeDistanceEntry()
  ..id = 1
  ..distanceFromCamera = 1000
  ..diagonalSize = 100;

BarcodeProperty barcodeProperty = BarcodeProperty()
  ..id = 1
  ..barcodeUID = '1_101'
  ..size = 100;

BarcodeGenerationEntry barcodeGenerationEntry = BarcodeGenerationEntry()
  ..barcodeUIDs = ['1_101']
  ..id = 1
  ..rangeEnd = 1
  ..rangeStart = 1
  ..size = 100
  ..timestamp = 111111111111;

Photo photo = Photo()
  ..id = 1
  ..containerUID = 'area_101'
  ..photoPath = "/sunbird/101.png"
  ..thumbnailPath = "/sunbird/101_thumbnail.png";

UserTag userTag = UserTag()
  ..id = 1
  ..photoID = 1
  ..textID = 1;
