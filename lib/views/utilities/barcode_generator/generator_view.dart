import 'package:tswiri/views/ml_kit/barcode_import/barcode_import_scanner.dart';
import 'package:tswiri/views/utilities/barcode_generator/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class GeneratorView extends StatefulWidget {
  const GeneratorView({Key? key}) : super(key: key);

  @override
  State<GeneratorView> createState() => _GeneratorViewState();
}

class _GeneratorViewState extends State<GeneratorView> {
  //Number of barcodes.
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _numberNode = FocusNode();
  bool isEditingNumberOfBarcodes = false;
  int numberOfBarocdes = 1;

  //Barcode Size.
  final TextEditingController _sizeController = TextEditingController();
  late List<DropdownMenuItem<String>> menuItems = barcodeSizes.keys
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

  late String selectedBarcodeSize = menuItems[3].value!;
  late double barcodeSize = barcodeSizes[selectedBarcodeSize]!;

  //Barcode Batches
  late List<BarcodeBatch> barcodeBatches =
      isar!.barcodeBatchs.where().findAllSync();

  bool isEditingSize = false;

  @override
  void initState() {
    _sizeController.text = barcodeSize.toString();
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
      title: Text(
        'Barcode Generator',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Import Barcodes",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ];
          },
          onSelected: (value) async {
            if (value == 0) {
              Set<String>? scannedBarcodes = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarcodeImportScannerView(),
                ),
              );

              if (scannedBarcodes != null && scannedBarcodes.isNotEmpty) {
                _importBarcodes(scannedBarcodes);
              }
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _barcodeSetup(),
          _batchHistory(),
        ],
      ),
    );
  }

  Widget _barcodeSetup() {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Generate',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          _numberSelection(),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          _barcodeSize(),
        ],
      ),
    );
  }

  Widget _numberSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Number of Barcodes: ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '(Tap to enter custom amount)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Builder(builder: (context) {
            if (isEditingNumberOfBarcodes) {
              return _numberInput();
            }
            return _numberPicker();
          }),
        ],
      ),
    );
  }

  Widget _numberInput() {
    return Card(
      color: background[300],
      child: SizedBox(
        width: 150,
        height: 150,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: _numberNode,
              controller: _numberController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                setState(() {
                  numberOfBarocdes = int.tryParse(value) ?? numberOfBarocdes;
                  isEditingNumberOfBarcodes = false;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _numberPicker() {
    return Card(
      color: background[300],
      child: InkWell(
        onTap: () {
          setState(() {
            isEditingNumberOfBarcodes = true;
            _numberNode.requestFocus();
          });
        },
        child: NumberPicker(
          minValue: 1,
          maxValue: 1000,
          itemWidth: 75,
          value: numberOfBarocdes,
          onChanged: (value) {
            setState(() {
              numberOfBarocdes = value;
            });
          },
          selectedTextStyle: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _barcodeSize() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Barcode Size: ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Card(
                color: background[300],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: DropdownButton<String>(
                    value: selectedBarcodeSize,
                    items: menuItems,
                    onChanged: (String? item) {
                      setState(() {
                        selectedBarcodeSize = item!;
                        barcodeSize = barcodeSizes[selectedBarcodeSize]!;
                        _sizeController.text = barcodeSize.toString();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          _customSize(),
          _sizeDisplay(),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          _generateButton(),
        ],
      ),
    );
  }

  Widget _customSize() {
    return Visibility(
      visible: selectedBarcodeSize == 'Custom',
      child: Card(
        color: background[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Text(
                'Side Length: ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Flexible(
                child: TextField(
                  controller: _sizeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      barcodeSize = double.tryParse(value) ?? barcodeSize;
                    });
                  },
                ),
              ),
              Text(
                ' x ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Flexible(
                child: TextField(
                  controller: _sizeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      barcodeSize = double.tryParse(value) ?? barcodeSize;
                    });
                  },
                ),
              ),
              Text(
                'mm',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sizeDisplay() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Size: $barcodeSize mm',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const VerticalDivider(),
            Visibility(
              visible: selectedBarcodeSize != 'Custom',
              child: Text(
                'Barcodes Per Page: ${barcodesPerPage[selectedBarcodeSize]}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateButton() {
    return ElevatedButton(
      onPressed: () async {
        _generateBarcodeBatch();
      },
      child: Text(
        'Generate',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _batchHistory() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'History',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          _batchList(),
        ],
      ),
    );
  }

  Widget _batchList() {
    return Column(
      children: barcodeBatches.map((e) => _batch(e)).toList(),
    );
  }

  Widget _batch(BarcodeBatch batch) {
    final TextEditingController batchHeightController = TextEditingController();
    final TextEditingController batchWidthController = TextEditingController();
    final FocusNode batchHeightNode = FocusNode();
    final FocusNode batchWidthNode = FocusNode();
    return Card(
      key: UniqueKey(),
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd - HH:m')
                      .format(
                          DateTime.fromMillisecondsSinceEpoch(batch.timestamp))
                      .toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'ID: ${batch.id}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const Divider(
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Number of barcodes: ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  isar!.catalogedBarcodes
                      .filter()
                      .batchIDEqualTo(batch.id)
                      .findAllSync()
                      .length
                      .toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Height:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Builder(builder: (context) {
                  if (isEditingSize == true) {
                    batchHeightController.text = batch.height.toString();
                    return Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: batchHeightController,
                            focusNode: batchHeightNode,
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              double newSize =
                                  double.tryParse(value) ?? batch.height;

                              if (newSize != batch.height) {
                                batch.height = newSize;

                                isar!.writeTxnSync((isar) => isar.barcodeBatchs
                                    .putSync(batch, replaceOnConflict: true));

                                List<CatalogedBarcode> relatedBarcodes = isar!
                                    .catalogedBarcodes
                                    .filter()
                                    .batchIDEqualTo(batch.id)
                                    .findAllSync();

                                isar!.writeTxnSync((isar) {
                                  for (CatalogedBarcode barcode
                                      in relatedBarcodes) {
                                    barcode.height = newSize;
                                    isar.catalogedBarcodes.putSync(barcode,
                                        replaceOnConflict: true);
                                  }
                                });

                                _updateBarcodeBatches();
                              }

                              setState(() {
                                isEditingSize = false;
                              });
                            },
                          ),
                        ),
                        Text(
                          'mm',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditingSize = true;
                        batchHeightNode.requestFocus();
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          batch.height.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '(tap to edit)',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            const Divider(
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Width:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Builder(builder: (context) {
                  if (isEditingSize == true) {
                    batchWidthController.text = batch.width.toString();
                    return Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: batchWidthController,
                            focusNode: batchWidthNode,
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              double newSize =
                                  double.tryParse(value) ?? batch.width;

                              if (newSize != batch.width) {
                                batch.width = newSize;

                                isar!.writeTxnSync((isar) => isar.barcodeBatchs
                                    .putSync(batch, replaceOnConflict: true));

                                List<CatalogedBarcode> relatedBarcodes = isar!
                                    .catalogedBarcodes
                                    .filter()
                                    .batchIDEqualTo(batch.id)
                                    .findAllSync();

                                isar!.writeTxnSync((isar) {
                                  for (CatalogedBarcode barcode
                                      in relatedBarcodes) {
                                    barcode.width = newSize;
                                    isar.catalogedBarcodes.putSync(barcode,
                                        replaceOnConflict: true);
                                  }
                                });

                                _updateBarcodeBatches();
                              }

                              setState(() {
                                isEditingSize = false;
                              });
                            },
                          ),
                        ),
                        Text(
                          'mm',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditingSize = true;
                        batchWidthNode.requestFocus();
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          batch.width.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '(tap to edit)',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            const Divider(
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  child: ElevatedButton(
                    onPressed: () async {
                      bool? approved = await showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Barcode Batch'),
                          content: const Text(
                              'Are you sure you want delete all the barcodes related to this batch ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('OK'),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      );

                      if (approved != null && approved == true) {
                        bool canDelete = true;
                        isar!.catalogedBarcodes
                            .filter()
                            .batchIDEqualTo(batch.id)
                            .findAllSync()
                            .forEach((element) {
                          CatalogedContainer? catalogedContainer = isar!
                              .catalogedContainers
                              .filter()
                              .barcodeUIDMatches(element.barcodeUID)
                              .findFirstSync();
                          if (catalogedContainer != null) {
                            canDelete = false;
                          }
                        });

                        if (canDelete == true) {
                          isar!.writeTxnSync((isar) {
                            isar.barcodeBatchs.deleteSync(batch.id);
                            isar.catalogedBarcodes
                                .filter()
                                .batchIDEqualTo(batch.id)
                                .deleteAllSync();
                          });
                        } else if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'A barcode from this batch is in use.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }

                      _updateBarcodeBatches();
                    },
                    child: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                Visibility(
                  visible: !batch.imported,
                  child: ElevatedButton(
                    onPressed: () {
                      _createPDF(batch);
                    },
                    child: Text(
                      'Generate',
                      style: Theme.of(context).textTheme.bodyMedium,
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

  Future<void> _generateBarcodeBatch() async {
    //Time of creation
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    //Generate BarcodeProperties
    int startUID = 1;

    if (barcodeBatches.isNotEmpty) {
      startUID = barcodeBatches.last.rangeEnd + 1;
    }

    int endUID = startUID + numberOfBarocdes - 1;

    BarcodeBatch newBarcodeBatch = BarcodeBatch()
      ..width = barcodeSize
      ..height = barcodeSize
      ..timestamp = timestamp
      ..rangeStart = startUID
      ..rangeEnd = endUID
      ..imported = false;

    //Write to database.
    isar!.writeTxnSync((isar) {
      int batchID = isar.barcodeBatchs.putSync(newBarcodeBatch);

      for (var i = startUID; i <= endUID; i++) {
        String barcodeUID = '${i}_$timestamp';
        isar.catalogedBarcodes.putSync(CatalogedBarcode()
          ..barcodeUID = barcodeUID
          ..width = barcodeSize
          ..height = barcodeSize
          ..batchID = batchID);
      }
    });

    _updateBarcodeBatches();

    _createPDF(newBarcodeBatch);
  }

  void _importBarcodes(Set<String> scannedBarcodes) {
    //Time of creation
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    List<int> scannedBarcodeIDs =
        scannedBarcodes.map((e) => int.parse(e.split('_').first)).toList();

    scannedBarcodeIDs.sort();

    BarcodeBatch newBarcodeBatch = BarcodeBatch()
      ..width = barcodeSize
      ..height = barcodeSize
      ..timestamp = timestamp
      ..imported = true
      ..rangeStart = scannedBarcodeIDs.first
      ..rangeEnd = scannedBarcodeIDs.last;

    //Write to database.
    isar!.writeTxnSync((isar) {
      int batchID = isar.barcodeBatchs.putSync(newBarcodeBatch);

      for (var scannedBarcode in scannedBarcodes) {
        isar.catalogedBarcodes.putSync(
          CatalogedBarcode()
            ..barcodeUID = scannedBarcode
            ..width = defaultBarcodeSize
            ..height = defaultBarcodeSize
            ..batchID = batchID,
        );
      }
    });

    _updateBarcodeBatches();
  }

  void _createPDF(BarcodeBatch barcodeBatch) async {
    List<String> barcodeUIDs = [];

    for (var i = barcodeBatch.rangeStart; i <= barcodeBatch.rangeEnd; i++) {
      barcodeUIDs.add('${i}_${barcodeBatch.timestamp}');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfView(
          barcodeUIDs: barcodeUIDs,
          size: barcodeBatch.width,
          start: barcodeBatch.rangeStart,
          end: barcodeBatch.rangeEnd,
        ),
      ),
    );
  }

  void _updateBarcodeBatches() {
    setState(() {
      barcodeBatches =
          barcodeBatches = isar!.barcodeBatchs.where().findAllSync();
    });
  }
}
