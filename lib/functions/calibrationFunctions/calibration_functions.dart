import 'dart:ui';

import 'package:flutter_google_ml_kit/databaseAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/data_points.dart';
import 'package:hive/hive.dart';

List<Offset> listOfPoints(Box matchedDataBox, Size screenSize) {
  List<Offset> points = [];
  var matchedDataMap = matchedDataBox.toMap();
  matchedDataMap.forEach((key, value) {
    MatchedCalibrationDataHiveObject data = value;

    DataPoints offsetData = DataPoints(Offset(data.objectSize, data.distance));

    points.add(Offset(
        ((offsetData.offset.dx + screenSize.width / 2) /
            (screenSize.width / 50)),
        ((offsetData.offset.dy + screenSize.height / 2) /
            (screenSize.height / 200))));
  });
  return points;
}
