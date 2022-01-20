import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/objects/2d_point.dart';
import 'package:flutter_google_ml_kit/objects/2d_vector.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
  List<Vector2D> processedDataList = [];
  Map<String, List> consolidatedDataList = {};
  Map<String, List> currentPoints = {};
  Map<String, Point2D> consolidatedData = {};

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
                fixedPointsDialog(fixedPoints);
              },
              child: const Icon(Icons.change_circle),
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
        future: consolidatingData(displayList),
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
                        displayDataPoint(['UID', 'X', 'Y']),
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

  fixedPointsDialog(List fixedPoints) {
    String dropdownValue = fixedPoints[0];
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text('Pick Fixed Point'),
          content: SingleChildScrollView(
              child: DropdownButton(
                  value: dropdownValue,
                  items: <String>['1', '2', '3', '4', '5', '6', '7']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    fixedPoints.clear();
                    fixedPoints.add(newValue);
                    setState(() {
                      dropdownValue = newValue!;
                      dropdownValue = fixedPoints[0];
                    });
                  })),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List> consolidatingData(List displayList) async {
    var processedDataBox = await Hive.openBox('processedDataBox');
    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
    List<Vector2D> processedDataList = processedData(processedDataBox);
    processedDataList.forEach((element) {
      print(
          '${element.startQrCode}, ${element.endQrCode}, ${element.X}, ${element.Y}');
    });
    consolidatedData.update('1', (value) => Point2D('1', 0, 0),
        ifAbsent: () => Point2D('1', 0, 0)); //This is the Fixed Point
    consolidateProcessedData(processedDataList, consolidatedData);
    return _displayList(consolidatedData, displayList);
  }
}

List _displayList(Map<String, Point2D> consolidatedData, List displayList) {
  displayList.clear();
  consolidatedData.forEach((key, value) {
    displayList.add([value.name, value.X, value.Y]);
  });
  displayList.sort((a, b) => a[0].compareTo(b[0]));
  print(displayList);
  return displayList;
}

List<Vector2D> processedData(Box processedDataBox) {
  List<Vector2D> processedDataList = [];
  var processedData = processedDataBox.toMap();
  processedData.forEach((key, value) {
    RelativeQrCodes data = value;
    Vector2D listData = Vector2D(data.uidStart, data.uidEnd, data.x, data.y);
    processedDataList.add(listData);
  });
  return processedDataList;
}

consolidateProcessedData(
    List<Vector2D> processedDataList, Map<String, Point2D> consolidatedData) {
  for (var i = 0; i < processedDataList.length; i++) {
    if (consolidatedData.containsKey(processedDataList[i].startQrCode)) {
      String name = processedDataList[i].endQrCode;
      double X = consolidatedData[processedDataList[i].startQrCode]!.X +
          processedDataList[i].X;
      double Y = consolidatedData[processedDataList[i].startQrCode]!.Y +
          processedDataList[i].Y;

      Point2D point = Point2D(name, X, Y);
      consolidatedData.update(
        name,
        (value) => point,
        ifAbsent: () => point,
      );
    } else if (consolidatedData.containsKey(processedDataList[i].endQrCode)) {
      String name = processedDataList[i].startQrCode;
      double X =
          consolidatedData[processedDataList[i].endQrCode.toString()]!.X +
              (-processedDataList[i].X);
      double Y = consolidatedData[processedDataList[i].endQrCode]!.Y +
          (-processedDataList[i].Y);

      Point2D point = Point2D(name, X, Y);
      consolidatedData.update(
        name,
        (value) => point,
        ifAbsent: () => point,
      );
    }
  }
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
        width: 100,
      ),
      SizedBox(
        child: Text(myText[1], textAlign: TextAlign.center),
        width: 100,
      ),
      SizedBox(
        child: Text(myText[2], textAlign: TextAlign.center),
        width: 100,
      ),
    ],
  );
}
