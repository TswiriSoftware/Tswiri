import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/multiple_barcode_scanner/multiple_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:numberpicker/numberpicker.dart';

import 'generated_barcodes_pdf_view.dart';

class BarcodeGeneratorView extends StatefulWidget {
  const BarcodeGeneratorView({Key? key}) : super(key: key);

  @override
  State<BarcodeGeneratorView> createState() => _BarcodeGeneratorViewState();
}

class _BarcodeGeneratorViewState extends State<BarcodeGeneratorView> {
  int timestamp = 0;

  int rangeStart = 0;
  int rangeEnd = 1;

  BarcodeGenerationEntry? lastBarcodeGenerationEntry;
  List<BarcodeGenerationEntry> barcodeGenerationHistory = [];

  List<String> generatedBarcodeUIDs = [];
  List<BarcodeProperty> generatedBarcodeProperties = [];

  int minValue = 0;
  int maxValue = 100;

  @override
  void initState() {
    getHistory();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barcode Generator',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //RangeSelector
            _rangeSelector(),
            //GenerateBarcodes.
            _generateBarcodes(),
            //Add pre generated barcodes.
            _addPreviousBarcodes(),
            //Debugging delete all.
            _deleteAll(),
            //Generatiom history.
            _barcodeHistory(),
            // barcodeGenerationHistoryWidget(),
          ],
        ),
      ),
    );
  }

  Widget _rangeSelector() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Select range to generate',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Divider(
              color: Colors.deepOrange,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Range: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                //RangeStart
                OrangeOutlineContainer(
                  padding: 0,
                  margin: 5,
                  child: NumberPicker(
                    haptics: true,
                    selectedTextStyle:
                        TextStyle(color: Colors.deepOrange[300], fontSize: 22),
                    itemHeight: 50,
                    itemWidth: 60,
                    minValue: minValue,
                    maxValue: maxValue,
                    value: rangeStart,
                    onChanged: (value) {
                      if (value >= rangeEnd) {
                        rangeEnd = value;
                      }
                      rangeStart = value;
                      setState(() {});
                    },
                  ),
                ),
                Text(
                  'to',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                //RangeEnd
                OrangeOutlineContainer(
                  padding: 0,
                  margin: 5,
                  child: NumberPicker(
                    haptics: true,
                    selectedTextStyle:
                        TextStyle(color: Colors.deepOrange[300], fontSize: 22),
                    itemHeight: 50,
                    itemWidth: 60,
                    minValue: minValue,
                    maxValue: maxValue,
                    value: rangeEnd,
                    onChanged: (value) {
                      if (value <= rangeStart) {
                        rangeStart = value;
                      }
                      rangeEnd = value;
                      //log(rangeEnd.toString());
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateBarcodes() {
    return ElevatedButton(
      onPressed: () async {
        int time = DateTime.now().millisecondsSinceEpoch;

        generateBarcodes(rangeStart, rangeEnd, time);

        writeToDatabase(time);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeGenerationView(
              barcodeUIDs: generatedBarcodeUIDs,
            ),
          ),
        );
        getHistory();
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Generate Barcodes',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Icon(Icons.add)
          ],
        ),
      ),
    );
  }

  Widget _deleteAll() {
    return ElevatedButton(
      onPressed: () {
        isarDatabase!.writeTxnSync((isar) {
          isar.barcodeGenerationEntrys.where().deleteAllSync();
          isar.barcodePropertys.where().deleteAllSync();
          getHistory();
          setState(() {});
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Delete All',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Icon(Icons.delete)
        ],
      ),
    );
  }

  Widget _addPreviousBarcodes() {
    return ElevatedButton(
      onPressed: () async {
        Set<String>? scannedBarcodes = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MultipleBarcodeScannerView()),
        );
        if (scannedBarcodes != null && scannedBarcodes.isNotEmpty) {
          createBarcodes(scannedBarcodes);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add Other',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Icon(Icons.add)
        ],
      ),
    );
  }

  Widget _barcodeHistory() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(builder: (context) {
          List<Widget> widgets = [
            Text(
              'History',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Divider(),
          ];
          widgets.addAll(
              barcodeGenerationHistory.map((e) => historyWidget(e)).toList());
          return Column(
            children: widgets,
          );
        }),
      ),
    );
  }

  Widget historyWidget(BarcodeGenerationEntry e) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: sunbirdOrange, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              DateFormat('yyyy-MM-dd, hh:mm a')
                  .format(DateTime.fromMillisecondsSinceEpoch(e.timestamp))
                  .toString(),
            ),
            Text(
              'Barcode Range: ' +
                  e.rangeStart.toString() +
                  ' to ' +
                  e.rangeEnd.toString(),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      generateBarcodes(e.rangeStart, e.rangeEnd, e.timestamp);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarcodeGenerationView(
                            barcodeUIDs: generatedBarcodeUIDs,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Reprint',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget barcodeGenerationHistoryWidget() {
    return LightDarkContainer(
      child: Column(
        children: [
          Text(
            'History',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const Divider(
            color: Colors.white54,
          ),
          Column(
            children: barcodeGenerationHistory
                .map((e) => LightContainer(
                      margin: 2.5,
                      padding: 0,
                      child: OrangeOutlineContainer(
                        padding: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd, hh:mm a')
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                      e.timestamp))
                                  .toString(),
                            ),
                            Text(
                              'Barcode Range: ' +
                                  e.rangeStart.toString() +
                                  ' to ' +
                                  e.rangeEnd.toString(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    generateBarcodes(
                                        e.rangeStart, e.rangeEnd, e.timestamp);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BarcodeGenerationView(
                                          barcodeUIDs: generatedBarcodeUIDs,
                                        ),
                                      ),
                                    );
                                  },
                                  child: OrangeOutlineContainer(
                                      child: Text(
                                    'Reprint',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  void generateBarcodes(int rangeStart1, int rangeEnd1, int timestamp) {
    generatedBarcodeUIDs = [];
    //log(rangeStart1.toString() + '       ' + rangeEnd1.toString());

    for (var i = rangeStart1; i < rangeEnd1; i++) {
      String barcodeUID = '${i + 1}_' + timestamp.toString();
      generatedBarcodeUIDs.add(barcodeUID);
      generatedBarcodeProperties.add(BarcodeProperty()
        ..barcodeUID = barcodeUID
        ..size = defaultBarcodeDiagonalLength!);
    }
    // log('generatedBarcodes: ' + generatedBarcodeUIDs.length.toString());
    setState(() {});
  }

  void createBarcodes(Set<String> scannedBarcodes) {
    List<BarcodeProperty> scannedList = [];

    for (String barcode in scannedBarcodes) {
      String barcodeUID = barcode;
      scannedList.add(BarcodeProperty()
        ..barcodeUID = barcodeUID
        ..size = defaultBarcodeDiagonalLength!);
    }

    isarDatabase!
        .writeTxnSync((isar) => isar.barcodePropertys.putAllSync(scannedList));
  }

  void writeToDatabase(int time) {
    isarDatabase!.writeTxnSync((isar) {
      //Create a barcodeGenerationEntry.
      isar.barcodeGenerationEntrys.putSync(BarcodeGenerationEntry()
        ..timestamp = time
        ..rangeStart = rangeStart
        ..rangeEnd = rangeEnd);

      //Create all the barcodeProperty entries.
      isar.barcodePropertys.putAllSync(generatedBarcodeProperties);
    });
    setState(() {});
  }

  void getHistory() {
    lastBarcodeGenerationEntry = isarDatabase!.barcodeGenerationEntrys
        .where()
        .sortByTimestampDesc()
        .findFirstSync();

    if (lastBarcodeGenerationEntry != null) {
      rangeStart = lastBarcodeGenerationEntry!.rangeEnd + 1;
      rangeEnd = rangeStart;
      minValue = lastBarcodeGenerationEntry!.rangeEnd + 1;
      maxValue = minValue + 100;
    }
    barcodeGenerationHistory = isarDatabase!.barcodeGenerationEntrys
        .where()
        .sortByTimestampDesc()
        .findAllSync();
  }
}
