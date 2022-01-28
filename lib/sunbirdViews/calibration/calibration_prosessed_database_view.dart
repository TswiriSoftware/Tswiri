import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:hive/hive.dart';

class CalibrationProsessedDatabaseView extends StatefulWidget {
  const CalibrationProsessedDatabaseView({Key? key}) : super(key: key);

  @override
  _CalibrationProsessedDatabaseViewState createState() =>
      _CalibrationProsessedDatabaseViewState();
}

class _CalibrationProsessedDatabaseViewState
    extends State<CalibrationProsessedDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Calibrated Database'),
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
                    await Hive.openBox('calibrationDataBox');
                var accelerometerDataBox =
                    await Hive.openBox('accelerometerDataBox');
                var matchedDataBox = await Hive.openBox('matchedDataBox');
                accelerometerDataBox.clear();
                calibrationDataBox.clear();
                matchedDataBox.clear();
                displayList.clear();
                Future.delayed(Duration(milliseconds: 100), () {
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
                        displayDataPoint([
                          'Timestamp',
                          'deltaT',
                          'Acceleration',
                          'Distance'
                        ]),
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
    var calibrationDataBox = await Hive.openBox('calibrationDataBox');
    var accelerometerDataBox = await Hive.openBox('accelerometerDataBox');
    var matchedDataBox = await Hive.openBox('matchedDataBox');

    var calibrationMap = {};
    var accelerometerMap = {};
    calibrationMap = calibrationDataBox.toMap();
    accelerometerMap = accelerometerDataBox.toMap();
    var accelerometerArray = [];

    accelerometerMap.forEach((key, value) {
      accelerometerArray.add(int.parse(key));
    });

    calibrationMap.forEach((key, value) {
      CalibrationData calibrationData = value;
      int timestamp = int.parse(key) - 2;
      //double qrSizeAve = 2;
      var greater = accelerometerArray.where((e) => e >= timestamp).toList()
        ..sort();

      String accKey = greater.first.toString();

      double distance =
          double.parse(accelerometerMap[accKey].toString().split(',').last);

      MatchedCalibrationData data = MatchedCalibrationData(
          objectSize: calibrationData.averageDiagonalLength,
          distance: distance);

      matchedDataBox.put(
          calibrationData.averageDiagonalLength.toString(), data);

      displayList.add([
        timestamp,
        calibrationData.averageDiagonalLength,
        double.parse(accelerometerMap[accKey].toString().split(',').last)
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
                child: Text(text[1], textAlign: TextAlign.start),
                width: 150,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SizedBox(
              child: Text(text[2], textAlign: TextAlign.start),
              width: 150,
            ),
          ),
        ],
      ),
    ),
  );
}
