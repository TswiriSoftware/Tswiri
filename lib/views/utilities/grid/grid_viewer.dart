import 'dart:developer';

import 'package:tswiri/views/ml_kit/barcode_scanner/single_scanner_view.dart';
import 'package:tswiri/views/ml_kit/grid_scanning/grid_scanner_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/isar/get_functions.dart';
import 'package:tswiri_database/models/grid/grid_controller.dart';
import 'package:tswiri_database/models/grid/grid_painter.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class GirdViewer extends StatefulWidget {
  const GirdViewer({
    Key? key,
    required this.gridUID,
  }) : super(key: key);

  final int gridUID;

  @override
  State<GirdViewer> createState() => _GirdViewerState();
}

class _GirdViewerState extends State<GirdViewer> {
  late int gridUID = widget.gridUID;
  late final GridController _gridController = GridController(gridUID: gridUID);
  List<Marker> markers = [];

  @override
  void initState() {
    _updateMarkers();

    CatalogedGrid targetGrid = isar!.catalogedGrids.getSync(gridUID)!;

    log(targetGrid.toString());

    List<CatalogedGrid> parentGrids = [];

    if (targetGrid.parentBarcodeUID != null) {
      CatalogedCoordinate? catalogedCoordinate = isar!.catalogedCoordinates
          .filter()
          .barcodeUIDMatches(targetGrid.barcodeUID)
          .findFirstSync();

      int i = 1;
      while (catalogedCoordinate != null && i < 100) {
        CatalogedGrid? catalogedGrid =
            isar!.catalogedGrids.getSync(catalogedCoordinate.gridUID);

        if (catalogedGrid != null) {
          parentGrids.add(catalogedGrid);

          if (catalogedGrid.parentBarcodeUID != null) {
            catalogedCoordinate = isar!.catalogedCoordinates
                .filter()
                .barcodeUIDMatches(catalogedGrid.parentBarcodeUID!)
                .findFirstSync();
            if (catalogedCoordinate != null) {
              catalogedGrid =
                  isar!.catalogedGrids.getSync(catalogedCoordinate.gridUID);
            }
          } else {
            catalogedCoordinate = null;
          }
        } else {
          catalogedCoordinate = null;
        }

        i++;
      }

      log(parentGrids.toString());
    }

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
          'ID: ${_gridController.gridUID}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true);
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _gridView(),
          _markersCard(),
          _editCard(),
        ],
      ),
    );
  }

  Widget _gridView() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Grid: ${_gridController.gridUID}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Card(
              color: background[300],
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: InteractiveViewer(
                  maxScale: 25,
                  minScale: 1,
                  child: CustomPaint(
                    painter: GridVisualizerPainter(
                      displayPoints: _gridController.calculateDisplayPoints(
                        Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height / 2,
                        ),
                        null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    isar!.writeTxnSync((isar) => isar.catalogedCoordinates
                        .filter()
                        .gridUIDEqualTo(gridUID)
                        .deleteAllSync());
                    _updateMarkers();
                  },
                  child: Text(
                    'Clear',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    List<dynamic>? barcodeDataBatches =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GridScannerView(),
                      ),
                    );

                    if (barcodeDataBatches != null &&
                        barcodeDataBatches.isNotEmpty) {
                      setState(() {
                        _gridController.processData(
                          barcodeDataBatches,
                        );
                      });

                      _updateMarkers();
                    }
                  },
                  child: Text(
                    'Scan',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _markersCard() {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Markers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              primary: false,
              itemCount: markers.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _addMarkerCard();
                } else {
                  return _markerCard(markers[index - 1]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addMarkerCard() {
    return InkWell(
      onTap: () async {
        //Create new marker.
        String? scannedBarcodeUID = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SingleBarcodeScannerView(),
          ),
        );

        if (scannedBarcodeUID != null) {
          //Check if the marker exists?
          Marker? marker = isar!.markers
              .filter()
              .barcodeUIDMatches(scannedBarcodeUID)
              .findFirstSync();

          if (marker == null) {
            Marker newMarker = Marker()
              ..containerUID = null
              ..barcodeUID = scannedBarcodeUID;

            isar!.writeTxnSync((isar) {
              isar.markers.putSync(newMarker);
            });

            _updateMarkers();
          }
        }
      },
      child: Card(
        color: background[300],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '+',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '(new marker)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _markerCard(Marker marker) {
    return Card(
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ID: ${marker.barcodeUID}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Visibility(
              visible: !canDeleteMarker(marker),
              child: IconButton(
                onPressed: () {
                  isar!.writeTxnSync((isar) {
                    isar.markers.deleteSync(marker.id);
                    isar.catalogedCoordinates
                        .filter()
                        .barcodeUIDMatches(marker.barcodeUID)
                        .deleteFirstSync();
                  });

                  _updateMarkers();
                },
                icon: const Icon(
                  Icons.delete_sharp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateMarkers() {
    setState(() {
      markers.clear();
      List<String> gridBarcodes = isar!.catalogedCoordinates
          .filter()
          .gridUIDEqualTo(_gridController.gridUID)
          .findAllSync()
          .map((e) => e.barcodeUID)
          .toList();

      markers = isar!.markers
          .filter()
          .repeat(
              gridBarcodes, (q, String element) => q.barcodeUIDMatches(element))
          .findAllSync();
    });
  }

  Widget _editCard() {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Edit',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          _originBarcode(),
          _parentBarcode(),
        ],
      ),
    );
  }

  Widget _originBarcode() {
    return Card(
      color: background[300],
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _gridController.catalogedGrid.barcodeUID,
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
                            isar!.writeTxnSync((isar) {
                              _gridController.catalogedGrid.barcodeUID =
                                  scannedBarcodeUID;
                              isar.catalogedGrids.putSync(
                                  _gridController.catalogedGrid,
                                  replaceOnConflict: true);
                            });
                          });
                        } else {
                          setState(() {
                            isar!.writeTxnSync((isar) {
                              _gridController.catalogedGrid.barcodeUID =
                                  scannedBarcodeUID;
                              isar.catalogedGrids.putSync(
                                  _gridController.catalogedGrid,
                                  replaceOnConflict: true);
                            });
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
      color: background[300],
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
                    _gridController.catalogedGrid.parentBarcodeUID ?? '-',
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
                            isar!.writeTxnSync((isar) {
                              _gridController.catalogedGrid.parentBarcodeUID =
                                  scannedBarcodeUID;
                              isar.catalogedGrids.putSync(
                                  _gridController.catalogedGrid,
                                  replaceOnConflict: true);
                            });
                          });
                        } else {
                          setState(() {
                            isar!.writeTxnSync((isar) {
                              _gridController.catalogedGrid.parentBarcodeUID =
                                  scannedBarcodeUID;
                              isar.catalogedGrids.putSync(
                                  _gridController.catalogedGrid,
                                  replaceOnConflict: true);
                            });
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
}
