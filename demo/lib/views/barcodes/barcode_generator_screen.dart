import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/enumerations.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri/widgets/barcode_batch_setup_widget.dart';
import 'package:tswiri_database/collections/collections_export.dart';
import 'package:uuid/uuid.dart';

class BarcodeGeneratorScreen extends ConsumerStatefulWidget {
  const BarcodeGeneratorScreen({super.key});

  @override
  AbstractScreen<BarcodeGeneratorScreen> createState() =>
      _BarcodeGeneratorScreenState();
}

class _BarcodeGeneratorScreenState
    extends AbstractScreen<BarcodeGeneratorScreen> {
  int numberOfBarcodes = 20;
  bool isEditing = false;

  final initialBarcodeSize = BarcodeSize.medium;
  late Size size = initialBarcodeSize.size;

  List<BarcodeBatch> get barcodeBatches =>
      db.barcodeBatchs.where().findAllSync();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Generator'),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BarcodeBatchSetupWidget(
                numberOfBarcodes: numberOfBarcodes,
                onNumberOfBarcodesChanged: (value) {
                  setState(() {
                    numberOfBarcodes = value;
                  });
                },
                initialBarcodeSize: initialBarcodeSize,
                onBarcodeSizeChanged: (value) {
                  setState(() {
                    size = value;
                  });
                },
              ),
              const Divider(),
              FilledButton.tonal(
                onPressed: _generateBarcodeBatch,
                child: const Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generateBarcodeBatch() async {
    //Time of creation
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final batchUuid = const Uuid().v1();
    final width = size.width;
    final height = size.height;

    final barcodeBatch = BarcodeBatch()
      ..uuid = batchUuid
      ..amount = numberOfBarcodes
      ..timestamp = timestamp
      ..width = width
      ..height = height
      ..imported = false;

    final barcodeUUIDs = List.generate(
      numberOfBarcodes,
      (index) {
        final barcodeUUID = '${index + 1}_$timestamp';
        return barcodeUUID;
      },
    );

    final catalogedBarcodes = barcodeUUIDs.map((uuid) {
      return CatalogedBarcode()
        ..barcodeUUID = uuid
        ..width = width
        ..height = height
        ..batchUUID = batchUuid;
    }).toList();

    db.writeTxnSync(() {
      db.barcodeBatchs.putSync(barcodeBatch);
      db.catalogedBarcodes.putAllSync(catalogedBarcodes);
    });

    final barcodeSize = max(size.width, size.height);

    await Navigator.of(context).pushNamed(
      Routes.barcodePdf,
      arguments: (barcodeSize, barcodeUUIDs),
    );

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
