import 'package:flutter/material.dart';

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
  int rangeValue1 = 1;
  int rangeValue2 = 1;
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
                value: rangeValue1,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepOrange),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    rangeValue1 = newValue!;
                    if (rangeValue2 <= rangeValue1) {
                      rangeValue2 = rangeValue1 + 6;
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
                value: rangeValue2,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepOrange),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    rangeValue2 = newValue!;
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeGenerationView(
                              rangeEnd: rangeValue2,
                              rangeStart: rangeValue1,
                            )));
              },
              child: const Icon(Icons.print_rounded))
        ],
      ),
    );
  }
}
