import 'package:flutter/material.dart';

Paint paintEasy(Color color, double strokeWidth) {
  var paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth;
  return paint;
}
