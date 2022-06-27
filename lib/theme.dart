import 'package:flutter/material.dart';

import 'global_values/all_globals.dart';

ThemeData themeData() {
  return ThemeData(
    //Dark Theme
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    primaryColor: sunbirdOrange,
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
        backgroundColor: Colors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: sunbirdOrange,
    ),
    scaffoldBackgroundColor: backgroundColor,
    buttonTheme: const ButtonThemeData(
      buttonColor: sunbirdOrange,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: sunbirdOrange,
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(sunbirdOrange),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: sunbirdOrange,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: sunbirdOrange),
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontSize: 20),
      labelMedium: TextStyle(fontSize: 17),
      labelSmall: TextStyle(fontSize: 15),
      titleLarge: TextStyle(fontSize: 25),
      titleMedium: TextStyle(fontSize: 18),
      titleSmall: TextStyle(fontSize: 16),
      bodyLarge: TextStyle(fontSize: 16),
      headlineSmall: TextStyle(
          fontSize: 22, color: Colors.white, fontWeight: FontWeight.w300),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    ),
  );
}
