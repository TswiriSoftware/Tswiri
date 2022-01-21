import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/data_manipulation/process_raw_data.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class HiveDatabaseView extends StatefulWidget {
  const HiveDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseViewState createState() => _HiveDatabaseViewState();
}

class _HiveDatabaseViewState extends State<HiveDatabaseView> {
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
                setState(() {});
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
            return ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  var text = myList[index]
                      .toString()
                      .replaceAll(RegExp(r'\[|\]'), '')
                      .replaceAll(' ', '')
                      .split(',')
                      .toList();

                  if (index == 0) {
                    return Column(
                      children: <Widget>[
                        displayDataPoint(
                            ['UID 1', 'UID 2', 'X', 'Y', 'Timestamp']),
                        const SizedBox(
                          height: 5,
                        ),
                        displayDataPoint(text),
                      ],
                    );
                  } else {
                    return displayDataPoint(text);
                  }
                });
          }
        },
      ),
    );
  }

  Future<List> loadData() async {
    var rawDataBox = await Hive.openBox('rawDataBox');
    var processedDataBox = await Hive.openBox('processedDataBox');
    processRawData(rawDataBox, processedDataBox);
    return _displayList(rawDataBox);
  }
}

List _displayList(Box rawDataBox) {
  var displayList = [];
  var rawDataMap = rawDataBox.toMap();
  rawDataMap.forEach((key, value) {
    List vectorData = [
      value.uidStart,
      value.uidEnd,
      value.x,
      value.y,
      value.timestamp
    ];
    displayList.add(vectorData);
  });
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
        width: 35,
      ),
      SizedBox(
        child: Text(myText[1], textAlign: TextAlign.center),
        width: 35,
      ),
      SizedBox(
        child: Text(myText[2], textAlign: TextAlign.center),
        width: 50,
      ),
      SizedBox(
        child: Text(myText[3], textAlign: TextAlign.center),
        width: 50,
      ),
      SizedBox(
        child: Text(myText[4], textAlign: TextAlign.center),
        width: 125,
      ),
    ],
  );
}
