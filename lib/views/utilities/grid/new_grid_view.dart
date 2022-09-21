import 'package:tswiri/views/ml_kit/barcode_scanner/single_scanner_view.dart';
import 'package:tswiri/views/utilities/grid/grid_viewer.dart';
import 'package:flutter/material.dart';

import 'package:tswiri_database/export.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class NewGridView extends StatefulWidget {
  const NewGridView({
    Key? key,
    this.originBarcodeUID,
  }) : super(key: key);

  final String? originBarcodeUID;
  // final String? parentBarcodeUID;

  @override
  State<NewGridView> createState() => _NewGridViewState();
}

class _NewGridViewState extends State<NewGridView> {
  late int numOfGrids = isar!.catalogedGrids.where().findAllSync().length;

  late String? originBarcodeUID = widget.originBarcodeUID;
  String? parentBarcodeUID;

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
      title: Text(
        'New Grid ID: ${numOfGrids + 1}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [
        _originBarcode(),
        _parentBarcode(),
        _createButton(),
      ],
    );
  }

  Widget _originBarcode() {
    return Card(
      shape: RoundedRectangleBorder(
        side: originBarcodeUID == null
            ? const BorderSide(
                color: tswiriOrange,
                width: 1,
              )
            : const BorderSide(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Origin Barcode UID: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                originBarcodeUID == null
                    ? Text(
                        '(Required)',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    originBarcodeUID ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      String? scannedBarcodeUID = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SingleBarcodeScannerView(),
                        ),
                      );
                      if (scannedBarcodeUID != null) {
                        Marker? marker = isar!.markers
                            .filter()
                            .barcodeUIDMatches(scannedBarcodeUID)
                            .findFirstSync();

                        if (marker == null && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Barcode is not a marker are you sure?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                          setState(() {
                            originBarcodeUID = scannedBarcodeUID;
                          });
                        } else {
                          setState(() {
                            originBarcodeUID = scannedBarcodeUID;
                          });
                        }
                      }
                    },
                    child: Text(
                      'Scan',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _parentBarcode() {
    return Card(
      shape: RoundedRectangleBorder(
        side: parentBarcodeUID == null
            ? const BorderSide(
                color: tswiriOrange,
                width: 1,
              )
            : const BorderSide(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Parent Barcode UID: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    parentBarcodeUID ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      String? scannedBarcodeUID = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SingleBarcodeScannerView(),
                        ),
                      );
                      if (scannedBarcodeUID != null) {
                        setState(() {
                          parentBarcodeUID = scannedBarcodeUID;
                        });
                      }
                    },
                    child: Text(
                      'Scan',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButton() {
    return ActionChip(
      label: const Text(
        'Create',
      ),
      labelStyle: Theme.of(context).textTheme.titleMedium,
      labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      shape: const StadiumBorder(
        side: BorderSide(
          color: tswiriOrange,
        ),
      ),
      onPressed: () async {
        if (originBarcodeUID != null) {
          _createGrid();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Please scan a Orgin Barcode',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _createGrid() {
    if (originBarcodeUID != null) {
      CatalogedGrid catalogedGrid = CatalogedGrid()
        ..barcodeUID = originBarcodeUID!
        ..parentBarcodeUID = parentBarcodeUID;

      isar!.writeTxnSync((isar) {
        int gridID = isar.catalogedGrids.putSync(catalogedGrid);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => GirdViewer(
              gridUID: gridID,
            ),
          ),
        );
      });
    }
  }
}
