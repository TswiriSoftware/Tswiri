import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/marker_barcode_scanner/marker_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/orange_text_button_widget.dart';
import 'package:isar/isar.dart';

class ContainerMarkerEditWidget extends StatefulWidget {
  const ContainerMarkerEditWidget({Key? key, required this.currentContainerUID})
      : super(key: key);

  final String currentContainerUID;

  @override
  State<ContainerMarkerEditWidget> createState() =>
      _ContainerMarkerEditWidgetState();
}

class _ContainerMarkerEditWidgetState extends State<ContainerMarkerEditWidget> {
  Color outlineColor = Colors.white54;
  List<Marker>? markers;
  String? theOrigin;

  @override
  void initState() {
    getContainerInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: CustomOutlineContainer(
        outlineColor: outlineColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marker(s)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              _markerListView(),
              _actions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _markerListView() {
    return Builder(builder: (context) {
      //ContainerEntry.
      ContainerEntry containerEntry =
          getContainerEntry(containerUID: widget.currentContainerUID);

      //ContainerType.
      ContainerType containerType = isarDatabase!.containerTypes
          .filter()
          .containerTypeMatches(containerEntry.containerType)
          .findFirstSync()!;

      if (containerType.moveable == true) {
        log('Can be childrens origin');
      } else {
        log('Cannot be childrens origin');
      }

      return Column(
        children: markers?.map((e) => markerWidget(e)).toList() ?? [],
      );
    });
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            bool shouldContinue = await _showDialog();

            if (shouldContinue == true) {
              List<String>? barcodeUIDs = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarkerBarcodeScannerView(),
                ),
              );

              if (barcodeUIDs != null &&
                  barcodeUIDs.isEmpty &&
                  markers != null) {
                isarDatabase!.writeTxnSync(
                  (isar) {
                    isar.markers
                        .filter()
                        .parentContainerUIDMatches(widget.currentContainerUID)
                        .deleteAllSync();
                  },
                );
                getContainerInfo();
                setState(() {});
              } else if (barcodeUIDs != null) {
                //Adds all scanned markers to database.
                List<Marker> newMarkers = [];
                isarDatabase!.writeTxnSync((isar) {
                  isar.markers
                      .filter()
                      .parentContainerUIDMatches(widget.currentContainerUID)
                      .deleteAllSync();
                });
                setState(() {});
                for (String barcodeUID in barcodeUIDs) {
                  newMarkers.add(Marker()
                    ..parentContainerUID = widget.currentContainerUID
                    ..barcodeUID = barcodeUID);
                }

                isarDatabase!.writeTxnSync((isar) {
                  isar.markers.putAllSync(newMarkers);
                });
              }
            }

            getContainerInfo();
            setState(() {});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OrangeOutlineContainer(
                child: Text(
                  'scan',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                'starting a scan will wipe existing markers and all positions',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget markerWidget(Marker e) {
    return InkWell(
      onTap: () {
        //TODO: Marker Position Editor.
      },
      child: LightContainer(
        margin: 2.5,
        padding: 0,
        child: OrangeOutlineContainer(
          padding: 5,
          margin: 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'barcodeUID:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                e.barcodeUID,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDialog() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'If you continue all markers will be deleted.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OrangeTextButton(
              text: 'continue',
              onTap: () {
                Navigator.pop(context, true);
              },
            ),
            OrangeTextButton(
              text: 'cancel',
              onTap: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  void getContainerInfo() {
    markers = [];
    markers = isarDatabase!.markers
        .filter()
        .parentContainerUIDMatches(widget.currentContainerUID)
        .findAllSync();
  }
}
