import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';

class BarcodeDataContainer extends StatefulWidget {
  BarcodeDataContainer({Key? key, required this.barcodeAndTagData})
      : super(key: key);
  BarcodeAndTagData barcodeAndTagData;

  @override
  State<BarcodeDataContainer> createState() => _BarcodeDataContainerState();
}

class _BarcodeDataContainerState extends State<BarcodeDataContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: deepSpaceSparkle[200],
        border: Border.all(color: Colors.white60, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, left: 10),
            child: Text(
              'Barcode Data',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Text('Barcode ID:  ' +
                widget.barcodeAndTagData.barcodeID.toString()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Text('Barcode Size:  ' +
                widget.barcodeAndTagData.barcodeSize.toString()),
          )
        ],
      ),
    );
  }
}
