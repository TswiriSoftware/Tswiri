import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/all_barcode_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/scan_barcode_view.dart';

class FinderView extends StatefulWidget {
  const FinderView({Key? key}) : super(key: key);

  @override
  _FinderViewState createState() => _FinderViewState();
}

class _FinderViewState extends State<FinderView> {
  List<AllBarcodeData> foundBarcodes = [];
  List<String> unassignedTags = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title: const Text(
          'Barcodes',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScanBarcodeView(
                            color: deepSpaceSparkle,
                          )));
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text('swipe to delete'),
          const SizedBox(height: 10),
          Expanded(
            child: foundBarcodes.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: foundBarcodes.length,
                    itemBuilder: (context, index) {
                      final foundBarcode = foundBarcodes[index];
                      return Dismissible(
                        key: Key(foundBarcode.barcodeID.toString()),
                        // onDismissed: (direction) {
                        //   deleteBarcode(foundBarcode.barcodeID,
                        //       foundBarcodes[index].isFixed);
                        //   // Remove the item from the data source.
                        //   setState(() {
                        //     foundBarcodes.removeAt(index);
                        //   });
                        // },
                        // child: displayBarcodeDataWidget(
                        //     context, foundBarcodes[index], runFilter('')),
                        child: Text('Barcode Card'),
                      );
                    })
                : const Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ),
        ],
      ),
    );
  }
}
