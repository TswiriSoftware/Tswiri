import 'package:flutter/material.dart';
import 'package:tswiri/ml_kit/grid_scanning/grid_scanner_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/models/grid/grid_controller.dart';
import 'package:tswiri_database_interface/models/grid/grid_painter.dart';

class GridViewer extends StatefulWidget {
  const GridViewer({Key? key, required this.grid}) : super(key: key);
  final CatalogedGrid grid;
  @override
  State<GridViewer> createState() => GridViewerState();
}

class GridViewerState extends State<GridViewer> {
  late final CatalogedGrid _catalogedGrid = widget.grid;
  late int gridUID = _catalogedGrid.id;
  late final GridController _gridController = GridController(gridUID: gridUID);
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _updateMarkers();
    _gridController.findGridMarkers();
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
      title: Text('Grid ${_catalogedGrid.id}'),
      centerTitle: true,
      actions: [
        _delete(),
      ],
    );
  }

  IconButton _delete() {
    return IconButton(
      onPressed: () {
        deleteGrid(gridUID: gridUID);
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.delete_rounded),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
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
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Clear'),
                    ),
                    OutlinedButton(
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
                      child: const Text('Scan'),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _updateMarkers() {
    setState(
      () {
        markers.clear();
        List<String> gridBarcodes =
            getCatalogedCoordinatesSync(gridUID: _gridController.gridUID)
                .map((e) => e.barcodeUID)
                .toList();

        markers =
            getMarkersFromGridBarcodeUIDsSync(gridBarcodeUIDs: gridBarcodes);
      },
    );
  }
}
