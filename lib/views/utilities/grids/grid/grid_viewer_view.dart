import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sunbird/classes/grid_controller.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/containers/barcode_scanner/single_scanner_view.dart';
import 'gird_painter.dart';
import 'gird_scanning/grid_scanner_view.dart';

class GirdViewer extends StatefulWidget {
  const GirdViewer({
    Key? key,
    required this.catalogedContainer,
    required this.gridUID,
  }) : super(key: key);

  final CatalogedContainer? catalogedContainer;
  final int? gridUID;

  @override
  State<GirdViewer> createState() => _GirdViewerState();
}

class _GirdViewerState extends State<GirdViewer> {
  GridController? _gridController;

  late int? gridUID;

  List<Marker> markers = [];

  @override
  void initState() {
    if (widget.gridUID != null) {
      gridUID = widget.gridUID;
      _gridController = GridController(gridUID: gridUID!);
    } else if (widget.catalogedContainer != null) {
      //1. Check if a grid containing this barcode exists.

      CatalogedCoordinate? catalogedCoordinate = isar!.catalogedCoordinates
          .filter()
          .barcodeUIDMatches(widget.catalogedContainer!.barcodeUID!)
          .findFirstSync();

      if (catalogedCoordinate != null) {
        // Grid Exists
        _gridController = GridController(gridUID: catalogedCoordinate.gridUID);
      } else {
        //Create a new grid.
        CatalogedGrid newGrid = CatalogedGrid()
          ..barcodeUID = widget.catalogedContainer!.barcodeUID!;

        //write to isar
        isar!.writeTxnSync((isar) {
          int newGridUID = isar.catalogedGrids.putSync(newGrid);
          _gridController = GridController(gridUID: newGridUID);
        });
      }
    }

    _updateMarkers();

    log(isar!.catalogedCoordinates.where().findAllSync().toString());
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
          'ID: ${_gridController?.gridUID}',
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
              'Grid: ${_gridController?.gridUID}',
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
                      displayPoints: _gridController!.calculateDisplayPoints(
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
                        .gridUIDEqualTo(gridUID!)
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
                        _gridController!.processData(
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
      if (_gridController != null) {
        markers.clear();
        List<String> gridBarcodes = isar!.catalogedCoordinates
            .filter()
            .gridUIDEqualTo(_gridController!.gridUID)
            .findAllSync()
            .map((e) => e.barcodeUID)
            .toList();

        markers = isar!.markers
            .filter()
            .repeat(gridBarcodes,
                (q, String element) => q.barcodeUIDMatches(element))
            .findAllSync();
      }
    });
  }
}
