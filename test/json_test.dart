import 'dart:convert';

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
import 'package:flutter_test/flutter_test.dart';

import 'test_data.dart';

void main() {
  //1.
  String tagTextJson = jsonEncode(tagText.toJson());
  TagText ttr = TagText().fromJson(jsonDecode(tagTextJson));

  test('TagText Json Test', () {
    expect(ttr, tagText);
  });

  //2.
  String containerTypeJson = jsonEncode(containerType.toJson());
  ContainerType ctr = ContainerType().fromJson(jsonDecode(containerTypeJson));

  test('ContainerType Json Test', () {
    expect(ctr, containerType);
  });

  //3.
  String containerEntryJson = jsonEncode(containerEntry.toJson());
  ContainerEntry cer =
      ContainerEntry().fromJson(jsonDecode(containerEntryJson));

  test('ContainerEntry Json Test', () {
    expect(cer, containerEntry);
  });

  //4.
  String containerRelationshipJson = jsonEncode(containerRelationship.toJson());
  ContainerRelationship crr =
      ContainerRelationship().fromJson(jsonDecode(containerRelationshipJson));

  test('ContainerRelationship Json Test', () {
    expect(crr, containerRelationship);
  });

  //5.
  String containerTagsJson = jsonEncode(containerTag.toJson());
  ContainerTag ctrr = ContainerTag().fromJson(jsonDecode(containerTagsJson));

  test('ContainerTags Json Test', () {
    expect(ctrr, containerTag);
  });

  //6.
  String markerJson = jsonEncode(marker.toJson());
  Marker mr = Marker().fromJson(jsonDecode(markerJson));

  test('Marker Json Test', () {
    expect(mr, marker);
  });

  //7.
  String mlJson = jsonEncode(mlTag.toJson());
  MlTag mlr = MlTag().fromJson(jsonDecode(mlJson));

  test('MlTag Json Test', () {
    expect(mlr, mlTag);
  });

  //8.
  String obJson = jsonEncode(objectBoundingBox.toJson());
  ObjectBoundingBox obr = ObjectBoundingBox().fromJson(jsonDecode(obJson));

  test('ObjectBoundingBox Json Test', () {
    expect(obr, objectBoundingBox);
  });

  //9.
  String coeJson = jsonEncode(coordinateEntry.toJson());
  CoordinateEntry coer = CoordinateEntry().fromJson(jsonDecode(coeJson));

  test('CoordinateEntry Json Test', () {
    expect(coer.barcodeUID, coordinateEntry.barcodeUID);
    expect(coer.gridUID, coordinateEntry.gridUID);
    expect(coer.id, coordinateEntry.id);
    expect(coer.timestamp, coordinateEntry.timestamp);
    expect(coer.x, coordinateEntry.x);
    expect(coer.y, coordinateEntry.y);
    expect(coer.z, coordinateEntry.z);
  });

  //10.
  String bsdJson = jsonEncode(barcodeSizeDistanceEntry.toJson());
  BarcodeSizeDistanceEntry bsdr =
      BarcodeSizeDistanceEntry().fromJson(jsonDecode(bsdJson));

  test('BarcodeSizeDistanceEntry Json Test', () {
    expect(bsdr, barcodeSizeDistanceEntry);
  });
  //11.
  String bpJson = jsonEncode(barcodeProperty.toJson());
  BarcodeProperty bpr = BarcodeProperty().fromJson(jsonDecode(bpJson));

  test('BarcodeProperty Json Test', () {
    expect(bpr, barcodeProperty);
  });

  //12.
  String pJson = jsonEncode(photo.toJson());
  Photo pr = Photo().fromJson(jsonDecode(pJson), '');

  test('Photo Json Test', () {
    expect(pr, photo);
  });

  //13.
  String utJson = jsonEncode(userTag.toJson());
  UserTag utr = UserTag().fromJson(jsonDecode(utJson));

  test('UserTag Json Test', () {
    expect(utr, userTag);
  });
}
