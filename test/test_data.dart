import 'dart:ui';

import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/tags/tag_text/tag_text.dart';

List<String> relevantFiles = [
  'tagText.json', //1 [TagText] Shwap
  'containerTypes.json', //2 [ContainerType] Shwap
  'containerEntries.json', //3 [ContainerEntry] Shwap
  'containerRelationships.json', //4 [ContainerRelationship] Shwap
  'containerTags.json', //5 [ContainerTags] Shwap
  'markers.json', // 6
  'mlTags.json', // 7
  'objectBoundingBox.json', // 8
  'realInterBarcodeVectorEntry.json', // 9
  'barcodeSizeDistanceEntrys.json', // 10
  'barcodePropertys.json', // 11
  'barcodeGenerationEntrys.json', // 12
  'photos.json', //13
  'userTags.json', //14
];

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

ContainerEntry containerEntry = ContainerEntry()..id =1..barcodeUID = '1_101'..containerType = 'area'..