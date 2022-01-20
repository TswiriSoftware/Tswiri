import 'package:flutter/cupertino.dart';

class Point2D {
  Point2D(
    @required this.name,
    @required this.X,
    @required this.Y,
    @required this.Fixed,
  );

  final String name;
  final double X;
  final double Y;
  final bool Fixed;
}
