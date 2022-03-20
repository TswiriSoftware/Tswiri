import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:hive/hive.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../databaseAdapters/allBarcodes/barcode_data_entry.dart';
import '../../globalValues/global_hive_databases.dart';
import 'generated_barcodes_pdf_view.dart';

class BarcodeGeneratorView extends StatefulWidget {
  const BarcodeGeneratorView({Key? key}) : super(key: key);

  @override
  State<BarcodeGeneratorView> createState() => _BarcodeGeneratorViewState();
}

class _BarcodeGeneratorViewState extends State<BarcodeGeneratorView> {
  int rangeStart = 1;
  int rangeEnd = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barcode Generator',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          LightDarkContainer(
            child: Column(
              children: [
                Text(
                  'Select range to generate',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(
                  color: Colors.deepOrange,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Range: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    //RangeStart
                    OrangeOutlineContainer(
                      padding: 0,
                      margin: 5,
                      child: NumberPicker(
                        haptics: true,
                        selectedTextStyle: TextStyle(
                            color: Colors.deepOrange[300], fontSize: 22),
                        itemHeight: 50,
                        itemWidth: 60,
                        minValue: 1,
                        maxValue: 200,
                        value: rangeStart,
                        onChanged: (value) {
                          setState(() {
                            if (value >= rangeEnd) {
                              rangeEnd = value;
                            }
                            rangeStart = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      'to',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    //RangeEnd
                    OrangeOutlineContainer(
                      padding: 0,
                      margin: 5,
                      child: NumberPicker(
                        haptics: true,
                        selectedTextStyle: TextStyle(
                            color: Colors.deepOrange[300], fontSize: 22),
                        itemHeight: 50,
                        itemWidth: 60,
                        minValue: 1,
                        maxValue: 200,
                        value: rangeEnd,
                        onChanged: (value) {
                          setState(() {
                            if (value <= rangeStart) {
                              rangeStart = value;
                            }
                            rangeEnd = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //GenerateBarcodes.
          InkWell(
            onTap: () async {
              await addBarcodeData();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BarcodeGenerationView(
                            rangeEnd: rangeEnd,
                            rangeStart: rangeStart,
                          )));
            },
            child: const OrangeOutlineContainer(
              width: 100,
              child: Icon(
                Icons.print_rounded,
              ),
            ),
          ),

          LightDarkContainer(
              child: Column(
            children: [Text('History ???')],
          ))
        ],
      ),
    );
  }

  Future<void> addBarcodeData() async {
    //Open Barcode DataBox
    Box<BarcodeDataEntry> barcodeData = await Hive.openBox(allBarcodesBoxName);

    //Put barcode data
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    for (int i = rangeStart; i <= rangeEnd; i++) {
      String barcodeUID = '${i}_' + '${timestamp + i}';
      if (!barcodeData.containsKey(i)) {
        if (i == 1) {
          await barcodeData.put(
              i,
              BarcodeDataEntry(
                  uid: barcodeUID,
                  barcodeSize: 100,
                  isMarker: true,
                  description: 'Add a description'));
        } else {
          await barcodeData.put(
              i,
              BarcodeDataEntry(
                  uid: barcodeUID,
                  barcodeSize: 100,
                  isMarker: false,
                  description: 'Add a description'));
        }
      }
    }
    //close Box
    barcodeData.close();
  }
}
