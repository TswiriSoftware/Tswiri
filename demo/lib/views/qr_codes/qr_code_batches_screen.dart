import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/extensions.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class QrCodeBatchesScreen extends ConsumerStatefulWidget {
  const QrCodeBatchesScreen({super.key});

  @override
  AbstractScreen<QrCodeBatchesScreen> createState() =>
      _QrCodeBatchesScreenState();
}

class _QrCodeBatchesScreenState extends AbstractScreen<QrCodeBatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Batches'),
      ),
      body: StreamBuilder(
        stream: isar.barcodeBatchs.watchLazy(),
        builder: (context, snapshot) {
          final batches = isar.barcodeBatchs.where().findAllSync();

          if (batches.isEmpty) {
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
                      Routes.qrCodeBatch,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.qrCodeGenerator);
        },
        icon: const Icon(Icons.add),
        label: const Text('Generate QR Codes'),
      ),
    );
  }
}
