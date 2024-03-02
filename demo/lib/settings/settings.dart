import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class Settings with ChangeNotifier {
  Settings({
    required this.prefs,
    bool testing = false,
  }) {
    _testing = testing;
    loadSettings();
  }

  SharedPreferences prefs;
  late final bool _testing;

  static const _spacePathPref = 'databasePathPref';
  late String spacePath;
  void setSpaceDirectory(String spacePath) {
    this.spacePath = spacePath;
    prefs.setString(_spacePathPref, spacePath);
    notifyListeners();
  }

  late bool _deviceHasCameras = false;
  bool get deviceHasCameras => _deviceHasCameras;

  Future<void> loadSettings() async {
    log('loading settings', name: 'Settings');

    var path = prefs.getString(_spacePathPref);
    path ??= '${(await getApplicationSupportDirectory()).path}/main_space';
    spacePath = path;
    prefs.setString(_spacePathPref, spacePath);
    log('spacePath: $spacePath', name: 'Settings');

    if (_testing) {
      _deviceHasCameras = false;
    } else {
      try {
        _deviceHasCameras = (await availableCameras()).isNotEmpty;
      } catch (e) {
        _deviceHasCameras = false;
      }
    }
  }
}
