import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:provider/provider.dart';

import '../classes.dart';

class BarcodeDataContainer extends StatefulWidget {
  const BarcodeDataContainer(
      {Key? key,
      required this.barcodeAndTagData,
      required this.isFixed,
      required this.barcodeSize})
      : super(key: key);
  final BarcodeAndTagData barcodeAndTagData;
  final bool isFixed;
  final double barcodeSize;

  @override
  State<BarcodeDataContainer> createState() => _BarcodeDataContainerState();
}

class _BarcodeDataContainerState extends State<BarcodeDataContainer> {
  bool isFixed = false;
  double barcodeSize = 0;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    isFixed = widget.isFixed;
    barcodeSize = widget.barcodeSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 150,
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
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            child: Text(
              'Barcode ID:  ' + widget.barcodeAndTagData.barcodeID.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: deepSpaceSparkle[200],
                border: Border.all(color: Colors.white60, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Enter Barcode diagonal length'),
                          content: TextField(
                            controller: _textFieldController,
                            textInputAction: TextInputAction.go,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: const InputDecoration(
                                hintText: "Enter barcode size"),
                          ),
                          actions: [
                            ElevatedButton(
                              child: const Text('Submit'),
                              onPressed: () {
                                barcodeSize =
                                    double.parse(_textFieldController.text);
                                setBarcodeSize();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
                child: Text(
                  'Barcode Size:  ' +
                      Provider.of<Tags>(context).barcodeSize.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: deepSpaceSparkle[200],
                border: Border.all(color: Colors.white60, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Provider.of<Tags>(context, listen: false)
                      .changeFixed(widget.barcodeAndTagData.barcodeID);
                },
                child: Text(
                  'Fixed :  ' + Provider.of<Tags>(context).isFixed.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  setBarcodeSize() {
    Provider.of<Tags>(context, listen: false)
        .changeBarcodeSize(widget.barcodeAndTagData.barcodeID, barcodeSize);
  }
}
