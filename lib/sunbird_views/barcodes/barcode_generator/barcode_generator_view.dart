import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_generation_entry/barcode_generation_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_property/barcode_property.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcodes/barcode_generator/generated_barcodes_pdf_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:numberpicker/numberpicker.dart';
import '../barcode_scanning/multiple_barcode_scanner/multiple_barcode_scanner_view.dart';

class BarcodeGeneratorView extends StatefulWidget {
  const BarcodeGeneratorView({Key? key}) : super(key: key);

  @override
  State<BarcodeGeneratorView> createState() => _BarcodeGeneratorViewState();
}

class _BarcodeGeneratorViewState extends State<BarcodeGeneratorView> {
  final int maxBarcodes = 1000;

  final TextEditingController barcodeSizeController = TextEditingController();

  final Map<String, double> barcodeSizes = {
    'Extra Small': 20,
    'Small': 30,
    'Medium': 50,
    'Large': 60,
    'Extra Large': 75,
    'Custom': 100,
  };

  final Map<String, int> barcodesPerPage = {
    'Extra Small': 80,
    'Small': 35,
    'Medium': 12,
    'Large': 6,
    'Extra Large': 6,
    'Custom': 100,
  };

  late List<BarcodeGenerationEntry> generationHistory =
      isarDatabase!.barcodeGenerationEntrys.where().findAllSync();

  late int rangeStart = 0;
  late int rangeEnd = rangeStart + 1;

  //Max value on the numberPicker
  late int maxValue = rangeStart + maxBarcodes;

  late List<DropdownMenuItem<String>> menuItems = barcodeSizes.keys
      .map((e) => DropdownMenuItem<String>(
            child: Text(e),
            value: e,
          ))
      .toList();

  late String selectedBarcodeSize = menuItems.first.value!;

