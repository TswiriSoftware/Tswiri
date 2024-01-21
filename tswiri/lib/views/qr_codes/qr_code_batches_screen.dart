import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/routes.dart';
import 'package:tswiri/views/abstract_page.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class QrCodeBatchesScreen extends ConsumerStatefulWidget {
  const QrCodeBatchesScreen({super.key});

  @override
  AbstractScreen<QrCodeBatchesScreen> createState() => _QrCodeBatchesScreenState();
}

class _QrCodeBatchesScreenState extends AbstractScreen<QrCodeBatchesScreen> {
  List<BarcodeBatch> barcodeBatches = [];

  @override
  void initState() {
    super.initState();

    // Watch for changes in the database and update the UI accordingly.
    isar!.barcodeBatchs.watchLazy().listen((event) {
      updateQrCodeBatches();
    });
  }

  void updateQrCodeBatches() async {
    barcodeBatches = await isar!.barcodeBatchs.where().findAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final body = ListView.builder(
      itemCount: barcodeBatches.length,
      itemBuilder: (context, index) {
        final item = barcodeBatches[index];
        return ListTile(
          leading: Text(item.id.toString()),
          title: Text(barcodeBatches[index].creationDateTime.toIso8601String()),
          onTap: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Batches'),
      ),
      body: body,
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
