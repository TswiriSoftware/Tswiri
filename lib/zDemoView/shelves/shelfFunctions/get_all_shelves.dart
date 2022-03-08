import 'package:hive/hive.dart';

import '../../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../../globalValues/global_hive_databases.dart';

Future<List<ShelfEntry>> getAllShelves() async {
  //Open generatedBarcodesBox.
  Box<ShelfEntry> shelfEntriesBox = await Hive.openBox(shelvesBoxName);

  List<ShelfEntry> shelfEntries = [];

  if (shelfEntriesBox.isNotEmpty) {
    //List of all generated Barcodes.
    shelfEntries = shelfEntriesBox.values.toList();
  }

  return shelfEntries;
}
