import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';

Card defaultCard({
  required Widget body,
  required Color? borderColor,
  Color? color,
  double? marginHorizontal,
  double? marginVertical,
}) {
  return Card(
    margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal ?? 8, vertical: marginVertical ?? 8),
    color: color ?? Colors.white12,
    elevation: 5,
    shadowColor: Colors.black26,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: borderColor ?? sunbirdOrange, width: 1.5),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: body,
    ),
  );
}
