import 'dart:developer';

import 'package:flutter/material.dart';
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

  int rangeStart = 1;
  int rangeEnd = 1;

  BarcodeGenerationEntry? lastBarcodeGenerationEntry;
  List<BarcodeGenerationEntry>? barcodeGenerationHistory;

  List<String> generatedBarcodeUIDs = [];
  List<BarcodeProperty> generatedBarcodeProperties = [];

  int minValue = 1;
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
            rangeSelector(),
            //GenerateBarcodes.
            generateBarcodesButton(),
            //Debugging delete all.
            //deleteAllButton(),
            //Add pre generated barcodes.
            addPreGeneratedBarcodes(),
            //Generatiom history.
            barcodeGenerationHistoryWidget(),
          ],
        ),
      ),
    );
  }

  Widget rangeSelector() {
    return LightDarkContainer(
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
                    setState(() {
                      if (value >= rangeEnd) {
                        rangeEnd = value;
                      }
                      rangeStart = value;
                    });
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
                    setState(() {
                      if (value <= rangeStart) {
                        rangeStart = value;
                      }
                      rangeEnd = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget generateBarcodesButton() {
    return InkWell(
      onTap: () async {
        generateBarcodes(rangeStart, rangeEnd, null);
        writeToDatabase();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeGenerationView(
              barcodeUIDs: generatedBarcodeUIDs,
            ),
          ),
        );
        getHistory();
      },
      child: OrangeOutlineContainer(
        width: 200,
        height: 50,
        child: Center(
          child: Text(
            'Generate Barcodes',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  // Widget deleteAllButton() {
  //   return InkWell(
  //     onTap: () {
  //       isarDatabase!.writeTxnSync((isar) {
  //         isar.barcodeGenerationEntrys.where().deleteAllSync();
  //         isar.barcodePropertys.where().deleteAllSync();
  //         getHistory();
  //       });
  //     },
  //     child: const OrangeOutlineContainer(
  //       width: 100,
  //       child: Icon(
  //         Icons.delete_forever,
  //       ),
  //     ),
  //   );
  // }

  Widget addPreGeneratedBarcodes() {
    return InkWell(
      onTap: () async {
        Set<String>? scannedBarcodes = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MultipleBarcodeScannerView()),
        );
        if (scannedBarcodes != null && scannedBarcodes.isNotEmpty) {
          createBarcodes(scannedBarcodes);
        }
      },
      child: OrangeOutlineContainer(
        width: 200,
        height: 30,
        child: Center(
          child: Text(
            'Add other Barcodes',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
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
                    ?.map((e) => LightContainer(
                          margin: 2.5,
                          padding: 0,
                          child: OrangeOutlineContainer(
                            padding: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd, hh:mm a')
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
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
                                        generateBarcodes(e.rangeStart,
                                            e.rangeEnd, e.timestamp);
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }

  void generateBarcodes(int rangeStart, int rangeEnd, int? timestamp) {
    timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;
    //int numberOfBarcodes = (rangeEnd - rangeStart + 1);
    generatedBarcodeUIDs = [];

    for (var i = rangeStart; i < rangeEnd; i++) {
      String barcodeUID = '${i + 1}_' + timestamp.toString();
      generatedBarcodeUIDs.add(barcodeUID);
      generatedBarcodeProperties.add(BarcodeProperty()
        ..barcodeUID = barcodeUID
        ..size = defaultBarcodeDiagonalLength!);
    }
    log('generatedBarcodes: ' + generatedBarcodeUIDs.length.toString());
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

  void writeToDatabase() {
    isarDatabase!.writeTxnSync((isar) {
      //Create a barcodeGenerationEntry.
      isar.barcodeGenerationEntrys.putSync(BarcodeGenerationEntry()
        ..timestamp = timestamp
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

    setState(() {});
  }
}
