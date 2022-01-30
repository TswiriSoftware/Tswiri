import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';

import 'barcode_generation_view.dart';

class BarcodeGeneratorView extends StatefulWidget {
  const BarcodeGeneratorView({Key? key}) : super(key: key);

  @override
  _BarcodeGeneratorViewState createState() => _BarcodeGeneratorViewState();
}

class _BarcodeGeneratorViewState extends State<BarcodeGeneratorView> {
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
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            SelectRangeWidget()
          ],
        ),
        // child: GridView.count(
        //   padding: const EdgeInsets.all(16),
        //   mainAxisSpacing: 8,
        //   crossAxisSpacing: 16,
        //   crossAxisCount: 1,
        //   children: const [],
        // ),
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
  int dropdownValue1 = 1;
  int dropdownValue2 = 1;
  List<int> numbers = List.generate(100, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.deepOrange, width: 2),
              top: BorderSide(color: Colors.deepOrange, width: 2),
              left: BorderSide(color: Colors.deepOrange, width: 2),
              right: BorderSide(color: Colors.deepOrange, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Select range from',
            style: TextStyle(color: Colors.white70),
          ),
          DropdownButton<int>(
            value: dropdownValue1,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.deepOrange),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (int? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
                if (dropdownValue2 <= dropdownValue1) {
                  dropdownValue2 = dropdownValue1 + 6;
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
            value: dropdownValue2,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.deepOrange),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            onChanged: (int? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
            items: numbers.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrCodeGenerationView(
                              rangeEnd: dropdownValue2,
                              rangeStart: dropdownValue1,
                            )));
              },
              icon: const Icon(
                Icons.print_rounded,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
