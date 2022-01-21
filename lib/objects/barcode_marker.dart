import 'dart:math';

import 'package:flutter/cupertino.dart';

class BarcodeMarker {
  BarcodeMarker(
    @required this.id,
    @required this.position,
    @required this.fixed,
  );

  final String id;
  final bool fixed;
  final Point position;
}

//TODO: convert to named

