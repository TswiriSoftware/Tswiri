import 'package:flutter/material.dart';
import 'package:material_3_ui/color_schemes.g.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.background,
  appBarTheme: AppBarTheme(
    elevation: 0,
    surfaceTintColor: Colors.black,
  ),
);
