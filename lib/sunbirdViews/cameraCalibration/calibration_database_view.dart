import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/calibrationAdapters/calibration_size_data_adapter.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:hive/hive.dart';

class CalibrationDatabaseView extends StatefulWidget {
  const CalibrationDatabaseView({Key? key}) : super(key: key);

  @override
  _CalibrationDatabaseViewState createState() =>
      _CalibrationDatabaseViewState();
}

class _CalibrationDatabaseViewState extends State<CalibrationDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calibration Size Data'),
        centerTitle: true,
        elevation: 0,
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
                          'Diagonal Size Length',
                          'Timestamp',
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
    var calibrationMap = calibrationDataBox.toMap();

    calibrationMap.forEach((key, value) {
      CalibrationSizeDataHiveObject data = value;
      displayList.add([data.averageDiagonalLength, data.timestamp]);
    });

    return displayList;
  }
}

displayDataPoint(var myText) {
  return Column(
    children: [
      const SizedBox(
        height: 3,
      ),
      Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: deepSpaceSparkle),
                top: BorderSide(color: deepSpaceSparkle),
                left: BorderSide(color: deepSpaceSparkle),
                right: BorderSide(color: deepSpaceSparkle))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: deepSpaceSparkle))),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SizedBox(
                  child: Text(myText[0], textAlign: TextAlign.center),
                  width: 175,
                ),
              ),
            ),
            SizedBox(
              child: Text(myText[1], textAlign: TextAlign.center),
              width: 175,
            ),
          ],
        ),
      ),
    ],
  );
}
