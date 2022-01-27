import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/data_points.dart';
import 'package:hive/hive.dart';

List<Offset> listOfPoints(Box matchedDataBox) {
  List<Offset> points = [];
  var matchedDataMap = matchedDataBox.toMap();
  matchedDataMap.forEach((key, value) {
    MatchedCalibrationData data = value;

    DataPoints offsetData = DataPoints(Offset(data.objectSize, data.distance));

    points.add(Offset((offsetData.offset.dx / 4), (offsetData.offset.dy / 4)));
  });
  return points;
}
