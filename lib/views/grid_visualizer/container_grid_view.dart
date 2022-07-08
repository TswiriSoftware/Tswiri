// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/barcode_colors.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/grid/coordinate_entry/coordinate_entry.dart';
import 'package:flutter_google_ml_kit/views/scanning/position/position_scanner_view.dart';
import 'package:flutter_google_ml_kit/views/scanning/marker/marker_scanner_view.dart';
import 'package:flutter_google_ml_kit/views/grid_visualizer/container_new_markers.dart';
import 'package:flutter_google_ml_kit/views/grid_visualizer/grid_visualizer_painter.dart';
import 'package:flutter_google_ml_kit/views/widgets/grid_view/grid_viewer.dart';
import 'package:isar/isar.dart';
import '../../isar_database/containers/container_relationship/container_relationship.dart';

class ContainerGridView extends StatefulWidget {
  const ContainerGridView({
    Key? key,
    required this.containerEntry,
    required this.containerTypeColor,
  }) : super(key: key);

  final ContainerEntry containerEntry;
  final Color containerTypeColor;

  @override
  State<ContainerGridView> createState() => _ContainerGridViewState();
}

class _ContainerGridViewState extends State<ContainerGridView> {
  late ContainerEntry containerEntry = widget.containerEntry;
  late Color containerTypeColor = widget.containerTypeColor;

  List<Marker> gridMarkers = [];
  List<String> barcodesToScan = [];
  List<String> markersToScan = [];
  List<ContainerEntry> children = [];

  late String? gridUID = isarDatabase!.coordinateEntrys
      .filter()
      .barcodeUIDMatches(containerEntry.barcodeUID!)
      .findFirstSync()
      ?.gridUID;

  late final ContainerEntry? _parentContainer;

