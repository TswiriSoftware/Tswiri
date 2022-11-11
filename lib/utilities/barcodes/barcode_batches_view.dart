import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tswiri/utilities/barcodes/barcode_generator_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri/utilities/barcodes/batch/barcode_batch_view.dart';
import 'package:tswiri/utilities/barcodes/import/barcode_import_view.dart';
import 'package:tswiri_database/tswiri_database.dart';

class BarcodeBatchesView extends StatefulWidget {
  const BarcodeBatchesView({Key? key}) : super(key: key);

  @override
  State<BarcodeBatchesView> createState() => BarcodeBatchesViewState();
}

class BarcodeBatchesViewState extends State<BarcodeBatchesView> {
  late List<BarcodeBatch> barcodeBatches = getBarcodeBatchsSync();
  // isar!.barcodeBatchs.where().findAllSync();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          _sliverList(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _fab(),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'Barcode Batches',
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
              "Import Barcodes",
            ),
          ),
        ];
      },
      onSelected: (value) async {
        switch (value) {
          case 0:
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BarcodeImportView(),
              ),
            );

            setState(() {
              barcodeBatches = getBarcodeBatchsSync();
              // isar!.barcodeBatchs.where().findAllSync();
            });
            break;
          default:
        }
      },
    );
  }

  Widget _fab() {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) {
        return FloatingActionButton(
          onPressed: action,
          child: const Icon(Icons.add_rounded),
        );
      },
      openBuilder: (context, action) {
        return const BarcodeGeneratorView();
      },
      onClosed: (data) {
        //Update barcodeBatches on closed.
        setState(() {
          barcodeBatches = getBarcodeBatchsSync();
          // isar!.barcodeBatchs.where().findAllSync();
        });
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
                        'Number of Barcodes: ${getCatalogedBarcodesSync(batchID: batch.id).length}'), //${isar!.catalogedBarcodes.filter().batchIDEqualTo(batch.id).findAllSync().length}
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
      onClosed: (value) {
        setState(() {
          barcodeBatches = getBarcodeBatchsSync();
          // isar!.barcodeBatchs.where().findAllSync();
        });
      },
    );
  }
}
