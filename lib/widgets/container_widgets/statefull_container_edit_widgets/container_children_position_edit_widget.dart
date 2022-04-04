import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_relationship/container_relationship.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_data_visualization_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/barcode_position_scanner_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

import '../../basic_outline_containers/orange_outline_container.dart';

class ContainerChildrenPositionEdit extends StatefulWidget {
  const ContainerChildrenPositionEdit(
      {Key? key, required this.currentContainerUID})
      : super(key: key);

  final String currentContainerUID;

  @override
  State<ContainerChildrenPositionEdit> createState() =>
      _ContainerChildrenPositionEditState();
}

class _ContainerChildrenPositionEditState
    extends State<ContainerChildrenPositionEdit> {
  List<ContainerEntry> childrenWithBarcodes = [];
  List<String> barcodesToScan = [];
  List<String> gridMarkers = [];

  @override
  void initState() {
    super.initState();
    getChildrenWithBarcodes();
    getMarkers();
  }

  Color outlineColor = Colors.white54;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: CustomOutlineContainer(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heading(),
              _childrenListView(),
              _actions(),
            ],
          ),
        ),
        outlineColor: outlineColor,
      ),
    );
  }

  Widget _heading() {
    return Text(
      'Children with barcodes',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _childrenListView() {
    return Column(
      children: childrenWithBarcodes
          .map((containerEntry) => _listTile(containerEntry))
          .toList(),
    );
  }

  Widget _listTile(ContainerEntry containerEntry) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: OrangeOutlineContainer(
        margin: 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) {
                    if (containerEntry.name?.isNotEmpty ?? false) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            containerEntry.name!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            containerEntry.containerUID,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      );
                    } else {
                      return Text(
                        containerEntry.containerUID,
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }
                  },
                ),
                Text(
                  'has position?',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            //Navigate to position Scan page.

            if (gridMarkers.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              deleteAllChildrenPositions();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BarcodePositionScannerView(
                    barcodesToScan: barcodesToScan,
                    gridMarkers: gridMarkers,
                    parentContainerUID: widget.currentContainerUID,
                  ),
                ),
              );
            }
          },
          child: OrangeOutlineContainer(
            child: Text(
              'scan',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            //View map of children.
            // await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         BarcodePositionScannerDataVisualizationView(
            //             parentContainerUID: widget.currentContainerUID,
            //             barcodesToScan: ,),
            //   ),
            // );
          },
          child: OrangeOutlineContainer(
            child: Text(
              'view',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }

  final snackBar = const SnackBar(
    content: Text('Please scan at least one marker'),
    duration: Duration(milliseconds: 500),
  );

  void getChildrenWithBarcodes() {
    List<ContainerRelationship> allChildren = isarDatabase!
        .containerRelationships
        .filter()
        .parentUIDMatches(widget.currentContainerUID)
        .findAllSync();

    log(allChildren.toString());

    childrenWithBarcodes = [];
    for (ContainerRelationship child in allChildren) {
      ContainerEntry? container = isarDatabase!.containerEntrys
          .filter()
          .containerUIDMatches(child.containerUID)
          .findFirstSync();
      if (container != null && container.barcodeUID != null) {
        childrenWithBarcodes.add(container);
        barcodesToScan.add(container.barcodeUID!);
      }
    }

    setState(() {});
    //log(barcodesToScan.toString());
  }

  void getMarkers() {
    gridMarkers = [];
    gridMarkers.addAll(isarDatabase!.markers
        .filter()
        .parentContainerUIDMatches(widget.currentContainerUID)
        .barcodeUIDProperty()
        .findAllSync());

    setState(() {});
    //log(gridMarkers.toString());
  }

  void deleteAllChildrenPositions() {
    for (String barcodeUID in barcodesToScan) {
      isarDatabase!.writeTxnSync((isar) => isar.realInterBarcodeVectorEntrys
          .filter()
          .startBarcodeUIDMatches(barcodeUID)
          .or()
          .endBarcodeUIDMatches(barcodeUID)
          .deleteAllSync());
    }
  }
}
