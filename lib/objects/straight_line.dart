import 'package:flutter/material.dart';

class StraightLine {

  StraightLine({required final this.gradient, required final this.yIntercept});

  final double gradient;
  final double yIntercept;

  @override
  String toString() {
    return 'y = $gradient*x + $yIntercept';
  }

}