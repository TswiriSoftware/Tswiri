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

  static const spacePathPref = 'databasePathPref';
  late String spacePath;
  void setSpaceDirectory(String spacePath) {
    this.spacePath = spacePath;
    prefs.setString(spacePathPref, spacePath);
    notifyListeners();
  }

  Future<void> loadSettings() async {
    log('loading settings', name: 'Settings');

    spacePath = prefs.getString(spacePathPref) ??
        '${(await getApplicationSupportDirectory()).path}/main_space';

    prefs.setString(spacePathPref, spacePath);

    log('spacePath: $spacePath', name: 'Settings');
  }
}
