import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_scanning/multiple_barcode_scanner/multiple_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';

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
  int maximumBarcodes = 250;
  int timestamp = 0;

  int rangeStart = 1;
  int rangeEnd = 1;

  BarcodeGenerationEntry? lastBarcodeGenerationEntry;
  List<BarcodeGenerationEntry> barcodeGenerationHistory = [];

  final TextEditingController barcodeSizeController = TextEditingController();

  List<String> generatedBarcodeUIDs = [];
  List<BarcodeProperty> generatedBarcodeProperties = [];

  int minValue = 1;
  late int maxValue = maximumBarcodes;

  BarcodeGenerationEntry? newBarcodeGenerationObject;

  @override
  void initState() {
    getHistory();
    barcodeSizeController.text = '75.0';
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
            _rangeSelectorCard(),
            //Size selector
            _barcodeSizeCard(),
            //GenerateBarcodes.
            _generateBarcodesButton(),

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

  Widget _rangeSelectorCard() {
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
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  color: Colors.black38,
                  elevation: 5,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: sunbirdOrange, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NumberPicker(
                      haptics: true,
                      selectedTextStyle: TextStyle(
                          color: Colors.deepOrange[300], fontSize: 22),
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
                ),
                //RangeStart

                Text(
                  'to',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  color: Colors.black38,
                  elevation: 5,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: sunbirdOrange, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NumberPicker(
                      haptics: true,
                      selectedTextStyle: TextStyle(
                          color: Colors.deepOrange[300], fontSize: 22),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _barcodeSizeCard() {
    return defaultCard(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Barcode Size: '),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    barcodeSizeController.text = double.parse(value).toString();
                  }
                },
                onChanged: (value) {},
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: barcodeSizeController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Text(
              'mm',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'x',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    barcodeSizeController.text = double.parse(value).toString();
                    log(barcodeSizeController.text);
                  }
                },
                onChanged: (value) {},
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: barcodeSizeController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Text(
              'mm',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        color: sunbirdOrange);
  }

  Widget _generateBarcodesButton() {
    return ElevatedButton(
      onPressed: () async {
        int time = DateTime.now().millisecondsSinceEpoch;

        //Create a barcodeGenerationEntry.

        double size = defaultBarcodeDiagonalLength!;
        if (barcodeSizeController.text.isNotEmpty) {
          size = double.parse(barcodeSizeController.text);
        }

        newBarcodeGenerationObject = BarcodeGenerationEntry()
          ..timestamp = time
          ..rangeStart = rangeStart
          ..rangeEnd = rangeEnd
          ..size = size;

        List<String> newBarcodes =
            generateBarcodes(newBarcodeGenerationObject!);

        List<BarcodeProperty> newBarcodeProperties = newBarcodes
            .map((e) => BarcodeProperty()
              ..barcodeUID = e
              ..size = newBarcodeGenerationObject!.size)
            .toList();

        isarDatabase!.writeTxnSync((isar) {
          //BarcodeGenerationObject.
          isar.barcodeGenerationEntrys.putSync(newBarcodeGenerationObject!);
          //BarcodeProperty entries.
          isar.barcodePropertys.putAllSync(newBarcodeProperties);
        });

        setState(() {
          minValue = newBarcodeGenerationObject!.rangeEnd;
          rangeStart = minValue;
          rangeEnd = minValue + 1;
          maxValue = minValue + maximumBarcodes;
          barcodeGenerationHistory =
              isarDatabase!.barcodeGenerationEntrys.where().findAllSync();
        });

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BarcodeGenerationView(
                  barcodeUIDs: generateBarcodes(newBarcodeGenerationObject!),
                  size: newBarcodeGenerationObject!.size)),
        );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Created on:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  DateFormat('yyyy-MM-dd, hh:mm a')
                      .format(DateTime.fromMillisecondsSinceEpoch(e.timestamp))
                      .toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Range:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  e.rangeStart.toString() + ' to ' + e.rangeEnd.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Barcode Size:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      e.size.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      double? newSize = await sizeEditor(e.size);
                      if (newSize != null && newSize != e.size) {
                        e.size = newSize;
                        //update size
                        isarDatabase!.writeTxnSync((isar) => isar
                            .barcodeGenerationEntrys
                            .putSync(e, replaceOnConflict: true));

                        List<String> barcodeUIDS = generateBarcodes(e);
                        isarDatabase!.writeTxnSync((isar) => isar
                            .barcodePropertys
                            .filter()
                            .repeat(
                                barcodeUIDS,
                                (q, String element) =>
                                    q.barcodeUIDMatches(element))
                            .deleteAllSync());

                        List<BarcodeProperty> newBarcodeProperties = barcodeUIDS
                            .map((e) => BarcodeProperty()
                              ..barcodeUID = e
                              ..size = newSize)
                            .toList();

                        isarDatabase!.writeTxnSync((isar) => isar
                            .barcodePropertys
                            .putAllSync(newBarcodeProperties));
                      }
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    isarDatabase!.writeTxnSync((isar) =>
                        isar.barcodeGenerationEntrys.deleteSync(e.id));
                    setState(() {
                      barcodeGenerationHistory = isarDatabase!
                          .barcodeGenerationEntrys
                          .where()
                          .findAllSync();
                      if (barcodeGenerationHistory.isNotEmpty) {
                        minValue = barcodeGenerationHistory.last.rangeEnd;
                        rangeStart = minValue;
                        rangeEnd = minValue + 1;
                        maxValue = minValue + maximumBarcodes;
                      } else {
                        minValue = 1;
                        rangeStart = minValue;
                        rangeEnd = minValue + 1;
                        maxValue = minValue + maximumBarcodes;
                      }
                    });
                  },
                  child: Text(
                    'Delete',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarcodeGenerationView(
                          barcodeUIDs: generateBarcodes(e),
                          size: e.size,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Reprint',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<String> generateBarcodes(BarcodeGenerationEntry generationEntry) {
    generatedBarcodeUIDs = [];

    for (var i = generationEntry.rangeStart;
        i <= generationEntry.rangeEnd;
        i++) {
      String barcodeUID = '${i}_' + generationEntry.timestamp.toString();
      generatedBarcodeUIDs.add(barcodeUID);
      generatedBarcodeProperties.add(BarcodeProperty()
        ..barcodeUID = barcodeUID
        ..size = generationEntry.size);
    }
    return generatedBarcodeUIDs;
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

  void getHistory() {
    lastBarcodeGenerationEntry = isarDatabase!.barcodeGenerationEntrys
        .where()
        .sortByTimestampDesc()
        .findFirstSync();

    if (lastBarcodeGenerationEntry != null) {
      rangeStart = lastBarcodeGenerationEntry!.rangeEnd + 1;
      rangeEnd = rangeStart;
      minValue = lastBarcodeGenerationEntry!.rangeEnd + 1;
      maxValue = minValue + maximumBarcodes;
    }
    barcodeGenerationHistory = isarDatabase!.barcodeGenerationEntrys
        .where()
        .sortByTimestampDesc()
        .findAllSync();
  }

  Future<double?> sizeEditor(double currentSize) async {
    double? size = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (initialDialogContext) {
        TextEditingController sizeContoller = TextEditingController();
        sizeContoller.text = currentSize.toString();
        return AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.all(5),
          title: const Text('Size'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Size: '),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      sizeContoller.text = double.parse(value).toString();
                    }
                  },
                  onChanged: (value) {},
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: sizeContoller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Text(
                'mm',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'x',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      sizeContoller.text = double.parse(value).toString();
                      // log(sizeContoller.text);
                    }
                  },
                  onChanged: (value) {},
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: sizeContoller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Text(
                'mm',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                double newSize = currentSize;
                if (sizeContoller.text.isNotEmpty) {
                  newSize = double.parse(sizeContoller.text);
                }
                Navigator.pop(initialDialogContext, newSize);
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
    return size;
  }
}
