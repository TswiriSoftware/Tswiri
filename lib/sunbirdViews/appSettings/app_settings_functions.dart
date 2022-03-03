//Get all app settings
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';

Future getCurrentAppSettings() async {
  //Get SharedPreferences.
  final prefs = await SharedPreferences.getInstance();
  //Get Camera Resolution.
  cameraResolution = getCameraResolution(prefs);
  hapticFeedBack = await getHapticFeedback();
}

///Returns the [ResolutionPreset]
ResolutionPreset getCameraResolution(SharedPreferences prefs) {
  String cameraPreset = prefs.getString('cameraResolutionPreset') ?? 'high';
  ResolutionPreset selectedCameraResolution = ResolutionPreset.high;
  switch (cameraPreset) {
    case 'high':
      selectedCameraResolution = ResolutionPreset.high;
      break;
    case 'medium':
      selectedCameraResolution = ResolutionPreset.medium;
      break;
    case 'low':
      selectedCameraResolution = ResolutionPreset.low;
      break;
    default:
      selectedCameraResolution = ResolutionPreset.high;
  }
  return selectedCameraResolution;
}

///Sets the Camera Resolution in shared Prefs.
Future setCameraResolution(String selectedCameraResolution) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('cameraResolutionPreset', selectedCameraResolution);
  switch (selectedCameraResolution) {
    case 'high':
      cameraResolution = ResolutionPreset.high;
      break;
    case 'medium':
      cameraResolution = ResolutionPreset.medium;
      break;
    case 'low':
      cameraResolution = ResolutionPreset.low;
      break;
    default:
      cameraResolution = ResolutionPreset.high;
  }
}

///Sets the Camera Resolution in shared Prefs.
Future setHapticFeedback(bool vibration) async {
  final prefs = await SharedPreferences.getInstance();
  hapticFeedBack = vibration;
  prefs.setBool('hapticFeedBack', vibration);
}

///Sets the Camera Resolution in shared Prefs.
Future<bool> getHapticFeedback() async {
  final prefs = await SharedPreferences.getInstance();
  hapticFeedBack = (prefs.getBool('hapticFeedBack') ?? true);
  return hapticFeedBack!;
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return brightOrange;
}
