import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/straight_line.dart';
import 'package:hive/hive.dart';

import 'objects.dart';

List<Offset> listOfPoints(Box matchedDataBox) {
  List<Offset> points = [];
  var matchedDataMap = matchedDataBox.toMap();
  matchedDataMap.forEach((key, value) {
    double x = double.parse(value.toString().split(',').last);
    double y = double.parse(value.toString().split(',').first);
    dataPoints offsetData = dataPoints(Offset(x, y));

    points.add(Offset((offsetData.offset.dx / 4), (offsetData.offset.dy / 4)));
  });
  return points;
}

double calculateLinearEquation(StraightLine linearEquation, x) {
  double y = linearEquation.gradient * x + linearEquation.yIntercept;
  return y;
}

void generateLookupTable(Box matchedDataBox) {
  var matchedDataMap = matchedDataBox.toMap();

  matchedDataMap.forEach((key, value) {
    double imageSize = double.parse(value.toString().split(',').last);
    double distancemm = double.parse(value.toString().split(',').first);
  });
}


