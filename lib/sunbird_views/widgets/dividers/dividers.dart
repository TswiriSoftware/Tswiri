import 'package:flutter/material.dart';

Divider lightDivider({double? height}) {
  return Divider(
    height: height ?? 8,
    indent: 2,
    color: Colors.white30,
  );
}

Divider headingDivider() {
  return const Divider(
    height: 8,
    thickness: 1,
    color: Colors.white,
  );
}
