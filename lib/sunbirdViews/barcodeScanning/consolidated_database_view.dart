import 'package:flutter_google_ml_kit/databaseAdapters/consolidated_data_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/type_offset_adapter.dart';
import 'package:flutter_google_ml_kit/functions/round_to_double.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
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
                consolidatedDataBox.clear();

                Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() {});
                });
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Consolidated Data'),
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
    var consolidatedDataBox = await Hive.openBox('consolidatedDataBox');
    Map<String, ConsolidatedData> consolidatedData = {};
    Map consolidatedDataMap = consolidatedDataBox.toMap();
    consolidatedDataMap.forEach((key, value) {
      consolidatedData.putIfAbsent(key, () => value);
    });

    return _displayList(consolidatedData, displayList);
  }
}

List _displayList(
    Map<String, ConsolidatedData> consolidatedData, List displayList) {
  displayList.clear();
  consolidatedData.forEach((key, value) {
    displayList.add([
      value.uid,
      roundDouble(value.offset.x, 13),
      roundDouble(value.offset.y, 13),
      value.fixed
    ]);
  });
  displayList.sort((a, b) => a[0].compareTo(b[0]));
  return displayList;
}

displayDataPoint(var myText) {
  return Container(
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
          child: SizedBox(
            child: Text(myText[0], textAlign: TextAlign.center),
            width: 50,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: deepSpaceSparkle))),
          child: SizedBox(
            child: Text(myText[1], textAlign: TextAlign.center),
            width: 140,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: deepSpaceSparkle))),
          child: SizedBox(
            child: Text(myText[2], textAlign: TextAlign.center),
            width: 140,
          ),
        ),
        SizedBox(
          child: Text(myText[3], textAlign: TextAlign.center),
          width: 50,
        ),
      ],
    ),
  );
}
