import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class BarcodesScreen extends ConsumerStatefulWidget {
  final BarcodeBatch _barcodeBatch;

  const BarcodesScreen({
    super.key,
    required BarcodeBatch barcodeBatch,
  }) : _barcodeBatch = barcodeBatch;

  @override
  AbstractScreen<BarcodesScreen> createState() => _BarcodesScreenState();
}

class _BarcodesScreenState extends AbstractScreen<BarcodesScreen> {
  BarcodeBatch get batch => widget._barcodeBatch;

  Stream<List<CatalogedBarcode>> get qrCodesStream {
    return db.catalogedBarcodes
        .filter()
        .batchUUIDEqualTo(batch.uuid)
        .watch(fireImmediately: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: StreamBuilder<List<CatalogedBarcode>>(
        stream: qrCodesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final qrCodes = snapshot.data;
          if (qrCodes == null || qrCodes.isEmpty) {
            return const Center(
              child: Text('No QR Codes found'),
            );
          }

          return ListView.builder(
            itemCount: qrCodes.length,
            itemBuilder: (context, index) {
              final qrCode = qrCodes[index];

              final linkedContainerFuture = db.catalogedContainers
                  .filter()
                  .barcodeUUIDEqualTo(qrCode.barcodeUUID)
                  .findFirst();

              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListBody(
                  children: [
                    ListTile(
                      leading: const Text('ID'),
                      title: Text(
                        qrCode.barcodeUUID.toString(),
                      ),
                      onTap: () async {
                        // TODO: implement this.

                        // await Navigator.of(context).pushNamed(
                        //   Routes.qrCodePDF,
                        //   arguments: qrCode,
                        // );
                      },
                    ),
                    ListTile(
                      leading: const Text('Size'),
                      title: Text(
                        '${qrCode.width} x ${qrCode.height} mm',
                      ),
                    ),
                    FutureBuilder(
                      future: linkedContainerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ListTile(
                            leading: Text('Link'),
                            title: CircularProgressIndicator(),
                          );
                        }

                        final linkedContainer = snapshot.data;
                        final containerName = linkedContainer?.name ??
                            linkedContainer?.containerUUID;

                        return ListTile(
                          leading: const Text('Link'),
                          title: Text(containerName ?? 'None'),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
