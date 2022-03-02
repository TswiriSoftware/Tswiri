import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

///The cameras resolution preset. (Changeable From App Settings)
ResolutionPreset? cameraResolution;
//Different
List<DropdownMenuItem<String>> cameraResolutionPresets = [
  const DropdownMenuItem(value: 'high', child: Text('High')),
  const DropdownMenuItem(value: 'medium', child: Text('Medium')),
  const DropdownMenuItem(value: 'low', child: Text('Low'))
];
