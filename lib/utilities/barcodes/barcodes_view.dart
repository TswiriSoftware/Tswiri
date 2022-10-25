import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri/utilities/barcodes/barcode_batch_view.dart';
import 'package:tswiri/utilities/barcodes/barcode_import_view.dart';

class BarcodesView extends StatefulWidget {
  const BarcodesView({Key? key}) : super(key: key);

  @override
  State<BarcodesView> createState() => BarcodesViewState();
}

class BarcodesViewState extends State<BarcodesView> {
  late List<BarcodeBatch> barcodeBatches =
      isar!.barcodeBatchs.where().findAllSync();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          _sliverList(),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'QR Codes',
        ),
        centerTitle: true,
        elevation: 5,
      ),
      actions: [
        _popupMenu(),
      ],
    );
  }

  SliverPadding _sliverList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          for (var batch in barcodeBatches) _barcodeBatch(batch),
        ]),
      ),
    );
  }

  PopupMenuButton<int> _popupMenu() {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text(
              "Find",
            ),
          ),
          const PopupMenuItem<int>(
            value: 0,
            child: Text(
              "Import Barcodes",
            ),
          ),
        ];
      },
      onSelected: (value) async {
        switch (value) {
          case 0:
            Set<String>? scannedBarcodes = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BarcodeImportView(),
              ),
            );

            if (scannedBarcodes != null && scannedBarcodes.isNotEmpty) {
              //TODO: import barcodes.

              // _importBarcodes(scannedBarcodes);
              // log(scannedBarcodes.toString());
            }
            break;
          case 1:
            //TODO: Implent find barcode.
            break;
          default:
        }
      },
    );
  }

  Widget _barcodeBatch(BarcodeBatch batch) {
    return OpenContainer(
      openShape: const RoundedRectangleBorder(),
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedBuilder: (context, action) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(DateFormat('yyyy-MM-dd - HH:m')
                    .format(
                      DateTime.fromMillisecondsSinceEpoch(batch.timestamp),
                    )
                    .toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Number of Barcodes: ${batch.rangeEnd - batch.rangeStart}'),
                    Text('Height: ${batch.height}'),
                    Text('Width: ${batch.width}'),
                  ],
                ),
                leading: Text('ID: ${batch.id}'),
              ),
            ],
          ),
        ),
      ),
      openBuilder: (context, _) => BarcodeBatchView(
        barcodeBatch: batch,
      ),
    );
  }
}
