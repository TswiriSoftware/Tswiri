//Get all app settings
import 'dart:math';
import 'dart:developer' as d;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';

Future getCurrentAppSettings() async {
  //Get SharedPreferences.
  final prefs = await SharedPreferences.getInstance();
  //Get Camera Resolution.
  cameraResolution = getCameraResolution(prefs);
  //Get Haptic feedback
  hapticFeedBack = getHapticFeedback(prefs);
  //Get default getDefaultBarcodeDiagonalLength
  defaultBarcodeDiagonalLength = getDefaultBarcodeDiagonalLength(prefs);
}

///Returns the [ResolutionPreset]
ResolutionPreset getCameraResolution(SharedPreferences prefs) {
  String cameraPreset =
      prefs.getString(cameraResolutionPresetPreference) ?? 'high';
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
  prefs.setString(cameraResolutionPresetPreference, selectedCameraResolution);
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
  prefs.setBool(hapticFeedBackPreference, vibration);
}

///Sets the Camera Resolution in shared Prefs.
bool getHapticFeedback(SharedPreferences prefs) {
  hapticFeedBack = (prefs.getBool(hapticFeedBackPreference) ?? true);
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

double getDefaultBarcodeDiagonalLength(SharedPreferences prefs) {
  double defaultBarcodeDiagonalLength =
      prefs.getDouble(defaultBarcodeDiagonalLengthPreference) ?? 100;

  return defaultBarcodeDiagonalLength;
}

Future<void> setDefaultBarcodeDiagonalLength(double value) async {
  final prefs = await SharedPreferences.getInstance();
  double c = sqrt((pow(value, 2) * 2));
  defaultBarcodeDiagonalLength = c;
  await prefs.setDouble(defaultBarcodeDiagonalLengthPreference, c);
}

double getDefaultBarcodeSize(SharedPreferences prefs) {
  double defaultBarcodeSize =
      prefs.getDouble(defaultBarcodeSizePeference) ?? 100;
  d.log(defaultBarcodeSize.toString());

  return defaultBarcodeSize;
}

Future<void> setDefaultBarcodeSize(double value) async {
  final prefs = await SharedPreferences.getInstance();
  double c = value;
  prefs.setDouble(defaultBarcodeSizePeference, c);
}
