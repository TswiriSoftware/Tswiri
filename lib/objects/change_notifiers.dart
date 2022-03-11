import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';

import '../databaseAdapters/allBarcodes/barcode_data_entry.dart';
import '../databaseAdapters/barcodePhotoAdapter/barcode_photo_entry.dart';

class BarcodeDataChangeNotifier extends ChangeNotifier {
  BarcodeDataChangeNotifier(
      {required this.barcodeSize,
      required this.isFixed,
      required this.description});
  double barcodeSize;
  bool isFixed;
  String description;

  Future<void> changeBarcodeDescription(
      int barcodeID, String newDescription) async {
    description = newDescription;

    Box<BarcodeDataEntry> generatedBarcodesBox =
        await Hive.openBox(allBarcodesBoxName);
    BarcodeDataEntry barcodeDataEntry = generatedBarcodesBox.get(barcodeID)!;
    barcodeDataEntry.description = newDescription;

    generatedBarcodesBox.put(barcodeID, barcodeDataEntry);
    notifyListeners();
  }

  Future<void> changeBarcodeSize(int barcodeID, double newBarcodeSize) async {
    barcodeSize = newBarcodeSize;

    Box<BarcodeDataEntry> generatedBarcodesBox =
        await Hive.openBox(allBarcodesBoxName);
    BarcodeDataEntry barcodeDataEntry = generatedBarcodesBox.get(barcodeID)!;
    barcodeDataEntry.barcodeSize = newBarcodeSize;

    generatedBarcodesBox.put(barcodeID, barcodeDataEntry);
    notifyListeners();
  }

  Future<void> changeFixed(int barcodeID) async {
    isFixed = !isFixed;

    Box<BarcodeDataEntry> generatedBarcodesBox =
        await Hive.openBox(allBarcodesBoxName);
    BarcodeDataEntry barcodeDataEntry = generatedBarcodesBox.get(barcodeID)!;
    barcodeDataEntry.isMarker = isFixed;

    generatedBarcodesBox.put(barcodeID, barcodeDataEntry);
    notifyListeners();
  }
}

class PhotosAndTags extends ChangeNotifier {
  PhotosAndTags(
      {required this.assignedTags,
      required this.unassignedTags,
      this.barcodePhotoData});

  List<String> assignedTags;
  List<String> unassignedTags;

  Future<void> deleteTag(String tag, int barcodeID) async {
    Box<BarcodeTagEntry> currentTagsBox =
        await Hive.openBox(barcodeTagsBoxName);

    currentTagsBox.delete('${barcodeID}_$tag');

    assignedTags.remove(tag);
    unassignedTags.add(tag);

    notifyListeners();
  }

  Future<void> addTag(String tag, int barcodeID) async {
    Box<BarcodeTagEntry> currentTagsBox =
        await Hive.openBox(barcodeTagsBoxName);

    if (!currentTagsBox.containsKey('${barcodeID}_$tag')) {
      currentTagsBox.delete('${barcodeID}_$tag');
      currentTagsBox.put(
          '${barcodeID}_$tag', BarcodeTagEntry(id: barcodeID, tag: tag));
      unassignedTags.remove(tag);
      assignedTags.add(tag);
    }

    notifyListeners();
  }

  Future<void> addNewTag(String enteredKeyword) async {
    if (!assignedTags.contains(enteredKeyword) &&
        !unassignedTags.contains(enteredKeyword)) {
      Box<String> tagsBox = await Hive.openBox(tagsBoxName);

      if (!tagsBox.containsKey(enteredKeyword)) {
        tagsBox.put(enteredKeyword, enteredKeyword);
        unassignedTags.add(enteredKeyword);
      }

      notifyListeners();
    }
  }

  List<String> filter(String enteredKeyword) {
    List<String> filteredUnassignedTags = [];
    if (enteredKeyword.isNotEmpty) {
      filteredUnassignedTags = unassignedTags
          .where((element) =>
              element.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      if (filteredUnassignedTags.isEmpty) {
        return ['+'];
      } else {
        return filteredUnassignedTags;
      }
    } else {
      if (unassignedTags.isEmpty) {
        return ['+'];
      } else {
        return unassignedTags;
      }
    }
  }

  Map<String, List<String>>? barcodePhotoData;
  List<String>? photoTags;

  Future<void> updatePhotos(int barcodeID) async {
    Box<BarcodePhotosEntry> barcodePhotoEntries =
        await Hive.openBox(barcodePhotosBoxName);

    BarcodePhotosEntry? currentBarcodePhotosEntry =
        barcodePhotoEntries.get(barcodeID);

    Map<String, List<String>> barcodePhotos = {};
    if (currentBarcodePhotosEntry != null) {
      barcodePhotos = currentBarcodePhotosEntry.photoData;
      barcodePhotoData = barcodePhotos;
    }
  }

  Future<void> deletePhoto(int barcodeID, String photoPath) async {
    Box<BarcodePhotosEntry> barcodePhotoEntries =
        await Hive.openBox(barcodePhotosBoxName);

    BarcodePhotosEntry? currentBarcodePhotosEntry =
        barcodePhotoEntries.get(barcodeID);

    if (await File(photoPath).exists()) {
      File photoFile = File(photoPath);
      await photoFile.delete();
    }

    if (currentBarcodePhotosEntry != null) {
      currentBarcodePhotosEntry.photoData
          .removeWhere((key, value) => key == photoPath);
      barcodePhotoEntries.put(barcodeID, currentBarcodePhotosEntry);
    }

    notifyListeners();
  }
}
