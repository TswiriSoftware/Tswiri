import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';

import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class HiveDatabaseView extends StatefulWidget {
  const HiveDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseViewState createState() => _HiveDatabaseViewState();
}

class _HiveDatabaseViewState extends State<HiveDatabaseView> {
  var displayList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database'),
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
                var processedDataBox = await Hive.openBox('processedDataBox');
                var rawDataBox = await Hive.openBox('rawDataBox');
                processedDataBox.clear();
                rawDataBox.clear();
                showMyAboutDialog(context, "Deleted Hive Database");
              },
              child: const Icon(Icons.delete),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () async {
                setState(() {});
              },
              child: const Icon(Icons.refresh),
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
                          width: 30,
                        ),
                        SizedBox(
                          child: Text(text[1], textAlign: TextAlign.start),
                          width: 30,
                        ),
                        SizedBox(
                          child: Text(text[2], textAlign: TextAlign.start),
                          width: 75,
                        ),
                        SizedBox(
                          child: Text(text[3], textAlign: TextAlign.start),
                          width: 75,
                        ),
                        SizedBox(
                          child: Text(text[4], textAlign: TextAlign.start),
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
    var rawDataBox = await Hive.openBox('rawDataBox');
    var processedDataBox = await Hive.openBox('processedDataBox');
    _displayList(displayList, rawDataBox, processedDataBox);

    return displayList;
  }
}

_displayList(List displayList, Box rawDataBox, Box processedDataBox) {
  processRawData(rawDataBox, processedDataBox);

  displayList.clear();
  var processedData = processedDataBox.toMap();
  processedData.forEach((key, value) {
    RelativeQrCodes processedDataItem = value;
    List vectorData = [
      processedDataItem.uidStart,
      processedDataItem.uidEnd,
      processedDataItem.x,
      processedDataItem.y,
      processedDataItem.timestamp
    ];

    displayList.add(vectorData);
  });
}

processRawData(Box rawDataBox, Box processedDataBox) {
  var rawData = rawDataBox.toMap();
  List uids = [];
  uids.clear();
  rawData.forEach((key, value) {
    RelativeQrCodes data = value;
    //print(data);
    //print(vectorData);
    uids.add(data.uidStart);
    uids.removeDuplicates();
    if (!uids.contains(data.uidEnd)) {
      var qrCodesVector = RelativeQrCodes(
          uid: data.uid,
          uidStart: data.uidStart,
          uidEnd: data.uidEnd,
          x: data.x,
          y: data.y,
          timestamp: data.timestamp);
      processedDataBox.put(key, qrCodesVector);
    }
  });
  print('processedDataBox: ${processedDataBox.toMap()}');
}
