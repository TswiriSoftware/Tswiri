import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/barcode_control_panel.dart';
import '../../databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import '../../functions/barcodeTools/get_data_functions.dart';
import '../../globalValues/global_colours.dart';

class ScannedBarcodesView extends StatefulWidget {
  const ScannedBarcodesView({Key? key, required this.scannedBarcodes})
      : super(key: key);
  final Set<int> scannedBarcodes;
  @override
  _ScannedBarcodesViewState createState() => _ScannedBarcodesViewState();
}

class _ScannedBarcodesViewState extends State<ScannedBarcodesView> {
  List<int> scannedBarcodes = [];

  @override
  void initState() {
    scannedBarcodes = widget.scannedBarcodes.toList();
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
        ),
        body: ListView.builder(
            itemCount: scannedBarcodes.length,
            itemBuilder: (context, index) {
              scannedBarcodes.sort();
              return BarcodeDisplayWidget(barcodeID: scannedBarcodes[index]);
            }));
  }
}

class BarcodeDisplayWidget extends StatelessWidget {
  const BarcodeDisplayWidget({Key? key, required this.barcodeID})
      : super(key: key);
  final int barcodeID;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BarcodeControlPanelView(barcodeID: barcodeID)));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white60, width: 0.8),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(4),
            height: 60,
            width: (MediaQuery.of(context).size.width * 0.13),
            decoration: const BoxDecoration(
                color: deepSpaceSparkle, shape: BoxShape.circle),
            child: Center(
              child: Text(barcodeID.toString()),
            ),
          ),
        ));
  }
}
