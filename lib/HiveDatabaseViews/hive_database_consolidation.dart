import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_data_procesor.dart';
import 'package:flutter_google_ml_kit/database/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/main.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabaseConsolidationView extends StatefulWidget {
  const HiveDatabaseConsolidationView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseConsolidationViewState createState() =>
      _HiveDatabaseConsolidationViewState();
}

class _HiveDatabaseConsolidationViewState
    extends State<HiveDatabaseConsolidationView> {
  List displayList = [];
  List fixedPoints = ['1'];
  List processedDataList = [];
  Map<String, List> consolidatedDataList = {};
  Map<String, List> currentPoints = {};

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
        future: consolidatingData(displayList),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
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

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(myText[0], textAlign: TextAlign.start),
                        width: 30,
                      ),
                      SizedBox(
                        child: Text(myText[1], textAlign: TextAlign.start),
                        width: 75,
                      ),
                      SizedBox(
                        child: Text(myText[2], textAlign: TextAlign.start),
                        width: 75,
                      ),
                      SizedBox(
                        child: Text(myText[3], textAlign: TextAlign.start),
                        width: 150,
                      ),
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  Future<List> consolidatingData(List displayList) async {
    displayList.clear();
    currentPoints.clear();

    var processedDataBox = await Hive.openBox('processedDataBox');
    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
    getProcessedData(processedDataBox, processedDataList);
    addFixedPoints(consolidatedDataList, fixedPoints);
    consolidateProcessedData(
        processedDataList, consolidatedDataList, fixedPoints, currentPoints);
    _displayList(consolidatedDataList, displayList);
    return displayList;
  }
}

_displayList(Map consolidatedDataList, List displayList) {
  for (var i = 0; i < consolidatedDataList.length; i++) {
    displayList.add([
      consolidatedDataList.keys.elementAt(i),
      consolidatedDataList.values.elementAt(i)[0],
      consolidatedDataList.values.elementAt(i)[1],
      consolidatedDataList.values.elementAt(i)[2]
    ]);
  }

  print('displayList: ${displayList.toIList()}');
}

getProcessedData(Box processedDataBox, List processedDataList) {
  processedDataList.clear();
  var processedData = processedDataBox.toMap();
  processedData.forEach((key, value) {
    List vectorData = value
        .toString()
        .replaceAll(RegExp(r'\[\]'), '')
        .replaceAll('_', ',')
        .replaceAll(' ', '')
        .split(',')
        .toList();
    processedDataList.add(vectorData);
  });
  print('processedDataList: ${processedDataList.toIList()}');
}

addFixedPoints(Map consolidatedDataList, List fixedPoints) {
  consolidatedDataList.clear();
  for (var i = 0; i < fixedPoints.length; i++) {
    consolidatedDataList.putIfAbsent(fixedPoints[i], () => [0.0, 0.0, 0]);
  }
  print('consolidatedDataList: $consolidatedDataList');
}

updatePoints(Map consolidatedDataList, Map currentPoints, List fixedPoints) {
  for (var i = 0; i < consolidatedDataList.length; i++) {
    if (fixedPoints.contains(consolidatedDataList.keys.elementAt(i))) {
      print('fixed point');
    } else {
      currentPoints.putIfAbsent(
          consolidatedDataList.keys.elementAt(i),
          () => [
                consolidatedDataList.values.elementAt(i)[0],
                consolidatedDataList.values.elementAt(i)[1]
              ]);
    }
  }
  print('currentPoints: ${currentPoints}');
}

consolidateProcessedData(List processedDataList, Map consolidatedDataList,
    List fixedPoints, Map currentPoints) {
  List points = [];
  for (var i = 0; i < processedDataList.length; i++) {
    if (fixedPoints.contains(processedDataList[i][0])) {
      print('point present');
    } else {
      points.add(processedDataList[i][0]);
    }
  }
  print(points);
  for (var i = 0; i < 5; i++) {
    for (var i = 0; i < processedDataList.length; i++) {
      if (points.contains(processedDataList[i][1]) &&
          fixedPoints.contains(processedDataList[i][0]) &&
          !currentPoints.keys.contains(processedDataList[i][1])) {
        //print(consolidatedDataList.indexOf(processedDataList[i][1]));
        consolidatedDataList.putIfAbsent(
            processedDataList[i][1],
            () => [
                  roundDouble(double.parse(processedDataList[i][2]), 1),
                  roundDouble(double.parse(processedDataList[i][3]), 1),
                  processedDataList[i][4]
                ]);
        updatePoints(consolidatedDataList, currentPoints, fixedPoints);
      }
      if (currentPoints.containsKey(processedDataList[i][0])) {
        consolidatedDataList.putIfAbsent(
            processedDataList[i][1],
            () => [
                  double.parse(processedDataList[i][2]) +
                      double.parse(
                          currentPoints[processedDataList[i][0]][0].toString()),
                  double.parse(processedDataList[i][3]) +
                      double.parse(
                          currentPoints[processedDataList[i][0]][0].toString()),
                  processedDataList[i][4]
                ]);
        updatePoints(consolidatedDataList, currentPoints, fixedPoints);
      }
    }
  }
  print('consolidatedDataList: ${consolidatedDataList.toIMap()}');
}
//double.parse(currentPoints[processedDataList[i][0]][0])

double roundDouble(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
