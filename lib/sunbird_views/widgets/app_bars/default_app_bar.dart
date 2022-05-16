import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';

AppBar defaultAppBar({
  required BuildContext c,
  required String title,
  required Color? backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? sunbirdOrange,
    elevation: 25,
    centerTitle: true,
    title: Text(
      title,
      style: Theme.of(c).textTheme.titleMedium,
    ),
    shadowColor: Colors.black54,
  );
}
