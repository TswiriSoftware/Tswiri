import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapter/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/shelfAdapter/shelf_entry.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeScanning/real_barcode_position_database_visualization_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/shelves/shelf_name_and_description_view.dart';
import 'package:hive/hive.dart';

import '../../globalValues/global_hive_databases.dart';
import '../../widgets/basic_dark_container.dart';
import '../../widgets/basic_light_container.dart';
import '../barcodeScanning/barcode_marker_scanner_view.dart';
import '../barcodeScanning/barcode_scanner_view.dart';
import '../barcodeControlPanel/barcode_list_view.dart';
import '../../functions/shelves/update_shelf_entry.dart';

class ShelfView extends StatefulWidget {
  const ShelfView({Key? key, required this.shelfEntry}) : super(key: key);

  final ShelfEntry shelfEntry;

  @override
  State<ShelfView> createState() => _ShelfViewState();
}

class _ShelfViewState extends State<ShelfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          widget.shelfEntry.name,
          style: const TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              boxesInfoDialog(context);
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          //Name and Description.
          BasicLightContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 3,
                ),
                GestureDetector(
                  onTap: () async {
                    await modifyNameAndDescription(context);
                  },
                  child: BasicDarkContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Name: ' + widget.shelfEntry.name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Description: ' + widget.shelfEntry.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const BasicOrangeOutlineContainer(
                  child: Text(
                    'Tap to modify',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          //Barcode Stats/Rescan
          BasicLightContainer(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () async {
                  await navigateToBarcodeListView(context);
                },
                child: BasicDarkContainer(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FutureBuilder<List<int>>(
                            future: getShelfStats(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Boxes ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'Number of Markers: ${snapshot.data![1]}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Number of Boxes: ${snapshot.data![0]}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const BasicOrangeOutlineContainer(
                child: Text(
                  'Tap for box list',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          )),
          BasicLightContainer(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BasicDarkContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Options:',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RealBarcodePositionDatabaseVisualizationView(
                                  shelfUID: widget.shelfEntry.uid),
                        ),
                      );
                    },
                    child: const Text('Position Visualizer'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarcodeScannerView(
                            shelfUID: widget.shelfEntry.uid,
                          ),
                        ),
                      );
                    },
                    child: const Text('Rescan Boxes'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BarcodeMarkerScannerView(),
                        ),
                      );
                    },
                    child: const Text('Rescan Markers'),
                  ),
                ],
              ))
            ],
          ))
        ],
      ),
    );
  }

  void boxesInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Boxes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
                '1. You can rescan your Boxes if you have moved your Markers with "Rescan Boxes"\n'),
            Text(
                '2. You can rescan your Markers if you have changed them with "Rescan Markers"\nYou will then have to rescan the boxes aswell.\n'),
            Text(
                "3. You can create tags and add them to boxes.\nOR\nYou can photograph the box's content and use the generated tags\nJust Click on 'Boxes'"),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(_);
              },
              child: const Text('ok'))
        ],
      ),
    );
  }

  Future<void> navigateToBarcodeListView(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeListView(shelfEntry: widget.shelfEntry),
      ),
    );
  }

  Future<void> modifyNameAndDescription(BuildContext context) async {
    List<String> result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShelfNameAndDescriptionView(
            shelfName: widget.shelfEntry.name,
            shelfDescription: widget.shelfEntry.description),
      ),
    );
    //Update Shelf name and Description.
    setState(() {
      widget.shelfEntry.name = result.first;
      widget.shelfEntry.description = result.last;
    });

    //Update Hive box.
    await updateShelfEntry(widget.shelfEntry);
  }

  Future<List<int>> getShelfStats() async {
    Box<RealBarcodePostionEntry> realBarcodePositions =
        await Hive.openBox(realPositionsBoxName);
    int numberOfBoxes = realBarcodePositions.values
        .where((element) => element.shelfUID == widget.shelfEntry.uid)
        .length;
    int numberOfMarkers = realBarcodePositions.values
        .where((element) => element.isFixed == true)
        .length;
    return [numberOfBoxes, numberOfMarkers];
  }
}
