import 'package:flutter_google_ml_kit/functions/dataManipulation/add_fixed_point.dart';
import 'package:flutter_google_ml_kit/functions/dataManipulation/consolidate_processed_data.dart';
import 'package:flutter_google_ml_kit/functions/dataManipulation/generate_list_of_processed_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/barcode_marker.dart';
import 'package:flutter_google_ml_kit/objects/inter_barcode_vector.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

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
                setState(() {});
              },
              child: const Icon(Icons.delete),
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
                  //print(myText);
                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        displayDataPoint(['UID', 'X', 'Y', 'Fixed']),
                        const SizedBox(
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

    List<InterBarcodeVector> deduplicatedData =
        listProcessedData(processedDataBox);

    if (deduplicatedData.isNotEmpty) {
      addFixedPoint(deduplicatedData.first, consolidatedData);
    }

    consolidateProcessedData(
        deduplicatedData, consolidatedData, consolidatedDataBox);
    return _displayList(consolidatedData, displayList);
  }
}

List _displayList(
    Map<String, BarcodeMarker> consolidatedData, List displayList) {
  displayList.clear();
  consolidatedData.forEach((key, value) {
    displayList
        .add([value.id, value.position.x, value.position.y, value.fixed]);
  });
  displayList.sort((a, b) => a[0].compareTo(b[0]));
  return displayList;
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
