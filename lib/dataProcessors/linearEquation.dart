import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LinearEquationObject {
  LinearEquationObject(@required this.m, @required this.c);

  final double m;
  final double c;

  @override
  String toString() {
    return 'y = $m*x + $c';
  }
}

class dataPoints {
  dataPoints(@required this.offset);
  final Offset offset;
}

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

double calculateLinearEquation(LinearEquationObject linearEquation, x) {
  double y = linearEquation.m * x + linearEquation.c;
  return y;
}

LinearEquationObject linearRegression(Box matchedDataBox) {
  var xArray = [];
  var yArray = [];
  var matchedDataMap = matchedDataBox.toMap();

  double dX = 0;
  double oY = 0;

  matchedDataMap.forEach((key, value) {
    double dXi = double.parse(value.toString().split(',').last);
    double oYi = double.parse(value.toString().split(',').first);
    xArray.add(dXi);
    yArray.add(oYi);
    dX = dX + dXi;
    oY = oY + oYi;
  });

  double mX = dX / matchedDataMap.length;
  double mY = oY / matchedDataMap.length;

  double zS = 0;
  double qS = 0;

  for (var i = 0; i < matchedDataMap.length; i++) {
    zS = zS + ((xArray[i] - mX) * (yArray[i] - mY));
    qS = qS + pow((yArray[i] - mY), 2);
  }

  double m = zS / qS;
  double c = mX - (m * mY);

  debugPrint('x: $mX, y: $mY, m: $m, b: $c');

  LinearEquationObject linearEquation = LinearEquationObject(m, c);
  return linearEquation;
}
