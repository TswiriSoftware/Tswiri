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
  var qrCodesData = [];
  var displayList = [];

  @override
  void initState() {
    displayList.clear();
    consolidatingData(displayList);
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
                // qrCodesData.clear();
                // displayList.clear();
                // Hive.box('consolidatedDataBox').clear();
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
      if (fixedPoints.contains(qrCode[0])) {
        var consolidatedPoint = ConsolidatedData(
            uid: qrCode[0], X: 0.0, Y: 0.0, timeStamp: 0, fixed: true);
        print(consolidatedPoint.toString());
        consolidatedDataBox.put(qrCode[0], consolidatedPoint);
        qrCodesData.removeAt(i);
      }
    }
    //print(qrCodesData.toIList());

    //print(consolidatedDataBox.values.toIList());
    // for (var i = 0; i < consolidatedDataBox.length; i++) {
    //   //print(consolidatedDataBox.length);
    //   ConsolidatedData fixedPoints = consolidatedDataBox.getAt(i);
    //   for (var j = 0; j < qrCodesData.length; j++) {
    //     if (fixedPoints.uid == qrCodesData[j][0] &&
    //         fixedPoints.uid != qrCodesData[j][1]) {
    //       var consolidatedPoint = ConsolidatedData(
    //           uid: qrCodesData[j][1],
    //           X: double.parse(qrCodesData[j][2]) + fixedPoints.X,
    //           Y: double.parse(qrCodesData[j][2]) + fixedPoints.Y,
    //           timeStamp: int.parse(qrCodesData[j][4]),
    //           fixed: false);

    //       consolidatedDataBox.put(qrCodesData[j][1], consolidatedPoint);
    //     }
    //   }
    // }

    // for (var i = 0; i < consolidatedDataBox.length; i++) {
    //   displayList.add([consolidatedDataBox.getAt(i)]);
    // }

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



    // for (var i = 0; i < rawDataBox.length; i++) {
    //   QrCodes qrCodeData = rawDataBox.getAt(i);
    //   var qrCodeUid = qrCodeData.uid;
    //   qrCodeUids.add(qrCodeUid); ////print(input.split('').reversed.join());
    // }
    // for (var i = 0; i < qrCodeUids.length; i++) {
    //   var x = qrCodeUids[i].split('').reversed.join();
    //   print(x);
    //   rawDataBox.delete(x);
    // }
    // print(rawDataBox);