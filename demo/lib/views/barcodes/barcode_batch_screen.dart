import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/extensions.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class BarcodeBatchScreen extends ConsumerStatefulWidget {
  final BarcodeBatch _barcodeBatch;

  const BarcodeBatchScreen({
    super.key,
    required BarcodeBatch barcodeBatch,
  }) : _barcodeBatch = barcodeBatch;

  @override
  AbstractScreen<BarcodeBatchScreen> createState() =>
      _BarcodeBatchScreenState();
}

class _BarcodeBatchScreenState extends AbstractScreen<BarcodeBatchScreen> {
  BarcodeBatch get batch => widget._barcodeBatch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batch: ${batch.id}'),
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                batch.creationDateTime?.formatted ?? 'Mixed',
              ),
            ),
            ListTile(
              leading: const Tooltip(
                message: 'Height',
                child: Icon(Icons.height),
              ),
              title: Text('${batch.height} mm'),
            ),
            ListTile(
              leading: const RotatedBox(
                quarterTurns: 1,
                child: Tooltip(
                  message: 'Width',
                  child: Icon(Icons.height),
                ),
              ),
              title: Text('${batch.height} mm'),
            ),
            ListTile(
              leading: const Tooltip(
                message: 'Number of Barcodes',
                child: Icon(Icons.qr_code),
              ),
              title: Text('${batch.amount} Barcodes'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  Routes.barcode,
                  arguments: batch,
                );
              },
              trailing: const Icon(Icons.chevron_right),
            ),
            const Divider(),
            ListTile(
              enabled: batch.canPrint,
              leading: const Tooltip(
                message: 'Print',
                child: Icon(Icons.print),
              ),
              title: const Text('Print'),
              onTap: () async {
                final barcodeSize = max(
                  batch.height!,
                  batch.width!,
                );

                final barcodeUUIDs = db.catalogedBarcodes
                    .filter()
                    .batchUUIDEqualTo(batch.uuid)
                    .findAllSync()
                    .map((e) => e.barcodeUUID)
                    .toList();

                await Navigator.of(context).pushNamed(
                  Routes.barcodePdf,
                  arguments: (barcodeSize, barcodeUUIDs),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
