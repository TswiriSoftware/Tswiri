import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_data_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';

Future<List<BarcodeDataEntry>> getGeneratedBarcodes() async {
  //Open generatedBarcodesBox.
  Box<BarcodeDataEntry> generatedBarcodesBox =
      await Hive.openBox(allBarcodesBoxName);

  List<BarcodeDataEntry> generatedBarcodes = [];

  if (generatedBarcodesBox.isNotEmpty) {
    //List of all generated Barcodes.
    generatedBarcodes = generatedBarcodesBox.values.toList();
  }

  return generatedBarcodes;
}

///Gets all barcode tags.
Future<List<BarcodeTagEntry>> getAllBarcodeTags() async {
  //Box that contains all barcodes and Tags assigned to them.
  Box<BarcodeTagEntry> barcodeTagsBox = await Hive.openBox(barcodeTagsBoxName);

  //List of all barcodes and assigned Tags.
  List<BarcodeTagEntry> barcodesAssignedTags = barcodeTagsBox.values.toList();

  return barcodesAssignedTags;
}

///Finds relevant barcode tags in list.
List<String> findRelevantBarcodeTags(
  ///List of all Barcode Entries.
  List<BarcodeTagEntry> barcodeTagEntries,

  ///Current Barcode Data
  BarcodeDataEntry barcodeData,
) {
  //List containing all relevant TagEntries to current barcode.
  List<BarcodeTagEntry> relevantBarcodeTagEntries = barcodeTagEntries
      .where((barcodeTagEntry) => barcodeTagEntry.id == barcodeData.uid)
      .toList();

  //List of all relevant Tags.
  List<String> relevantTags = [];
  for (BarcodeTagEntry barcodeTag in relevantBarcodeTagEntries) {
    relevantTags.add(barcodeTag.tag);
  }
  return relevantTags;
}

Future<List<String>> getCurrentBarcodeTags(int currentBarcode) async {
  List<String> currentBarcodeTags = [];
  Box<BarcodeTagEntry> barcodeTagsBox = await Hive.openBox(barcodeTagsBoxName);
  Set<BarcodeTagEntry> barcodeTags = barcodeTagsBox.values
      .toSet()
      .where((element) => element.id == currentBarcode)
      .toSet();

  for (BarcodeTagEntry barcodeTag in barcodeTags) {
    if (barcodeTag.id == currentBarcode) {
      currentBarcodeTags.add(barcodeTag.tag);
    }
  }
  return currentBarcodeTags;
}

//Get tags assignedTags
Future<List<String>> getAssignedTags(int barcodeID) async {
  Box<BarcodeTagEntry> barcodeTagsBox = await Hive.openBox(barcodeTagsBoxName);

  List<BarcodeTagEntry> barcodesAssignedTags = barcodeTagsBox.values
      .toList()
      .where((element) => element.id == barcodeID)
      .toList();

  List<String> assignedTags = [];
  for (BarcodeTagEntry barcodeTag in barcodesAssignedTags) {
    assignedTags.add(barcodeTag.tag);
  }

  return assignedTags;
}

//List of all tags that have not been assigned to the current tag
Future<List<String>> getSearchResults(List<String> assignedTags) async {
  List<String> results = [];
  Box tagsBox = await Hive.openBox(tagsBoxName);

  List tagEntries = tagsBox.values.toList();

  for (String tagEntry in tagEntries) {
    if (!assignedTags.contains(tagEntry)) {
      results.add(tagEntry);
    }
  }
  return results;
}

///Returns a list of all unassigned tags.
Future<List<String>> getUnassignedTags() async {
  List<String> tags = [];
  Box<String> allTagsBox = await Hive.openBox(tagsBoxName);
  tags = allTagsBox.values.toList();
  return tags;
}
