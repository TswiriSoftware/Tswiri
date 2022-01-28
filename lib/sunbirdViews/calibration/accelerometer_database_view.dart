import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class AccelerometerDatabaseView extends StatefulWidget {
  const AccelerometerDatabaseView({Key? key}) : super(key: key);

  @override
  _AccelerometerDatabaseViewState createState() =>
      _AccelerometerDatabaseViewState();
}

class _AccelerometerDatabaseViewState extends State<AccelerometerDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Accelerometer Database'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List myList = snapshot.data ?? [];
            //print(myList);
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
                        displayDataPoint([
                          'Timestamp',
                          'deltaT',
                          'Acceleration',
                          'Distance'
                        ]),
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
    displayList.clear();
    var accelerometerDataBox = await Hive.openBox('accelerometerDataBox');
    var calibrationMap = {};
    calibrationMap = accelerometerDataBox.toMap();

    calibrationMap.forEach((key, value) {
      displayList.add(value);
    });
    return displayList;
  }
}

displayDataPoint(var myText) {
  return Column(
    children: [
      const SizedBox(
        height: 3,
      ),
      Container(
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
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  child: Text(myText[0], textAlign: TextAlign.center),
                  width: 110,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: deepSpaceSparkle))),
              child: SizedBox(
                child: Text(myText[1], textAlign: TextAlign.center),
                width: 50,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: deepSpaceSparkle))),
              child: SizedBox(
                child: Text(myText[2], textAlign: TextAlign.center),
                width: 90,
              ),
            ),
            SizedBox(
              child: Text(myText[3], textAlign: TextAlign.center),
              width: 75,
            ),
          ],
        ),
      ),
    ],
  );
}
