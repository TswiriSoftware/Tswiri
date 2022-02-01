import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/calibration_size_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/functions/calibrationFunctions/calibration_functions.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchedCalibrationDatabaseView extends StatefulWidget {
  const MatchedCalibrationDatabaseView({Key? key}) : super(key: key);

  @override
  _MatchedCalibrationDatabaseViewState createState() =>
      _MatchedCalibrationDatabaseViewState();
}

class _MatchedCalibrationDatabaseViewState
    extends State<MatchedCalibrationDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matched Data Viewer'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                var calibrationDataBox =
                    await Hive.openBox(calibrationDataHiveBox);
                var accelerometerDataBox =
                    await Hive.openBox(accelerometerDataHiveBox);
                var matchedDataBox = await Hive.openBox(matchedDataHiveBox);
                accelerometerDataBox.clear();
                calibrationDataBox.clear();
                matchedDataBox.clear();
                displayList.clear();
                Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() {});
                });
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List myList = snapshot.data ?? [];
            //print(myList);
            return ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  var text = myList[index]
                      .toString()
                      .replaceAll(RegExp(r'\[|\]'), '')
                      .replaceAll(' ', '')
                      .split(',')
                      .toList();

                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        displayDataPoint(
                            ['', 'Distance (mm)', 'Diagonal Length', '']),
                        const SizedBox(
                          height: 5,
                        ),
                        displayDataPoint(text),
                      ],
                    );
                  } else {
                    return displayDataPoint(text);
                  }
                });
          }
        },
      ),
    );
  }

  Future<List> loadData() async {
    displayList.clear();
    var calibrationDataBox = await Hive.openBox(calibrationDataHiveBox);
    var accelerometerDataBox = await Hive.openBox(accelerometerDataHiveBox);
    var matchedDataBox = await Hive.openBox(matchedDataHiveBox);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var calibrationMap = {};
    var accelerometerMap = {};
    calibrationMap = calibrationDataBox.toMap();
    accelerometerMap = accelerometerDataBox.toMap();

    List<int> accelerometerArray =
        generateAccelerometerKeysArray(accelerometerMap);

    calibrationMap.forEach((key, calibrationData) {
      int timestamp = int.parse(key) - 2;
      var greater = accelerometerArray.where((e) => e >= timestamp).toList()
        ..sort();

      String accelerometerMapKey = greater.first.toString();

      double distanceFromCamera =
          getDistanceFromCamera(accelerometerMap, accelerometerMapKey);

      MatchedCalibrationDataHiveObject matchedCalibrationDataInstance =
          MatchedCalibrationDataHiveObject(
              objectSize: calibrationData.averageDiagonalLength,
              distance: distanceFromCamera);

      matchedDataBox.put(calibrationData.averageDiagonalLength.toString(),
          matchedCalibrationDataInstance);

      StraightLine straightLineEquation =
          linearRegression(matchedDataBox.toMap());

      prefs.setDouble('m', straightLineEquation.m);
      prefs.setDouble('c', straightLineEquation.c);

      displayList.add([
        timestamp,
        calibrationData.averageDiagonalLength,
        double.parse(
            accelerometerMap[accelerometerMapKey].toString().split(',').last)
      ]);
    });

    return displayList;
  }
}

displayDataPoint(var text) {
  return Center(
    child: Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: deepSpaceSparkle),
              top: BorderSide(color: deepSpaceSparkle),
              left: BorderSide(color: deepSpaceSparkle),
              right: BorderSide(color: deepSpaceSparkle))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: deepSpaceSparkle))),
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SizedBox(
                child: Text(text[2], textAlign: TextAlign.start),
                width: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SizedBox(
              child: Text(text[1], textAlign: TextAlign.start),
              width: 150,
            ),
          ),
        ],
      ),
    ),
  );
}
