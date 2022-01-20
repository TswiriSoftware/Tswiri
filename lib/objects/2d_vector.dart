import 'package:flutter/cupertino.dart';

class Vector2D {
  Vector2D(
    @required this.startQrCode,
    @required this.endQrCode,
    @required this.X,
    @required this.Y,
  );

  final String startQrCode;
  final String endQrCode;
  final double X;
  final double Y;
}
