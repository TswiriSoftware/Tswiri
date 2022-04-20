import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/marker/marker.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings_functions.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

import '../../../isar_database/functions/isar_functions.dart';

class ContainerNewMarkersView extends StatefulWidget {
  const ContainerNewMarkersView(
      {Key? key,
      required this.containerUID,
      required this.color,
      required this.newMarkers})
      : super(key: key);

  final String containerUID;
  final Color color;
  final List<String> newMarkers;
  @override
  State<ContainerNewMarkersView> createState() =>
      _ContainerNewMarkersViewState();
}

class _ContainerNewMarkersViewState extends State<ContainerNewMarkersView> {
  late String containerUID;
  late Color color;
  late List<String> newSelectedMarkers = widget.newMarkers;

  @override
  void initState() {
    containerUID = widget.containerUID;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(builder: (context) {
        if (newSelectedMarkers.isNotEmpty) {
          return FloatingActionButton(
            backgroundColor: color,
            onPressed: () {
              Navigator.pop(
                context,
                newSelectedMarkers,
              );
            },
            child: const Icon(
              Icons.done,
            ),
          );
        }
        return Container();
      }),
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          containerUID + ' Markers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          List<Marker> existingMarkers = isarDatabase!.markers
              .filter()
              .parentContainerUIDMatches(containerUID)
              .findAllSync();

          log(existingMarkers.toString());

          List<Marker> newMarkers = [];
          for (String item in widget.newMarkers) {
            //Check if marker exists.
            if (existingMarkers
                .where((element) => element.barcodeUID == item)
                .isEmpty) {
              newMarkers.add(Marker()
                ..barcodeUID = item
                ..parentContainerUID = containerUID);
            }
          }

          return Column(
            children: newMarkers.map((e) => markerWidget(e)).toList(),
          );
        }),
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
        outlineColor: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'barcodeUID',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              marker.barcodeUID,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Builder(
              builder: (context) {
                ContainerEntry? containerEntry = isarDatabase!.containerEntrys
                    .filter()
                    .barcodeUIDMatches(marker.barcodeUID)
                    .findFirstSync();
                if (containerEntry == null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Not Linked to a Container',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: newSelectedMarkers.contains(marker.barcodeUID),
                        onChanged: (bool? value) async {
                          _onSelected(value!, marker.barcodeUID);
                        },
                      ),
                    ],
                  );
                } else if (containerEntry.containerType != 'box') {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        containerEntry.containerUID,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: newSelectedMarkers.contains(marker.barcodeUID),
                        onChanged: (bool? value) async {
                          _onSelected(value!, marker.barcodeUID);
                        },
                      ),
                    ],
                  );
                } else {
                  return Text(
                    'Boxes cant be markers',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        newSelectedMarkers.add(dataName);
      });
    } else {
      setState(() {
        newSelectedMarkers.remove(dataName);
      });
    }
  }
}
