import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/databaseAdapters/allBarcodes/barcode_entry.dart';
import 'package:flutter_google_ml_kit/globalValues/global_hive_databases.dart';
import 'package:hive/hive.dart';

import 'generated_barcodes_pdf_view.dart';

class BarcodeGenerationRangeSelectorView extends StatefulWidget {
  const BarcodeGenerationRangeSelectorView({Key? key}) : super(key: key);

  @override
  _BarcodeGenerationRangeSelectorViewState createState() =>
      _BarcodeGenerationRangeSelectorViewState();
}

class _BarcodeGenerationRangeSelectorViewState
    extends State<BarcodeGenerationRangeSelectorView> {
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
        children: const [
          SizedBox(
            height: 5,
          ),
          SelectRangeWidget()
        ],
      ),
    );
  }
}

class SelectRangeWidget extends StatefulWidget {
  const SelectRangeWidget({Key? key}) : super(key: key);

  @override
  State<SelectRangeWidget> createState() => _SelectRangeWidgetState();
}

class _SelectRangeWidgetState extends State<SelectRangeWidget> {
  int rangeStart = 1;
  int rangeEnd = 1;
  int totalNumberOfBarcodes = 100;
  List<int> totalBarcodes = List.generate(10, (index) => (index + 1) * 100);
  List<int> numbers = List.generate(100, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.deepOrange, width: 2),
              top: BorderSide(color: Colors.deepOrange, width: 2),
              left: BorderSide(color: Colors.deepOrange, width: 2),
              right: BorderSide(color: Colors.deepOrange, width: 2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Number of barcodes',
                style: TextStyle(color: Colors.white70),
              ),
              DropdownButton<int>(
                value: totalNumberOfBarcodes,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepOrange),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    totalNumberOfBarcodes = newValue!;
                    numbers = List.generate(
                        totalNumberOfBarcodes, (index) => index + 1);
                  });
                },
                items: totalBarcodes.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select range from',
                style: TextStyle(color: Colors.white70),
              ),
              DropdownButton<int>(
                value: rangeStart,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepOrange),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    rangeStart = newValue!;
                    if (rangeEnd <= rangeStart) {
                      rangeEnd = rangeStart + 6;
                    }
                  });
                },
                items: numbers.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              const Text(
                'to',
                style: TextStyle(color: Colors.white70),
              ),
              DropdownButton<int>(
                value: rangeEnd,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepOrange),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    rangeEnd = newValue!;
                  });
                },
                items: numbers.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.deepOrange)),
              onPressed: () async {
                //Save Barcode data in box
                await putBarcodeData();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeGenerationView(
                              rangeEnd: rangeEnd,
                              rangeStart: rangeStart,
                            )));
              },
              child: const Icon(Icons.print_rounded))
        ],
      ),
    );
  }

  Future<void> putBarcodeData() async {
    //Open Barcode DataBox
    Box<BarcodeDataEntry> barcodeData =
        await Hive.openBox(generatedBarcodesBoxName);

    barcodeData.clear();

    //Put barcode data
    for (int i = rangeStart; i <= rangeEnd; i++) {
      await barcodeData.put(i, BarcodeDataEntry(barcodeID: i, barcodeSize: 70));
    }
    //close Box
    barcodeData.close();
  }
}
