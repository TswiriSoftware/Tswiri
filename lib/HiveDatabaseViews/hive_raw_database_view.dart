import 'package:fast_immutable_collections/src/base/iterable_extension.dart';
import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:fast_immutable_collections/src/imap/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_data_procesor.dart';
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

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
    List vectorData = value
        .toString()
        .replaceAll(RegExp(r'\[\]'), '')
        .replaceAll('_', ',')
        .replaceAll(' ', '')
        .split(',')
        .toList();

    displayList.add(vectorData);
  });
}

processRawData(Box rawDataBox, Box processedDataBox) {
  var rawData = rawDataBox.toMap();
  List uids = [];
  uids.clear();
  rawData.forEach((key, value) {
    List vectorData = value
        .toString()
        .replaceAll(RegExp(r'\[\]'), '')
        .replaceAll('_', ',')
        .replaceAll(' ', '')
        .split(',')
        .toList();
    //print(vectorData);
    uids.add(vectorData[0].toString());
    uids.removeDuplicates();
    if (uids.contains(vectorData[1])) {
    } else {
      var qrCodesVector = QrCodes(
          uid: '${vectorData[0]}_${vectorData[1]}'.toString(),
          X: double.parse(vectorData[2]),
          Y: double.parse(vectorData[3]),
          createdDated: int.parse(vectorData[4]));
      processedDataBox.put('${vectorData[0]}_${vectorData[1]}', qrCodesVector);
    }
  });
}