  @override
  void initState() {
    if (gridUID != null) {
      _parentContainer = isarDatabase!.containerEntrys
          .filter()
          .barcodeUIDMatches(gridUID!)
          .findFirstSync()!;
    } else {
      _parentContainer = containerEntry;
      gridUID = containerEntry.barcodeUID!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerTypeColor,
        title: Text(
          containerEntry.name ?? '${containerEntry.containerUID} Grid',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Grid View
            _gridView(),
            _markers(),
          ],
        ),
      ),
    );
  }

  ///GRID///
  Widget _gridView() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: containerTypeColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _gridHeading(),
            _dividerHeading(),
            // _viewer(),
            GridViewer(girdUID: gridUID!),
            _gridActions(),
          ],
        ),
      ),
    );
  }

  Widget _gridHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Grid', style: Theme.of(context).textTheme.headlineSmall),
        IconButton(
          onPressed: () {
            showAlertDialog(context);
          },
          icon: const Icon(Icons.info),
        ),
      ],
    );
  }

  // Widget _viewer() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: containerTypeColor, width: 1),
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(5),
  //       ),
  //     ),
  //     height: MediaQuery.of(context).size.width,
  //     child: InteractiveViewer(
  //       scaleFactor: 5,
  //       maxScale: 10,
  //       minScale: 1,
  //       child: CustomPaint(
  //         size: Size.infinite,
  //         painter: GridVisualizerPainter(
  //           containerEntry: containerEntry,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _gridActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _deleteButton(),
        _scanButton(),
      ],
    );
  }

  Widget _scanButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(containerTypeColor)),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PositionScannerView(
              parentContainer: _parentContainer!,
              customColor: containerTypeColor,
            ),
          ),
        );

        updateGrid();
        setState(() {});
      },
      child: Row(
        children: [
          Text(
            'Scan ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Icon(Icons.scatter_plot)
        ],
      ),
    );
  }

  Widget _deleteButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(containerTypeColor)),
      onPressed: () {
        isarDatabase!.writeTxnSync((isar) {
          isar.coordinateEntrys
              .filter()
              .gridUIDMatches(gridUID!)
              .deleteAllSync();
        });
        // MasterGrid masterGrid = MasterGrid(isarDatabase: isarDatabase!);
        // Grid grid = Grid(isarDatabase: isarDatabase!);
        // grid.initiate(masterGrid);
        // log(grid.coordinates.toString());
        // setState(() {});
      },
      child: Row(
        children: [
          Text(
            'Delete ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Icon(Icons.delete)
        ],
      ),
    );
  }

  ///MARKERS///
  Widget _markers() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: containerTypeColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _markersHeading(),
            _dividerHeading(),
            _markersBuilder(),
            _divider(),
            _addMarkers(),
          ],
        ),
      ),
    );
  }

  Widget _markersHeading() {
    return Text('Markers', style: Theme.of(context).textTheme.headlineSmall);
  }

  Widget _addMarkers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(containerTypeColor)),
            onPressed: () async {
              newMarkers();
            },
            child: Text('+', style: Theme.of(context).textTheme.bodyLarge)),
      ],
    );
  }

  Widget _markersBuilder() {
    return Builder(
      builder: (context) {
        gridMarkers = isarDatabase!.markers
            .filter()
            .parentContainerUIDMatches(containerEntry.containerUID)
            .findAllSync();

        for (Marker marker in gridMarkers) {
          markersToScan.add(marker.barcodeUID);
        }

        return Column(
          children: gridMarkers.map((e) => markerCard(e)).toList(),
        );
      },
    );
  }

  Widget markerCard(Marker marker) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white12,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: containerTypeColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              marker.barcodeUID,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            IconButton(
              onPressed: () {
                isarDatabase!.writeTxnSync(
                  (isar) => isar.markers.deleteSync(marker.id),
                );
                setState(() {});
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  void newMarkers() async {
    List<String> newMarkers = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MarkerScannerView(
              parentContainer: containerEntry,
              color: containerTypeColor,
            ),
          ),
        ) ??
        [];
    if (newMarkers.isNotEmpty) {
      List<String>? newSelectedMarkers = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContainerNewMarkersView(
                containerUID: containerEntry.containerUID,
                color: containerTypeColor,
                newMarkers: newMarkers,
              ),
            ),
          ) ??
          [];
      if (newSelectedMarkers.isNotEmpty) {
        isarDatabase!.writeTxnSync((isar) => isar.markers
            .filter()
            .parentContainerUIDMatches(containerEntry.containerUID)
            .deleteAllSync());
        List<Marker> addedMarkers = [];
        for (String item in newSelectedMarkers) {
          addedMarkers.add(Marker()
            ..barcodeUID = item
            ..parentContainerUID = containerEntry.containerUID);
        }
        isarDatabase!.writeTxnSync((isar) =>
            isar.markers.putAllSync(addedMarkers, replaceOnConflict: true));
        setState(() {});
      }
    }
  }

  void updateGrid() {
    List<ContainerRelationship> childrenRelationships = [];

    childrenRelationships.addAll(isarDatabase!.containerRelationships
        .filter()
        .parentUIDMatches(containerEntry.containerUID)
        .findAllSync());

    children = isarDatabase!.containerEntrys
        .filter()
        .repeat(
            childrenRelationships,
            (q, ContainerRelationship element) =>
                q.containerUIDMatches(element.containerUID))
        .findAllSync();

    for (ContainerEntry child in children) {
      barcodesToScan.add(child.barcodeUID!);
    }

    setState(() {});
  }

  ///MISC///

  Divider _divider() {
    return const Divider(
      height: 8,
      indent: 2,
      color: Colors.white30,
    );
  }

  Divider _dividerHeading() {
    return const Divider(
      height: 8,
      thickness: 1,
      color: Colors.white,
    );
  }

  showAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Container Colors",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              colorInfo('Marker :', barcodeMarkerColor),
              _divider(),
              colorInfo('Child:', barcodeChildren),
              _divider(),
              colorInfo('Unkown:', barcodeUnkownColor),
              _divider(),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }

  Widget colorInfo(String name, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Container(
          width: 25,
          height: 25,
          color: color,
        ),
      ],
    );
  }
}
