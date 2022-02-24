import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/functions/barcodeCalculations/type_offset_converters.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';

import '../../objects/real_barcode_position.dart';
import 'widgets/real_position_display_widget.dart';

class RealBarcodePositionDatabaseView extends StatefulWidget {
  const RealBarcodePositionDatabaseView({Key? key}) : super(key: key);

  @override
  _RealBarcodePositionDatabaseViewState createState() =>
      _RealBarcodePositionDatabaseViewState();
}

class _RealBarcodePositionDatabaseViewState
    extends State<RealBarcodePositionDatabaseView> {
  List displayList = [];

  @override
  void initState() {
    displayList.clear();
    super.initState();
  }

  @override
  void dispose() {
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
                Box<RealBarcodePostionEntry> consolidatedDataBox =
                    await Hive.openBox(realPositionsBoxName);
                await consolidatedDataBox.clear();

                setState(() {});
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Real Barcode Positions'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder<List<RealBarcodePosition>>(
          future: getRealPositions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<RealBarcodePosition> data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return RealPositionDisplayWidget(
                          realBarcodePosition: data[index]);
                    }),
              );
            } else if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
                style: const TextStyle(fontSize: 20, color: deeperOrange),
              );
            }
            // By default, show a CircularProgressIndicator
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List<RealBarcodePosition>> getRealPositions() async {
    //Open realPositionalData box.
    Box<RealBarcodePostionEntry> realPositionalData =
        await Hive.openBox(realPositionsBoxName);

    List<RealBarcodePostionEntry> realBarcodePostionEntries =
        realPositionalData.values.toList();

    List<RealBarcodePosition> realBarcodePositions = [];
    for (RealBarcodePostionEntry realBarcodePostionEntry
        in realBarcodePostionEntries) {
      realBarcodePositions.add(RealBarcodePosition(
          uid: realBarcodePostionEntry.uid,
          offset: typeOffsetToOffset(realBarcodePostionEntry.offset),
          zOffset: realBarcodePostionEntry.zOffset));
    }

    realBarcodePositions
        .sort((a, b) => int.parse(a.uid).compareTo(int.parse(b.uid)));
    return realBarcodePositions;
  }
}
