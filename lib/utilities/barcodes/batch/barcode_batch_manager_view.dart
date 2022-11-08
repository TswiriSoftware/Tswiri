import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/utilities/barcodes/barcode_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

class BarcodeBatchInspectorView extends StatefulWidget {
  const BarcodeBatchInspectorView({
    Key? key,
    required this.barcodeBatch,
  }) : super(key: key);
  final BarcodeBatch barcodeBatch;
  @override
  State<BarcodeBatchInspectorView> createState() =>
      BarcodeBatchInspectorViewState();
}

class BarcodeBatchInspectorViewState extends State<BarcodeBatchInspectorView> {
  late final List<CatalogedBarcode> _catalogedBarcodes = isar!.catalogedBarcodes
      .filter()
      .batchIDEqualTo(widget.barcodeBatch.id)
      .findAllSync();

  @override
  void initState() {
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
      elevation: 10,
      title: const Text('Barcodes'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: _catalogedBarcodes.length,
      itemBuilder: (context, index) {
        CatalogedBarcode catalogedBarcode = _catalogedBarcodes[index];
        return OpenContainer(
          closedColor: Colors.transparent,
          openColor: Colors.transparent,
          closedBuilder: (context, action) {
            return Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.qr_code_rounded),
                title: Text(catalogedBarcode.barcodeUID),
                onTap: action,
              ),
            );
          },
          openBuilder: (context, action) {
            return BarcodeView(catalogedBarcode: catalogedBarcode);
          },
        );
      },
    );
  }
}
