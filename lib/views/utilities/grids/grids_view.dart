import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sunbird/isar/isar_database.dart';

import 'grid/grid_viewer_view.dart';

class MarkersView extends StatefulWidget {
  const MarkersView({Key? key}) : super(key: key);

  @override
  State<MarkersView> createState() => _MarkersViewState();
}

class _MarkersViewState extends State<MarkersView> {
  late List<int> grids =
      isar!.catalogedGrids.where().findAllSync().map((e) => e.id).toList();

  @override
  void initState() {
    log(isar!.markers.where().findAllSync().toString());
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
          'Grids',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true);
  }

  Widget _body() {
    return ListView.builder(
      itemCount: grids.length,
      itemBuilder: (context, index) {
        return _gridCard(grids[index]);
      },
    );
  }

  Widget _gridCard(int gridUID) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ///ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grid UID:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  gridUID.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Divider(),

            ///Number of containers.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Container(s):',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // Text(
                //   isar!.catalogedCoordinates
                //       .filter()
                //       .gridUIDMatches(gridUID)
                //       .findAllSync()
                //       .length
                //       .toString(),
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),
              ],
            ),
            const Divider(),

            ///Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GirdViewer(
                          gridUID: gridUID,
                          catalogedContainer: null,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget _newMarkerBatch() {
  //   return InkWell(
  //     onTap: () {
  //       //TODO: implement marker scanner. ??
  //     },
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: [
  //             Text(
  //               '+',
  //               style: Theme.of(context).textTheme.bodyMedium,
  //             ),
  //             Text(
  //               '(new marker batch)',
  //               style: Theme.of(context).textTheme.bodySmall,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _markerCard(Marker marker) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         children: [
  //           Row(
  //             children: [
  //               Text(
  //                 'BarcodeUID: ${marker.barcodeUID}',
  //                 style: Theme.of(context).textTheme.bodyMedium,
  //               ),
  //             ],
  //           ),
  //           const Divider(),
  //           marker.containerUID != null
  //               ? Text(
  //                   'ContainerUID: ${marker.containerUID}',
  //                   style: Theme.of(context).textTheme.bodyMedium,
  //                 )
  //               : const SizedBox.shrink(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
