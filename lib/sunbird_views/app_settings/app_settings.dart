import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

///Add any settings here.
///1. Add to app_settings_class
///2. Add to app_settings_view.dart

///The cameras resolution. (Changeable From App Settings)
ResolutionPreset? cameraResolution;

//Different camera resolution presets.
List<DropdownMenuItem<String>> cameraResolutionPresets = [
  const DropdownMenuItem(value: 'high', child: Text('High')),
  const DropdownMenuItem(value: 'medium', child: Text('Medium')),
  const DropdownMenuItem(value: 'low', child: Text('Low'))
];

//Haptic feedback in camera navigation.
bool hapticFeedBack = true;

//defaultBarcodeDiagonalLengthPreference
double? defaultBarcodeDiagonalLength;

//ImageLabeling
bool googleImageLabeling = true;
int googleImageLabelingConfidenceThreshold = 50;

// //Object Labeling
// bool googleVisionProducts = true;
// int googleVisionProductsConfidenceThreshold = 50;

bool inceptionV4 = true;
int inceptionV4PreferenceConfidenceThreshold = 50;
