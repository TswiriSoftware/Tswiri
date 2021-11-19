import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/consolidated_data_adapter.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class HiveDatabaseConsolidationView extends StatefulWidget {
  const HiveDatabaseConsolidationView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseConsolidationViewState createState() =>
      _HiveDatabaseConsolidationViewState();
}

class _HiveDatabaseConsolidationViewState
    extends State<HiveDatabaseConsolidationView> {
  List fixedPoints = ['1'];
  List qrCodesData = [];
  var displayList = [];
  var consolidatedDataPoints = [];

  @override
  void initState() {
    //consolidatingData(displayList);
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
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
              heroTag: null,
              onPressed: () {
                Hive.box('consolidatedDataBox').clear();
                qrCodesData.clear();
                showMyAboutDialog(context, "Deleted Database");
              },
              child: const Icon(Icons.delete),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                qrCodesData.clear();
                consolidatedDataPoints.clear();
                displayList.clear();
                Hive.box('consolidatedDataBox').clear();
                consolidatingData(displayList);
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
                  var text = myList[index].toString();
                  return Text(text);
                });
          }
        },
      ),
    );
  }

  Future<List> consolidatingData(List displayList) async {
    var rawDataBox = await Hive.openBox('rawDataBox');
    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');

    consolidatedDataPoints.add(fixedPoints[0]);
    consolidatedDataPoints.removeDuplicates();

    buildQrCodesData(rawDataBox, qrCodesData);
    addConsolidatedData(
        qrCodesData, consolidatedDataPoints, consolidatedDataBox);
    generatingDisplayList(consolidatedDataBox, displayList);

    return displayList;
  }
}

checkIfPointFixed(var point, var fixedPoints) {
  if (fixedPoints.contains(point)) {
    return true;
  } else {
    return false;
  }
}

buildQrCodesData(Box rawDataBox, List qrCodesData) {
  for (var i = 0; i < rawDataBox.length; i++) {
    QrCodes qrCodeData = rawDataBox.getAt(i);
    var qrCode = qrCodeData
        .toString()
        .split('_')
        .toString()
        .replaceAll(RegExp(r'[{\[\]\}]'), '')
        .split(',')
        .toList();

    qrCodesData.add(qrCode);
    qrCodesData.removeDuplicates();
  }
  //print(qrCodesData);
}

addConsolidatedData(
    var qrCodesData, var consolidatedDataPoints, Box consolidatedDataBox) {
  for (var i = 0; i < qrCodesData.length; i++) {
    if (consolidatedDataPoints.contains(qrCodesData[i][0])) {
      var consolidatedPoint = ConsolidatedData(
          uid: qrCodesData[i][1],
          X: 0.0 + double.parse(qrCodesData[i][2]),
          Y: 0.0 + double.parse(qrCodesData[i][3]),
          timeStamp: int.parse(qrCodesData[i][4]),
          fixed: false);
      consolidatedDataBox.put(qrCodesData[i][1], consolidatedPoint);
    }
  }
}

buildingPointTree() {}

generatingDisplayList(Box consolidatedDataBox, List displayList) {
  for (var i = 0; i < consolidatedDataBox.length; i++) {
    ConsolidatedData consolidatedPoint = consolidatedDataBox.getAt(i);
    var point = consolidatedPoint
        .toString()
        .split('_')
        .toString()
        .replaceAll(RegExp(r'[{\[\]\}]'), '')
        .split(',')
        .toList();
    displayList.add(point);
  }
}
