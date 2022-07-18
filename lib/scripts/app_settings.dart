import 'package:shared_preferences/shared_preferences.dart';

import '../globals/globals_export.dart';

void loadAppSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //Default barcode size.
  defaultBarcodeSize =
      prefs.getDouble(defaultBarcodeSizePref) ?? defaultBarcodeSize;

  //Vibration.
  vibrate = prefs.getBool(vibratePref) ?? true;
}
