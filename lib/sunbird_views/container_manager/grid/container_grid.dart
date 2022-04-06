import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/marker_barcode_scanner/marker_barcode_scanner_view.dart';

import 'package:flutter_google_ml_kit/sunbird_views/container_manager/grid/container_new_markers.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/grid/grid_visualizer_painter.dart';

import 'package:flutter_google_ml_kit/sunbird_views/container_manager/widgets/container_display_widget.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

import '../../../isar_database/container_relationship/container_relationship.dart';

class ContainerGridView extends StatefulWidget {
  const ContainerGridView(
      {Key? key,
      required this.containerEntry,
      required this.containerTypeColor})
      : super(key: key);
  final ContainerEntry containerEntry;
  final Color containerTypeColor;

  @override
  State<ContainerGridView> createState() => _ContainerGridViewState();
}

class _ContainerGridViewState extends State<ContainerGridView> {
  late ContainerEntry containerEntry;
  late Color containerTypeColor;
  List<Marker> gridMarkers = [];
  List<String> barcodesToScan = [];
  List<String> markersToScan = [];
  @override
  void initState() {
    containerEntry = widget.containerEntry;
    containerTypeColor = widget.containerTypeColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerTypeColor,
        title: Text(
          containerEntry.name ?? containerEntry.containerUID + ' Grid',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gridView(),
            markers(),
            childrenView(),
          ],
        ),
      ),
    );
  }

  Widget gridView() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grid',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomOutlineContainer(
                      outlineColor: containerTypeColor,
                      width: 35,
                      height: 35,
                      margin: 0,
                      padding: 0,
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            //Delete all relevant entries.

                            List<RealInterBarcodeVectorEntry>
                                allRelevantInterBarcodeData = isarDatabase!
                                    .realInterBarcodeVectorEntrys
                                    .filter()
                                    .repeat(
                                        barcodesToScan,
                                        (q, String element) => q
                                            .startBarcodeUIDMatches(element)
                                            .or()
                                            .endBarcodeUIDMatches(element))
                                    .findAllSync();
                            List<int> ids = [];
                            for (RealInterBarcodeVectorEntry realInterBarcodeVectorEntry
                                in allRelevantInterBarcodeData) {
                              ids.add(realInterBarcodeVectorEntry.id);
                            }

                            isarDatabase!.writeTxnSync((isar) => isar
                                .realInterBarcodeVectorEntrys
                                .deleteAllSync(ids));

                            setState(() {});
                          },
                          child: const Icon(
                            Icons.delete,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomOutlineContainer(
                      outlineColor: containerTypeColor,
                      width: 35,
                      height: 35,
                      margin: 0,
                      padding: 0,
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BarcodePositionScannerView(
                                        barcodesToScan: barcodesToScan,
                                        gridMarkers: markersToScan,
                                        parentContainerUID:
                                            containerEntry.containerUID),
                              ),
                            );

                            setState(() {});
                          },
                          child: const Icon(
                            Icons.scatter_plot_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: InteractiveViewer(
                maxScale: 25,
                minScale: 0.01,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: GridVisualizerPainter(
                      parentContainerUID: containerEntry.containerUID,
                      markersToDraw: markersToScan,
                      barcodesToDraw: barcodesToScan),
                ),
              ),
            )
          ],
        ),
        outlineColor: containerTypeColor,
      ),
    );
  }

  Widget markers() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Markers',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                CustomOutlineContainer(
                  outlineColor: containerTypeColor,
                  width: 35,
                  height: 35,
                  margin: 0,
                  padding: 0,
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        newMarkers();
                      },
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            Builder(
              builder: (context) {
                gridMarkers = isarDatabase!.markers
                    .filter()
                    .parentContainerUIDMatches(containerEntry.containerUID)
                    .findAllSync();

                for (Marker marker in gridMarkers) {
                  markersToScan.add(marker.barcodeUID);
                }

                return Column(
                  children: gridMarkers.map((e) => markerWidget(e)).toList(),
                );
              },
            ),
          ],
        ),
        outlineColor: containerTypeColor,
      ),
    );
  }

  Widget markerWidget(Marker marker) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
          margin: 2.5,
          padding: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                marker.barcodeUID,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              OrangeOutlineContainer(
                width: 35,
                height: 35,
                margin: 0,
                padding: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (marker.barcodeUID != containerEntry.barcodeUID) {
                        isarDatabase!.writeTxnSync(
                          (isar) => isar.markers.deleteSync(marker.id),
                        );
                        setState(() {});
                      }
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          outlineColor: containerTypeColor),
    );
  }

  void newMarkers() async {
    List<String> newMarkers = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MarkerBarcodeScannerView(),
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

  Widget childrenView() {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
          margin: 2.5,
          padding: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contains',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const Divider(),
              Builder(
                builder: (context) {
                  List<ContainerRelationship> childrenRelationships =
                      isarDatabase!.containerRelationships
                          .filter()
                          .parentUIDMatches(containerEntry.containerUID)
                          .findAllSync();

                  List<ContainerEntry> children = [];

                  if (childrenRelationships.isNotEmpty) {
                    children = isarDatabase!.containerEntrys
                        .filter()
                        .repeat(
                            childrenRelationships,
                            (q, ContainerRelationship element) =>
                                q.containerUIDMatches(element.containerUID))
                        .findAllSync();
                  }

                  for (ContainerEntry child in children) {
                    barcodesToScan.add(child.barcodeUID!);
                  }

                  return Column(
                    children:
                        children.map((e) => containerDisplayWidget(e)).toList(),
                  );
                },
              ),
            ],
          ),
          outlineColor: containerTypeColor),
    );
  }

  void updateGrid() {
    List<ContainerRelationship> childrenRelationships = isarDatabase!
        .containerRelationships
        .filter()
        .parentUIDMatches(containerEntry.containerUID)
        .findAllSync();

    List<ContainerEntry> children = [];

    if (childrenRelationships.isNotEmpty) {
      children = isarDatabase!.containerEntrys
          .filter()
          .repeat(
              childrenRelationships,
              (q, ContainerRelationship element) =>
                  q.containerUIDMatches(element.containerUID))
          .findAllSync();
    }

    for (ContainerEntry child in children) {
      barcodesToScan.add(child.barcodeUID!);
    }

    setState(() {});
  }
}
