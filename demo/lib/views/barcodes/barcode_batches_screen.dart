import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/extensions.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class BarcodeBatchesScreen extends ConsumerStatefulWidget {
  const BarcodeBatchesScreen({super.key});

  @override
  AbstractScreen<BarcodeBatchesScreen> createState() =>
      _BarcodesBatchesScreenState();
}

class _BarcodesBatchesScreenState extends AbstractScreen<BarcodeBatchesScreen> {
  Stream<List<BarcodeBatch>> get barcodeBatchesStream {
    return db.barcodeBatchs.where().watch(fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Batches'),
      ),
      body: StreamBuilder(
        stream: barcodeBatchesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final batches = snapshot.data;
          if (batches == null || batches.isEmpty) {
            return const Center(
              child: Text('No QR Code Batches found'),
            );
          }

          return ListView.builder(
            itemCount: batches.length,
            itemBuilder: (context, index) {
              final batch = batches[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  leading: Text(
                    batch.id.toString(),
                  ),
                  title: Text(
                    batch.creationDateTime?.formatted ?? 'Unknown',
                  ),
                  subtitle: Text(
                    "Amount: ${batch.amount}\nHeight: ${batch.height ?? 'Mixed'}\nWidth: ${batch.width ?? 'Mixed'}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                      Routes.barcodeBatch,
                      arguments: batch,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton.extended(
            heroTag: Object(),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.barcodeImport);
            },
            icon: const Icon(Icons.qr_code_scanner_outlined),
            label: const Text('Import'),
          ),
          FloatingActionButton.extended(
            heroTag: Object(),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.barcodeGenerator);
            },
            icon: const Icon(Icons.add),
            label: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
