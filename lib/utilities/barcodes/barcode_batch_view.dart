import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tswiri_database/export.dart';

class BarcodeBatchView extends StatefulWidget {
  const BarcodeBatchView({
    Key? key,
    required this.barcodeBatch,
  }) : super(key: key);
  final BarcodeBatch barcodeBatch;
  @override
  State<BarcodeBatchView> createState() => BarcodeBatchViewState();
}

class BarcodeBatchViewState extends State<BarcodeBatchView> {
  late final BarcodeBatch _batch = widget.barcodeBatch;
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

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
      title: Text('Batch: ${_batch.id}'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _batchInfo(),
        ],
      ),
    );
  }

  Card _batchInfo() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dateTime(),
            _height(),
            _width(),
            _barcodes(),
          ],
        ),
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

  ListTile _dateTime() {
    return ListTile(
      title: Text(
        DateFormat('yyyy-MM-dd - HH:m')
            .format(
              DateTime.fromMillisecondsSinceEpoch(_batch.timestamp),
            )
            .toString(),
      ),
      leading: const Icon(Icons.access_time_rounded),
    );
  }

  ListTile _barcodes() {
    return ListTile(
      leading: const Icon(Icons.qr_code_2_rounded),
      title: const Text('Barcodes'),
      subtitle: Text(isar!.catalogedBarcodes
          .filter()
          .batchIDEqualTo(_batch.id)
          .findAllSync()
          .length
          .toString()),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.view_carousel_rounded),
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
