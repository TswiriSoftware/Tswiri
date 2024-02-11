import 'dart:developer';

import 'package:camera/camera.dart';
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

  static const _spacePathPref = 'databasePathPref';
  late String spacePath;
  void setSpaceDirectory(String spacePath) {
    this.spacePath = spacePath;
    prefs.setString(_spacePathPref, spacePath);
    notifyListeners();
  }

  late final bool _deviceHasCameras;

  Future<void> loadSettings() async {
    log('loading settings', name: 'Settings');

    var path = prefs.getString(_spacePathPref);
    path ??= '${(await getApplicationSupportDirectory()).path}/main_space';
    spacePath = path;
    prefs.setString(_spacePathPref, spacePath);
    log('spacePath: $spacePath', name: 'Settings');

    var hasCameras;
    try {
      hasCameras = (await availableCameras()).isNotEmpty;
    } catch (e) {
      hasCameras = false;
    }
  }
}
