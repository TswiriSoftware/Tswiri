import 'package:flutter/material.dart';

class ShelfProvider extends ChangeNotifier {
  ShelfProvider({required this.shelfName, required this.shelfDescription});

  String shelfName;
  String shelfDescription;
  bool hasCompleteNameAndDescription = false;
} 

// Future<void> deleteTag(String tag, int barcodeID) async {
  //   Box<BarcodeTagEntry> currentTagsBox =
  //       await Hive.openBox(barcodeTagsBoxName);

  //   currentTagsBox.delete('${barcodeID}_$tag');

  //   assignedTags.remove(tag);
  //   unassignedTags.add(tag);

  //   notifyListeners();
  // }

  // Future<void> addTag(String tag, int barcodeID) async {
  //   Box<BarcodeTagEntry> currentTagsBox =
  //       await Hive.openBox(barcodeTagsBoxName);

  //   if (!currentTagsBox.containsKey('${barcodeID}_$tag')) {
  //     currentTagsBox.delete('${barcodeID}_$tag');
  //     currentTagsBox.put(
  //         '${barcodeID}_$tag', BarcodeTagEntry(id: barcodeID, tag: tag));
  //     unassignedTags.remove(tag);
  //     assignedTags.add(tag);
  //   }

  //   notifyListeners();
  // }

  // Future<void> addNewTag(String enteredKeyword) async {
  //   if (!assignedTags.contains(enteredKeyword) &&
  //       !unassignedTags.contains(enteredKeyword)) {
  //     Box<String> tagsBox = await Hive.openBox(tagsBoxName);

  //     if (!tagsBox.containsKey(enteredKeyword)) {
  //       tagsBox.put(enteredKeyword, enteredKeyword);
  //       unassignedTags.add(enteredKeyword);
  //     }

  //     notifyListeners();
  //   }
  // }

  // List<String> filter(String enteredKeyword) {
  //   List<String> filteredUnassignedTags = [];
  //   if (enteredKeyword.isNotEmpty) {
  //     filteredUnassignedTags = unassignedTags
  //         .where((element) =>
  //             element.toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     if (filteredUnassignedTags.isEmpty) {
  //       return ['+'];
  //     } else {
  //       return filteredUnassignedTags;
  //     }
  //   } else {
  //     if (unassignedTags.isEmpty) {
  //       return ['+'];
  //     } else {
  //       return unassignedTags;
  //     }
  //   }
  // }

  // Map<String, List<String>>? barcodePhotoData;
  // List<String>? photoTags;

  // Future<void> updatePhotos(int barcodeID) async {
  //   Box<BarcodePhotosEntry> barcodePhotoEntries =
  //       await Hive.openBox(barcodePhotosBoxName);

  //   BarcodePhotosEntry? currentBarcodePhotosEntry =
  //       barcodePhotoEntries.get(barcodeID);

  //   Map<String, List<String>> barcodePhotos = {};
  //   if (currentBarcodePhotosEntry != null) {
  //     barcodePhotos = currentBarcodePhotosEntry.photoData;
  //     barcodePhotoData = barcodePhotos;
  //   }
  // }

  // Future<void> deletePhoto(int barcodeID, String photoPath) async {
  //   Box<BarcodePhotosEntry> barcodePhotoEntries =
  //       await Hive.openBox(barcodePhotosBoxName);

  //   BarcodePhotosEntry? currentBarcodePhotosEntry =
  //       barcodePhotoEntries.get(barcodeID);

  //   if (await File(photoPath).exists()) {
  //     File photoFile = File(photoPath);
  //     await photoFile.delete();
  //   }

  //   if (currentBarcodePhotosEntry != null) {
  //     currentBarcodePhotosEntry.photoData
  //         .removeWhere((key, value) => key == photoPath);
  //     barcodePhotoEntries.put(barcodeID, currentBarcodePhotosEntry);
  //   }

  //   notifyListeners();
  // }