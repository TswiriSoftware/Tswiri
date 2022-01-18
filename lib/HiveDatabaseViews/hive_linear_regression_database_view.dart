import 'dart:math';

import 'package:fast_immutable_collections/src/base/iterable_extension.dart';
import 'package:fast_immutable_collections/src/ilist/list_extension.dart';
import 'package:fast_immutable_collections/src/imap/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/dataProcessors/barcode_data_procesor.dart';
import 'package:flutter_google_ml_kit/dataProcessors/objects.dart';
import 'package:flutter_google_ml_kit/database/raw_data_adapter.dart';
import 'package:flutter_google_ml_kit/widgets/alert_dialog_widget.dart';
import 'package:hive/hive.dart';

class HiveLinearRegressionDatabaseView extends StatefulWidget {
  const HiveLinearRegressionDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveLinearRegressionDatabaseViewState createState() =>
      _HiveLinearRegressionDatabaseViewState();
}

class _HiveLinearRegressionDatabaseViewState
    extends State<HiveLinearRegressionDatabaseView> {
  var displayList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Calibrated Database'),
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
                var matchedDataBox = await Hive.openBox('matchedDataBox');
                matchedDataBox.clear();
                displayList.clear();
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

                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   child: Text(text[0], textAlign: TextAlign.start),
                        //   width: 150,
                        // ),
                        // SizedBox(
                        //   child: Text(text[1], textAlign: TextAlign.start),
                        //   width: 150,
                        // ),
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
    displayList.clear();
    var matchedDataBox = await Hive.openBox('matchedDataBox');
    var xArray = [];
    var yArray = [];
    var matchedDataMap = matchedDataBox.toMap();
    double dX = 0;
    double oY = 0;

    matchedDataMap.forEach((key, value) {
      double dXi = double.parse(value.toString().split(',').last);
      double oYi = double.parse(value.toString().split(',').first);
      xArray.add(dXi);
      yArray.add(oYi);
      dX = dX + dXi;
      oY = oY + oYi;
    });

    double mX = dX / matchedDataMap.length;
    double mY = oY / matchedDataMap.length;

    double zS = 0;
    double qS = 0;

    for (var i = 0; i < matchedDataMap.length; i++) {
      zS = zS + ((xArray[i] - mX) * (yArray[i] - mY));
      qS = qS + pow((yArray[i] - mY), 2);
    }

    double m = zS / qS;
    double b = mX - (m * mY);

    debugPrint('$xArray , $yArray');

    debugPrint('x: $mX, y: $mY, m: $m, b: $b');

    displayList.add('');
    return displayList;
  }
}

//TODO: LinearEquation { properties : m,b }

//TODO: CalulateDistance 

//TODO: Calulate equation (Data ..... ) { output : Linear equation object}