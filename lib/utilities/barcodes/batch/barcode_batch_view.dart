import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tswiri/utilities/barcodes/batch/barcode_batch_manager_view.dart';
import 'package:tswiri/utilities/barcodes/pdf/pdf_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

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
      actions: [
        _deleteBatch(),
      ],
    );
  }

  IconButton _deleteBatch() {
    return IconButton(
      onPressed: () async {
        bool? delete = await _delete(context);
        if (delete == null) return;
        if (delete == false) return;

        bool canDelete = true;
        getCatalogedBarcodesSync(batchID: _batch.id).forEach((element) {
          CatalogedContainer? catalogedContainer =
              getCatalogedContainerSync(barcodeUID: element.barcodeUID);
          // isar!.catalogedContainers
          //     .filter()
          //     .barcodeUIDMatches(element.barcodeUID)
          //     .findFirstSync();
          if (catalogedContainer != null) {
            canDelete = false;
          }
        });
        // isar!.catalogedBarcodes
        //     .filter()
        //     .batchIDEqualTo(_batch.id)
        //     .findAllSync()
        //     .forEach((element) {
        //   CatalogedContainer? catalogedContainer = isar!.catalogedContainers
        //       .filter()
        //       .barcodeUIDMatches(element.barcodeUID)
        //       .findFirstSync();
        //   if (catalogedContainer != null) {
        //     canDelete = false;
        //   }
        // });

        if (canDelete == false) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'A barcode from this batch is in use.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          deleteBarcodeBatch(id: _batch.id);

          isarDelete(
            collection: Collections.BarcodeBatch,
            id: _batch.id,
          );

          getCatalogedBarcodesSync(batchID: _batch.id)
              .map((e) => e.id)
              .toList();

          ///Delete a barcodeBatch Identified by ID.
          /// - This deletes not only the Barcode Batch but ALSO all related CatalogedBarcodes.
          // deleteBarcodeBatch({required int id}) {
          //   _isar!.writeTxnSync(() {
          //     _isar!.barcodeBatchs.deleteSync(id);
          //     _isar!.catalogedBarcodes.filter().batchIDEqualTo(id).deleteAllSync();
          //   });
          // }

          if (mounted) Navigator.of(context).pop();
        }
      },
      icon: const Icon(Icons.delete_rounded),
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
            const Divider(),
            _barcodes(),
            const Divider(),
            _print(),
          ],
        ),
      ),
    );
  }

  Widget _print() {
    return ListTile(
      title: const Text('Print'),
      trailing: const Icon(Icons.print_rounded),
      onTap: () {
        List<String> barcodeUIDs = getCatalogedBarcodesSync(batchID: _batch.id)
            .map((e) => e.barcodeUID)
            .toList();
        // isar!.catalogedBarcodes
        //     .filter()
        //     .batchIDEqualTo(_batch.id)
        //     .findAllSync()
        //     .map((e) => e.barcodeUID)
        //     .toList();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfView(
              barcodeUIDs: barcodeUIDs,
              size: _batch.width,
            ),
          ),
        );
      },
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

            List<CatalogedBarcode> updatedBarcodes =
                getCatalogedBarcodesSync(batchID: _batch.id)
                    .map((e) => e..height = _batch.height)
                    .toList();

            updateBarcodeBatch(
              barcodeBatch: _batch,
              barcodes: updatedBarcodes,
            );

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

            List<CatalogedBarcode> updatedBarcodes =
                getCatalogedBarcodesSync(batchID: _batch.id)
                    .map((e) => e..height = _batch.height)
                    .toList();

            updateBarcodeBatch(
              barcodeBatch: _batch,
              barcodes: updatedBarcodes,
            );

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

  Widget _barcodes() {
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedBuilder: (context, action) {
        return ListTile(
          leading: const Icon(Icons.qr_code_2_rounded),
          title: const Text('Barcodes'),
          subtitle: Text(
              getCatalogedBarcodesSync(batchID: _batch.id).length.toString()
              // isar!.catalogedBarcodes
              //   .filter()
              //   .batchIDEqualTo(_batch.id)
              //   .findAllSync()
              //   .length
              //   .toString()
              ),
          trailing: const Icon(Icons.view_carousel_rounded),
          onTap: action,
        );
      },
      openBuilder: (context, action) {
        return BarcodeBatchInspectorView(barcodeBatch: _batch);
      },
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

  Future<bool?> _delete(
    BuildContext context,
  ) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete this Batch?'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
