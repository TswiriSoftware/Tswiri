import 'package:fast_immutable_collections/src/base/iterable_extension.dart';
import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:fast_immutable_collections/src/imap/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_data_procesor.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class HiveCalibrationDatabaseView extends StatefulWidget {
  const HiveCalibrationDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveCalibrationDatabaseViewState createState() =>
      _HiveCalibrationDatabaseViewState();
}

class _HiveCalibrationDatabaseViewState
    extends State<HiveCalibrationDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Calibration Database'),
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
                showMyAboutDialog(context, "Deleted Hive Database");
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

                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(text[0], textAlign: TextAlign.start),
                          width: 50,
                        ),
                        SizedBox(
                          child: Text(text[1], textAlign: TextAlign.start),
                          width: 50,
                        ),
                        SizedBox(
                          child: Text(text[2], textAlign: TextAlign.start),
                          width: 150,
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
    var calibrationMap = {};
    calibrationMap = calibrationDataBox.toMap();

    // calibrationMap.clear();
    // print(calibrationMap.length);

    calibrationMap.forEach((key, value) {
      displayList.add(value);
    });
    //print(accelerometerDataBox.toMap().toIMap());
    // print('Accelerometer Data: ${accelerometerDataBox.length}');
    // debugPrint('${accelerometerDataBox.toMap().toIMap()}');
    // print('Calibration Data: ${calibrationDataBox.length}');
    // debugPrint('${calibrationDataBox.toMap().toIMap()}');
    return displayList;
  }
}
