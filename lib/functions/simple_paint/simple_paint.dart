import 'package:flutter/material.dart';

Paint paintEasy(
  Color color,
  double strokeWidth,
) {
  var paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth;
  return paint;
}

Paint paintSimple(
    {required Color color,
    required double strokeWidth,
    required PaintingStyle style}) {
  var paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = style;
  return paint;
}
