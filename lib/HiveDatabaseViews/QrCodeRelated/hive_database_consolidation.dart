import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/2d_vector.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveDatabaseConsolidationView extends StatefulWidget {
  const HiveDatabaseConsolidationView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseConsolidationViewState createState() =>
      _HiveDatabaseConsolidationViewState();
}

class _HiveDatabaseConsolidationViewState
    extends State<HiveDatabaseConsolidationView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List displayList = [];
  List fixedPoints = ['1'];
  List<InterBarcodeVector> processedDataList = [];
  Map<String, List> consolidatedDataList = {};
  Map<String, List> currentPoints = {};
  Map<String, BarcodeMarker> consolidatedData = {};

  @override
  void initState() {
    displayList.clear();
    super.initState();
  }

  @override
  void dispose() {
    // Hive.close();
    // print("hive_database_consolidation Disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              //Clear Database
              heroTag: null,
              onPressed: () async {
                displayList.clear();
                var consolidatedDataBox =
                    await Hive.openBox('consolidatedDataBox');
                var pro = await Hive.openBox('processedDataBox');
                consolidatedDataBox.clear();
                pro.clear();
                showMyAboutDialog(context, "Deleted Database");
              },
              child: const Icon(Icons.delete),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                displayList.clear();
                setState(() {});
              },
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Hive Database 2D'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List>(
        future: consolidateData(displayList),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column(
              children: [
                Form(child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            List myList = snapshot.data ?? [];
            return ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  var myText = myList[index]
                      .toString()
                      .replaceAll(RegExp(r'\[|\]'), '')
                      .replaceAll(' ', '')
                      .split(',')
                      .toList();
                  print(myText);
                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        displayDataPoint(['UID', 'X', 'Y', 'Fixed']),
                        SizedBox(
                          height: 5,
                        ),
                        displayDataPoint(myText),
                      ],
                    );
                  } else {
                    return displayDataPoint(myText);
                  }
                });
          }
        },
      ),
    );
  }

  Future<List> consolidateData(List displayList) async {
    var processedDataBox = await Hive.openBox('processedDataBox');

    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');

    List<InterBarcodeVector> deduplicatedData = deduplicateData(processedDataBox);

    consolidatedData.update('1', (value) => BarcodeMarker('1', 0, 0, true),
        ifAbsent: () => BarcodeMarker('1', 0, 0, true)); //This is the Fixed Point
    consolidateProcessedData(
        deduplicatedData, consolidatedData, consolidatedDataBox);
    return _displayList(consolidatedData, displayList);
  }
}

List _displayList(Map<String, BarcodeMarker> consolidatedData, List displayList) {
  displayList.clear();
  consolidatedData.forEach((key, value) {
    displayList.add([value.id, value.X, value.Y, value.fixed]);
  });
  displayList.sort((a, b) => a[0].compareTo(b[0]));
  print(displayList);
  return displayList;
}

List<InterBarcodeVector> deduplicateData(Box rawData) {
  List<InterBarcodeVector> processedDataList = [];
  var processedData = rawData.toMap();
  processedData.forEach((key, value) {
    RelativeQrCodes data = value;
    InterBarcodeVector listData = InterBarcodeVector(data.uidStart, data.uidEnd, data.x, data.y);
    processedDataList.add(listData);
  });
  return processedDataList;
}

consolidateProcessedData(List<InterBarcodeVector> processedDataList,
    Map<String, BarcodeMarker> consolidatedData, Box consolidatedDataBox) {
  for (var i = 0; i < processedDataList.length; i++) {
    if (consolidatedData.containsKey(processedDataList[i].startQrCode)) {
      String name = processedDataList[i].endQrCode;
      double x1 = consolidatedData[processedDataList[i].startQrCode]!.X;
      double x2 = processedDataList[i].X;
      double y1 = consolidatedData[processedDataList[i].startQrCode]!.Y;
      double y2 = processedDataList[i].Y;

      BarcodeMarker point = BarcodeMarker(name, (x1 + x2), (y1 + y2), false);
      consolidatedData.update(
        name,
        (value) => point,
        ifAbsent: () => point,
      );
    } else if (consolidatedData.containsKey(processedDataList[i].endQrCode)) {
      String name = processedDataList[i].startQrCode;
      double x1 = consolidatedData[processedDataList[i].endQrCode]!.X;
      double x2 = -processedDataList[i].X;
      double y1 = consolidatedData[processedDataList[i].endQrCode]!.Y;
      double y2 = -processedDataList[i].Y;

      BarcodeMarker point = BarcodeMarker(name, (x1 + x2), (y1 + y2), false);
      consolidatedData.update(
        name,
        (value) => point,
        ifAbsent: () => point,
      );
    }
  }
  consolidatedData.forEach((key, value) {
    consolidatedDataBox.put(
        value.id,
        ConsolidatedData(
            uid: value.id, X: value.X, Y: value.Y, fixed: value.fixed));
  });
}

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

displayDataPoint(var myText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    textDirection: TextDirection.ltr,
    children: [
      SizedBox(
        child: Text(myText[0], textAlign: TextAlign.center),
        width: 50,
      ),
      SizedBox(
        child: Text(myText[1], textAlign: TextAlign.center),
        width: 100,
      ),
      SizedBox(
        child: Text(myText[2], textAlign: TextAlign.center),
        width: 100,
      ),
      SizedBox(
        child: Text(myText[3], textAlign: TextAlign.center),
        width: 100,
      ),
    ],
  );
}
