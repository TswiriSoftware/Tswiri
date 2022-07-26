import 'package:flutter/material.dart';
import 'package:sunbird/classes/grid_controller.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/containers/container_view/grid/gird_painter.dart';
import 'package:sunbird/views/containers/container_view/grid/gird_scanning/grid_scanner_view.dart';

class GridViewer extends StatefulWidget {
  const GridViewer({Key? key, required this.catalogedContainer})
      : super(key: key);
  final CatalogedContainer catalogedContainer;

  @override
  State<GridViewer> createState() => _GridViewerState();
}

class _GridViewerState extends State<GridViewer> {
  late final CatalogedContainer _catalogedContainer = widget.catalogedContainer;

  late final GridController _gridController =
      GridController(barcodeUID: _catalogedContainer.barcodeUID!);
  late final String? gridUID = _gridController.findGridUID(_catalogedContainer);

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
        'Grid View',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
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
              'Grid: $gridUID',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            gridUID == null
                ? Text(
                    'No Grid',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                : Card(
                    color: background[300],
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: InteractiveViewer(
                        maxScale: 25,
                        minScale: 1,
                        child: CustomPaint(
                          painter: GridVisualizerPainter(
                            displayPoints:
                                _gridController.calculateDisplayPoints(
                              Size(
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height / 2,
                              ),
                              _catalogedContainer.barcodeUID,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            const Divider(),
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

                  setState(() {});
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
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              primary: false,
              itemCount: _gridController.markers.length,
              itemBuilder: (context, index) {
                return _markerCard(_gridController.markers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _markerCard(Marker marker) {
    return Card(
      color: background[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              marker.barcodeUID,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
