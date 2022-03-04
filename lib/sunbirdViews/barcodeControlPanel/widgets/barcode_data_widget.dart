import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:provider/provider.dart';

import '../../../objects/change_notifiers.dart';

class BarcodeDataContainer extends StatefulWidget {
  const BarcodeDataContainer({
    Key? key,
    required this.barcodeID,
  }) : super(key: key);

  //final BarcodeAndTagData barcodeAndTagData;
  final int barcodeID;

  @override
  State<BarcodeDataContainer> createState() => _BarcodeDataContainerState();
}

class _BarcodeDataContainerState extends State<BarcodeDataContainer> {
  double barcodeSize = 0;
  String description = '';
  final TextEditingController _barcodeDiagonalLengthController =
      TextEditingController();
  final TextEditingController _barcodeDescriptionController =
      TextEditingController();

  @override
  void initState() {
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
          //Heading
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Barcode Data',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          //ID
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
            child: Text(
              'Barcode ID:  ' + widget.barcodeID.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
          //Diagonal Length
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
                          title: const Text(
                              'Enter Barcode diagonal length in mm.'),
                          content: TextField(
                            controller: _barcodeDiagonalLengthController,
                            textInputAction: TextInputAction.go,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            decoration: const InputDecoration(
                                hintText: "Enter barcode size."),
                          ),
                          actions: [
                            ElevatedButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                  barcodeSize = double.parse(
                                      _barcodeDiagonalLengthController.text);
                                  setBarcodeSize();
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: deepSpaceSparkle))
                          ],
                        );
                      });
                },
                child: Text(
                  'Barcode Diagonal Length:  ' +
                      Provider.of<BarcodeDataChangeNotifier>(context)
                          .barcodeSize
                          .toString() +
                      ' mm',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          //isFixed
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
                  Provider.of<BarcodeDataChangeNotifier>(context, listen: false)
                      .changeFixed(widget.barcodeID);
                },
                child: Text(
                  'Fixed :  ' +
                      Provider.of<BarcodeDataChangeNotifier>(context)
                          .isFixed
                          .toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          //Description
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
                          title: const Text('Enter Barcode Description.'),
                          content: TextField(
                            controller: _barcodeDescriptionController,
                            textInputAction: TextInputAction.go,
                            decoration: const InputDecoration(
                                hintText: "Enter barcode description."),
                          ),
                          actions: [
                            ElevatedButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                  description =
                                      _barcodeDescriptionController.text;

                                  setBarcodeDescription();
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: deepSpaceSparkle))
                          ],
                        );
                      });
                },
                child: Text(
                  'Description:  ' +
                      Provider.of<BarcodeDataChangeNotifier>(context)
                          .description,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  setBarcodeSize() {
    Provider.of<BarcodeDataChangeNotifier>(context, listen: false)
        .changeBarcodeSize(widget.barcodeID, barcodeSize);
  }

  setBarcodeDescription() {
    Provider.of<BarcodeDataChangeNotifier>(context, listen: false)
        .changeBarcodeDescription(widget.barcodeID, description);
  }
}
