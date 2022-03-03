import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';

import '../databaseAdapters/allBarcodes/barcode_entry.dart';

class Photo extends ChangeNotifier {
  Photo(this.photoPath, this.photoTags);
  String photoPath;
  List<String> photoTags;

  Future<void> updatePhoto() async {
    notifyListeners();
  }
}

class Tags extends ChangeNotifier {
  Tags(
    this.assignedTags,
    this.unassignedTags,
    this.isFixed,
    this.barcodeSize,
  );

  List<String> assignedTags;
  List<String> unassignedTags;
  double barcodeSize;
  bool isFixed;

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
    barcodeDataEntry.isFixed = isFixed;

    generatedBarcodesBox.put(barcodeID, barcodeDataEntry);
    notifyListeners();
  }

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

    currentTagsBox.put(
        '${barcodeID}_$tag', BarcodeTagEntry(barcodeID: barcodeID, tag: tag));

    unassignedTags.remove(tag);
    assignedTags.add(tag);
    notifyListeners();
  }

  Future<void> addNewTag(String enteredKeyword) async {
    if (!assignedTags.contains(enteredKeyword) &&
        !unassignedTags.contains(enteredKeyword)) {
      Box<String> tagsBox = await Hive.openBox(tagsBoxName);
      //tagsBox.clear();
      tagsBox.put(enteredKeyword, enteredKeyword);

      unassignedTags.add(enteredKeyword);

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
}
