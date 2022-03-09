import 'package:hive_flutter/adapters.dart';

import '../../../../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../../../../globalValues/global_hive_databases.dart';

Future<void> updateShelfEntry(ShelfEntry shelfEntry) async {
  Box<ShelfEntry> shelfEntriesBox = await Hive.openBox(shelvesBoxName);
  shelfEntriesBox.put(
    shelfEntry.uid,
    ShelfEntry(
        uid: shelfEntry.uid,
        name: shelfEntry.name,
        description: shelfEntry.description),
  );
}