  @override
  void initState() {
    barcodeSizeController.text = '100.0';
    _updateRange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Barcode Generator',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        PopupMenuButton<String>(
          tooltip: 'More Options',
          onSelected: (value) async {
            switch (value) {
              case 'import':
                Set<String>? scannedBarcodes = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MultipleBarcodeScannerView()),
                );
                if (scannedBarcodes != null && scannedBarcodes.isNotEmpty) {
                  List<int> range = scannedBarcodes
                      .map((e) => int.parse(e.split('_').first))
                      .toList();
                  range.sort();

                  int timestamp =
                      int.parse(scannedBarcodes.first.split('_').last);
                  BarcodeGenerationEntry importedBarcodeEntry =
                      BarcodeGenerationEntry()
                        ..rangeStart = range.first
                        ..rangeEnd = range.last
                        ..size = defaultBarcodeDiagonalLength!
                        ..timestamp = timestamp
                        ..barcodeUIDs = scannedBarcodes.toList();

                  List<BarcodeProperty> barcodeProperties = scannedBarcodes
                      .map((e) => BarcodeProperty()
                        ..barcodeUID = e
                        ..size = defaultBarcodeDiagonalLength!)
                      .toList();
                  isarDatabase!.writeTxnSync((isar) {
                    isar.barcodeGenerationEntrys.putSync(importedBarcodeEntry);
                    isar.barcodePropertys.putAllSync(barcodeProperties);
                  });
                  _updateHitory();
                  _updateRange();
                }
                break;
              default:
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text(
                  'Import Barcodes',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                value: 'import',
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _rangeSelectorCard(),
          _barcodeSizeCard(),
          _history(),
        ],
      ),
    );
  }

  ///Range///
  Card _rangeSelectorCard() {
    return defaultCard(
        body: Column(
          children: [
            Text(
              'Select Barcode Range',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(
              color: Colors.deepOrange,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Start: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  '$rangeStart',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                _numberPicker()
              ],
            )
          ],
        ),
        color: sunbirdOrange);
  }

  Row _numberPicker() {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  rangeEnd = rangeStart;
                });
              },
              icon: const Icon(Icons.arrow_drop_up),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'to',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  rangeEnd = maxValue;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
        defaultCard(
            body: NumberPicker(
              haptics: true,
              selectedTextStyle:
                  const TextStyle(color: sunbirdOrange, fontSize: 22),
              itemHeight: 50,
              itemWidth: 50,
              minValue: rangeStart,
              maxValue: maxValue,
              value: rangeEnd,
              onChanged: (value) {
                setState(() {
                  rangeEnd = value;
                });
              },
            ),
            color: sunbirdOrange),
      ],
    );
  }

  ///Size///
  Card _barcodeSizeCard() {
    return defaultCard(
      body: Column(
        children: [
          Text(
            'Select Barcode Size',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Select Size: ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              DropdownButton<String>(
                value: selectedBarcodeSize,
                items: menuItems,
                onChanged: (String? item) {
                  setState(() {
                    selectedBarcodeSize = item!;
                  });
                },
              ),
            ],
          ),
          defaultCard(
            body: Builder(builder: (context) {
              if (selectedBarcodeSize != 'Custom') {
                return Column(
                  children: [
                    Text(
                      'Barcode Size: ${barcodeSizes[selectedBarcodeSize]} mm',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Barcodes Per Page: ${barcodesPerPage[selectedBarcodeSize]}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                );
              } else {
                return _customBarcodeSize();
              }
            }),
            color: sunbirdOrange,
          ),
          _generateBarcodes(),
        ],
      ),
      color: sunbirdOrange,
    );
  }

  Row _customBarcodeSize() {
    return Row(
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
    );
  }

  ///Generate///
  ElevatedButton _generateBarcodes() {
    return ElevatedButton(
      onPressed: () {
        _createBarcodeGenerationEntry();
      },
      child: Text(
        'Generate Barcodes',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  ///History///
  Widget _history() {
    return defaultCard(
      body: Column(
        children: [
          Text(
            'History',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(
            color: Colors.deepOrange,
          ),
          for (BarcodeGenerationEntry e in generationHistory) _historyWidget(e)
        ],
      ),
      color: sunbirdOrange,
    );
  }

  Widget _historyWidget(BarcodeGenerationEntry e) {
    return defaultCard(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        .format(
                            DateTime.fromMillisecondsSinceEpoch(e.timestamp))
                        .toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Text(
                'ID: ${e.id}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Divider(
            thickness: 0.2,
            color: Colors.deepOrange,
          ),
          _historyRange(e.rangeStart, e.rangeEnd),
          const Divider(
            thickness: 0.2,
            color: Colors.deepOrange,
          ),
          _historySize(e),
          const Divider(
            thickness: 0.2,
            color: Colors.deepOrange,
          ),
          _historyActions(e),
        ],
      ),
      color: sunbirdOrange,
    );
  }

  Column _historyRange(int start, int end) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Range:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          start.toString() + ' to ' + end.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Row _historySize(BarcodeGenerationEntry e) {
    return Row(
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
              double? newSize = await _sizeEditor(e.size);

              if (newSize != e.size) {
                e.size = newSize;

                isarDatabase!.writeTxnSync((isar) => isar
                    .barcodeGenerationEntrys
                    .putSync(e, replaceOnConflict: true));

                setState(() {
                  generationHistory = isarDatabase!.barcodeGenerationEntrys
                      .where()
                      .findAllSync();
                });
              }
            },
            icon: const Icon(Icons.edit))
      ],
    );
  }

  Row _historyActions(BarcodeGenerationEntry e) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            isarDatabase!.writeTxnSync((isar) {
              isar.barcodeGenerationEntrys.deleteSync(e.id);
              isar.barcodePropertys
                  .filter()
                  .repeat(e.barcodeUIDs,
                      (q, String element) => q.barcodeUIDMatches(element))
                  .deleteAllSync();
            });
            _updateHitory();
            _updateRange();
          },
          child: Text(
            'Delete',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _createPDF(e);
          },
          child: Text(
            'Reprint',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  ///Functions///
  void _createBarcodeGenerationEntry() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    double size = barcodeSizes[selectedBarcodeSize]!;

    if (selectedBarcodeSize == 'Custom') {
      size = double.parse(barcodeSizeController.text);
    }
    //Generate BarcodeProperties
    List<String> generatedBarcodeUIDs = [];
    List<BarcodeProperty> generatedBarcodeProperties = [];

    for (var i = rangeStart; i <= rangeEnd; i++) {
      String barcodeUID = '${i}_' + timestamp.toString();
      generatedBarcodeUIDs.add(barcodeUID);
      generatedBarcodeProperties.add(BarcodeProperty()
        ..barcodeUID = barcodeUID
        ..size = size);
    }

    BarcodeGenerationEntry newBarcodeGenerationEntry = BarcodeGenerationEntry()
      ..rangeStart = rangeStart
      ..rangeEnd = rangeEnd
      ..timestamp = timestamp
      ..size = size
      ..barcodeUIDs = generatedBarcodeUIDs;

    //Write to database.
    isarDatabase!.writeTxnSync((isar) {
      isar.barcodePropertys.putAllSync(generatedBarcodeProperties);
      isar.barcodeGenerationEntrys.putSync(newBarcodeGenerationEntry);
    });

    _createPDF(newBarcodeGenerationEntry);
    _updateRange();
  }

  void _updateRange() {
    if (generationHistory.isNotEmpty) {
      setState(() {
        rangeStart = generationHistory.last.rangeEnd + 1;
        rangeEnd = rangeStart + 1;
      });
    } else {
      setState(() {
        rangeStart = 1;
        rangeEnd = rangeStart + 1;
      });
    }
  }

  void _createPDF(BarcodeGenerationEntry barcodeGenerationEntry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeGenerationView(
          barcodeUIDs: barcodeGenerationEntry.barcodeUIDs,
          size: barcodeGenerationEntry.size,
          start: barcodeGenerationEntry.rangeStart,
          end: barcodeGenerationEntry.rangeEnd,
        ),
      ),
    );

    _updateHitory();
  }

  void _updateHitory() {
    setState(() {
      generationHistory =
          isarDatabase!.barcodeGenerationEntrys.where().findAllSync();
    });
  }

  Future<double> _sizeEditor(double size) async {
    double size = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (initialDialogContext) {
        return AlertDialog(
          title: Text('Edit Barcode Size'),
          content: Row(
            children: [
              const Text('Size: '),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      barcodeSizeController.text =
                          double.parse(value).toString();
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
                ' x',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      barcodeSizeController.text =
                          double.parse(value).toString();
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
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(initialDialogContext);
              },
              child: const Text('close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(initialDialogContext,
                    double.parse(barcodeSizeController.text));
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
