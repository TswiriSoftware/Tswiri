import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tswiri/ml_kit/barcode_import/barcode_import_scanner.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';

class BarcodeImportView extends StatefulWidget {
  const BarcodeImportView({Key? key}) : super(key: key);

  @override
  State<BarcodeImportView> createState() => BarcodeImportViewState();
}

class BarcodeImportViewState extends State<BarcodeImportView> {
  Set<String> scannedBarcodes = {};

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  BarcodeBatch _batch = BarcodeBatch()
    ..width = defaultBarcodeSize
    ..height = defaultBarcodeSize
    ..timestamp = DateTime.now().millisecondsSinceEpoch
    ..imported = true
    ..rangeStart = 0
    ..rangeEnd = 0;

  @override
  void initState() {
    super.initState();
    _heightController.text = _batch.height.toString();
    _widthController.text = _batch.width.toString();
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
      elevation: 10,
      title: const Text('Barcode Import'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _scan(),
          _batchEditor(),
        ],
      ),
    );
  }

  Card _batchEditor() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          const ListTile(
            title: Text('Info'),
            trailing: Icon(Icons.info),
          ),
          ListTile(
            title: const Text('Number'),
            trailing: Text(scannedBarcodes.length.toString()),
          ),
          const Divider(),
          _height(),
          _width(),
          const Divider(),
          _import(),
        ],
      ),
    );
  }

  Visibility _import() {
    return Visibility(
      visible: scannedBarcodes.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                setState(() {
                  scannedBarcodes.clear();
                });
              },
              child: const Text('Clear'),
            ),
            OutlinedButton(
              onPressed: () async {
                //TODO: ignore existing barcodes.
                _batch.rangeEnd = scannedBarcodes.length;

                isar!.writeTxnSync(() {
                  int batchID = isar!.barcodeBatchs.putSync(_batch);

                  for (var scannedBarcode in scannedBarcodes) {
                    isar!.catalogedBarcodes.putSync(
                      CatalogedBarcode()
                        ..barcodeUID = scannedBarcode
                        ..width = defaultBarcodeSize
                        ..height = defaultBarcodeSize
                        ..batchID = batchID,
                    );
                  }
                });

                Navigator.of(context).pop();
              },
              child: const Text('Import'),
            ),
          ],
        ),
      ),
    );
  }

  Card _scan() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          ListTile(
            title: const Text('Scan'),
            trailing: const Icon(Icons.scanner_rounded),
            onTap: () async {
              Set<String>? newScannedBarcodes =
                  await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BarcodeImportScannerView(),
                ),
              );

              if (newScannedBarcodes == null) return;

              setState(() {
                scannedBarcodes.addAll(newScannedBarcodes);
              });
            },
          ),
        ],
      ),
    );
  }

  ListTile _width() {
    return ListTile(
      title: Text('Width: ${_batch.width}'),
      leading: Transform.rotate(
        angle: pi / 2,
        child: const Icon(Icons.height),
      ),
      trailing: IconButton(
        onPressed: () async {
          double? width = await _sizeDialog(context, _widthController, 'Width');

          if (width != null) {
            _batch.width = width;

            isar!.writeTxnSync(
              () => isar!.barcodeBatchs.putSync(_batch),
            );

            List<CatalogedBarcode> relatedBarcodes = isar!.catalogedBarcodes
                .filter()
                .batchIDEqualTo(_batch.id)
                .findAllSync();

            isar!.writeTxnSync(() {
              for (CatalogedBarcode barcode in relatedBarcodes) {
                barcode.width = width;
                isar!.catalogedBarcodes.putSync(barcode);
              }
            });

            setState(() {});
          }
        },
        icon: const Icon(Icons.edit_rounded),
      ),
    );
  }

  ListTile _height() {
    return ListTile(
      title: Text('Height: ${_batch.height}'),
      leading: const Icon(Icons.height_rounded),
      trailing: IconButton(
        onPressed: () async {
          double? height =
              await _sizeDialog(context, _heightController, 'Height');

          if (height != null) {
            _batch.height = height;

            isar!.writeTxnSync(
              () => isar!.barcodeBatchs.putSync(_batch),
            );

            List<CatalogedBarcode> relatedBarcodes = isar!.catalogedBarcodes
                .filter()
                .batchIDEqualTo(_batch.id)
                .findAllSync();

            isar!.writeTxnSync(() {
              for (CatalogedBarcode barcode in relatedBarcodes) {
                barcode.height = height;
                isar!.catalogedBarcodes.putSync(barcode);
              }
            });

            setState(() {});
          }
        },
        icon: const Icon(Icons.edit_rounded),
      ),
    );
  }

  Future<double?> _sizeDialog(
    BuildContext context,
    TextEditingController controller,
    String title,
  ) {
    return showDialog<double?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.start,
            decoration: const InputDecoration(
              suffix: Text('mm'),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                Navigator.of(context).pop(
                  double.tryParse(controller.text),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
