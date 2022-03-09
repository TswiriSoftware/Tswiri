import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/scanningAdapter/real_barocode_position_entry.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/shelfAdapter/shelf_entry.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/demoViews/shelves/shelf_name_and_description_view.dart';
import 'package:hive/hive.dart';

import '../../../globalValues/global_hive_databases.dart';
import '../../../widgets/basic_dark_container.dart';
import '../../../widgets/basic_light_container.dart';
import 'shelfFunctions/update_shelf_entry.dart';

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
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          BasicLightContainer(
            children: [
              BasicDarkContainer(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
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
                    },
                    child: const Text('Modify'),
                  ),
                ],
              ),
            ],
          ),
          BasicLightContainer(
            children: [
              BasicDarkContainer(children: [
                FutureBuilder<List<int>>(
                  future: getShelfStats(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Barcodes ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Boxes: ${snapshot.data![0]}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //TODO:
                    },
                    child: const Text('Barcodes'),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<List<int>> getShelfStats() async {
    Box<RealBarcodePostionEntry> realBarcodePositions =
        await Hive.openBox(realPositionsBoxName);
    int numberOfBoxes = realBarcodePositions.values
        .where((element) => element.shelfUID == widget.shelfEntry.uid)
        .length;
    return [numberOfBoxes];
  }
}
