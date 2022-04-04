import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/marker_barcode_scanner/marker_barcode_scanner_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:isar/isar.dart';

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
            LightContainer(
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
                                  List<String> markers = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MarkerBarcodeScannerView(),
                                        ),
                                      ) ??
                                      [];
                                  if (markers.isNotEmpty) {
                                    //TODO: implement grid scanning
                                    List<Marker> existingMarkers = isarDatabase!
                                        .markers
                                        .filter()
                                        .parentContainerUIDMatches(
                                            containerEntry.containerUID)
                                        .findAllSync();
                                    //isarDatabase!.markers.filter().cont
                                  }
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
                          List<Marker> markers = isarDatabase!.markers
                              .filter()
                              .parentContainerUIDMatches(
                                  containerEntry.containerUID)
                              .findAllSync();

                          return Column(
                            children:
                                markers.map((e) => markerWidget(e)).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                  outlineColor: containerTypeColor,
                ))
          ],
        ),
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
              Text(marker.barcodeUID),
              OrangeOutlineContainer(
                width: 35,
                height: 35,
                margin: 0,
                padding: 0,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      isarDatabase!.writeTxnSync(
                        (isar) => isar.markers.deleteSync(marker.id),
                      );
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
}
