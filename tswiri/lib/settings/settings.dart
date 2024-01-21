import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class Settings with ChangeNotifier {
  Settings({
    required this.prefs,
  }) {
    loadSettings();
  }

  SharedPreferences prefs;

  static const databasePathPref = 'databasePathPref';
  late String databasePath;
  void setDatabaseDirectory(String databasePath) {
    this.databasePath = databasePath;
    prefs.setString(databasePathPref, databasePath);
    notifyListeners();
  }

  Future<void> loadSettings() async {
    log('loading settings', name: 'Settings');

    databasePath = prefs.getString(databasePathPref) ?? '${(await getApplicationSupportDirectory()).path}/main_space';
    prefs.setString(databasePathPref, databasePath);

    log('databasePath: $databasePath', name: 'Settings');
  }
}
