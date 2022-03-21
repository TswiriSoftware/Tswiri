import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/marker_barcode_scanner/marker_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

class ContainerMarkerEditWidget extends StatefulWidget {
  const ContainerMarkerEditWidget(
      {Key? key, required this.database, required this.currentContainerUID})
      : super(key: key);

  final String currentContainerUID;
  final Isar database;

  @override
  State<ContainerMarkerEditWidget> createState() =>
      _ContainerMarkerEditWidgetState();
}

class _ContainerMarkerEditWidgetState extends State<ContainerMarkerEditWidget> {
  Color outlineColor = Colors.white54;
  List<Marker>? markers;

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
              Column(
                children: markers
                        ?.map(
                          (e) => InkWell(
                            onTap: () {
                              //TODO: Marker Position Editor.
                            },
                            child: LightContainer(
                              margin: 2.5,
                              padding: 0,
                              child: OrangeOutlineContainer(
                                  padding: 5,
                                  margin: 2.5,
                                  child: Text(e.barcodeUID)),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      List<String> barcodeUIDs = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MarkerBarcodeScannerView(),
                        ),
                      );

                      if (barcodeUIDs.isEmpty && markers != null) {
                        //Delete all markers.
                        //TODO: Add check that user wants to delete all markers.

                        widget.database.writeTxnSync((isar) {
                          isar.markers
                              .filter()
                              .parentContainerUIDMatches(
                                  widget.currentContainerUID)
                              .deleteAllSync();
                        });
                        getContainerInfo();
                        setState(() {});
                      } else {
                        //Adds all scanned markers to database.
                        List<Marker> newMarkers = [];
                        widget.database.writeTxnSync((isar) {
                          isar.markers
                              .filter()
                              .parentContainerUIDMatches(
                                  widget.currentContainerUID)
                              .deleteAllSync();
                        });
                        setState(() {});
                        for (String barcodeUID in barcodeUIDs) {
                          newMarkers.add(Marker()
                            ..parentContainerUID = widget.currentContainerUID
                            ..barcodeUID = barcodeUID);
                        }
                        log(newMarkers.toString());
                        widget.database.writeTxnSync((isar) {
                          isar.markers.putAllSync(newMarkers);
                        });
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
                          'starting a scan will wipe existing markers',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getContainerInfo() {
    markers = [];
    markers = widget.database.markers
        .filter()
        .parentContainerUIDMatches(widget.currentContainerUID)
        .findAllSync();
  }
}
