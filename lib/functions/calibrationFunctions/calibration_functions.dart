import 'dart:math';
import 'dart:ui';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:hive/hive.dart';

///Generates a list of points to display with painter
List<Offset> listOfPoints(Box matchedDataBox, Size screenSize) {
  List<Offset> points = [];
  var matchedDataMap = matchedDataBox.toMap();
  matchedDataMap.forEach((key, value) {
    MatchedCalibrationDataHiveObject data = value;

    Offset offsetData = Offset(data.objectSize, data.distance);

    points.add(Offset(
        ((offsetData.dx + screenSize.width / 2) / (screenSize.width / 50)),
        ((offsetData.dy + screenSize.height / 2) / (screenSize.height / 200))));
  });
  return points;
}

///StraightLine object
/// y = x*m + c
class StraightLine {
  StraightLine({required this.m, required this.c});

  ///This is the m value of a straight line
  double m;

  ///This is the c value of a straight line
  double c;
}

///Function that calculates the straightline equation of a set of data
StraightLine linearRegression(Map matchedDataBox) {
  var xArray = [];
  var yArray = [];
  var matchedDataMap = matchedDataBox;
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

  StraightLine straightLineEquation = StraightLine(m: m, c: c);
  return straightLineEquation;
}

///Generates a list of type int from the timestamps of the accelerometer data.
List<int> generateAccelerometerKeysArray(Map accelerometerMap) {
  List<int> accelerometerArray = [];
  accelerometerMap.forEach((key, value) {
    accelerometerArray.add(int.parse(key));
  });

  return accelerometerArray;
}

///This function return the distance from the camera based on the timestamp key.
double getDistanceFromCamera(
    Map<dynamic, dynamic> accelerometerMap, String accelerometerMapKey) {
  return double.parse(
      accelerometerMap[accelerometerMapKey].toString().split(',').last);
}
