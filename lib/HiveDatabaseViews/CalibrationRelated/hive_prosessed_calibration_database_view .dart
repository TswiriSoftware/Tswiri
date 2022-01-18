import 'package:fast_immutable_collections/src/base/iterable_extension.dart';
import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:fast_immutable_collections/src/imap/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_data_procesor.dart';
import 'package:flutter_google_ml_kit/dataProcessors/objects.dart';
import 'package:flutter_google_ml_kit/database/matched_calibration_data_adapter.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class HiveProsessedCalibrationDatabaseView extends StatefulWidget {
  const HiveProsessedCalibrationDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveProsessedCalibrationDatabaseViewState createState() =>
      _HiveProsessedCalibrationDatabaseViewState();
}

class _HiveProsessedCalibrationDatabaseViewState
    extends State<HiveProsessedCalibrationDatabaseView> {
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
              onPressed: () async {},
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

                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(text[0], textAlign: TextAlign.start),
                          width: 150,
                        ),
                        SizedBox(
                          child: Text(text[1], textAlign: TextAlign.start),
                          width: 50,
                        ),
                        SizedBox(
                          child: Text(text[2], textAlign: TextAlign.start),
                          width: 100,
                        ),
                      ],
                    ),
                  );
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
      int timestamp = int.parse(key) - 2;
      //double qrSizeAve = 2;
      var greater = accelerometerArray.where((e) => e >= timestamp).toList()
        ..sort();

      String accKey = greater.first.toString();
      double imageSizeAve = (double.parse(value.toString().split(',').first) +
              double.parse(value.toString().split(',')[1])) /
          2;
      double distance =
          double.parse(accelerometerMap[accKey].toString().split(',').last);

      BarcodeDistanceData barcodeDistanceData =
          BarcodeDistanceData(timestamp, imageSizeAve, distance);

      LinearCalibrationData data =
          LinearCalibrationData(objectSize: imageSizeAve, distance: distance);
      matchedDataBox.put(imageSizeAve.toString(), data);
      //print(matchedDataBox.toMap());

      displayList.add([
        timestamp,
        imageSizeAve,
        double.parse(accelerometerMap[accKey].toString().split(',').last)
      ]);

      //debugPrint(barcodeDistanceData.toString());
      //print('$qrSizeAve : ${accelerometerMap[greater.first.toString()]}');
    });

    return displayList;
  }
}
