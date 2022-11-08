import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tswiri/utilities/barcodes/pdf/pdf_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

class BarcodeGeneratorView extends StatefulWidget {
  const BarcodeGeneratorView({Key? key}) : super(key: key);

  @override
  State<BarcodeGeneratorView> createState() => BarcodeGeneratorViewState();
}

class BarcodeGeneratorViewState extends State<BarcodeGeneratorView> {
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _numberFocusNode = FocusNode();
  int numberOfBarcodes = 1;
  bool isEditingNumberOfBarcodes = false;

  ///Defualt barcode sizes.
  final Map<String, double> barcodeSizes = {
    'Tiny': 10,
    'Extra Small': 20,
    'Small': 30,
    'Medium': 50,
    'Large': 60,
    'Extra Large': 75,
    'Custom': 100,
  };

  ///Barcodes per A4 page.
  final Map<String, int> barcodesPerPage = {
    'Tiny': 228,
    'Extra Small': 130,
    'Small': 56,
    'Medium': 20,
    'Large': 12,
    'Extra Large': 6,
    'Custom': 100,
  };

  late List<DropdownMenuItem<String>> menuItems = barcodeSizes.keys
      .map((e) => DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

  final TextEditingController _barcodeSizeController = TextEditingController();
  late String selectedBarcodeSize = menuItems[3].value!;
  late double barcodeSize = barcodeSizes[selectedBarcodeSize]!;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 10,
      title: const Text('QR Code Generator'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            _numberSelection(),
            const Divider(),
            _barcodeSize(),
            const Divider(),
            _generateButton(),
          ],
        ),
      ),
    );
  }

  Row _numberSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('Number of QR Codes: '),
        Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Builder(builder: (context) {
              if (isEditingNumberOfBarcodes) {
                return SizedBox(
                  width: 100,
                  height: 150,
                  child: Center(
                    child: TextField(
                      controller: _numberController,
                      focusNode: _numberFocusNode,
                      onSubmitted: (value) {
                        setState(() {
                          isEditingNumberOfBarcodes = false;
                          numberOfBarcodes =
                              int.tryParse(value) ?? numberOfBarcodes;
                        });
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    setState(() {
                      isEditingNumberOfBarcodes = true;
                      _numberController.text = numberOfBarcodes.toString();
                      _numberFocusNode.requestFocus();
                    });
                  },
                  child: NumberPicker(
                    minValue: 1,
                    maxValue: 1000,
                    value: numberOfBarcodes,
                    onChanged: (value) {
                      setState(() {
                        numberOfBarcodes = value;
                      });
                    },
                    selectedTextStyle: TextStyle(
                        fontSize: 24, color: Theme.of(context).primaryColor),
                  ),
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _barcodeSize() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Barcode Size: ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            DropdownButton<String>(
              value: selectedBarcodeSize,
              items: menuItems,
              onChanged: (String? item) {
                setState(() {
                  selectedBarcodeSize = item!;
                  barcodeSize = barcodeSizes[selectedBarcodeSize]!;
                  _barcodeSizeController.text = barcodeSize.toString();
                });
              },
            ),
          ],
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Size: $barcodeSize mm',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const VerticalDivider(),
                Visibility(
                  visible: selectedBarcodeSize != 'Custom',
                  child: Text(
                    'Barcodes Per Page: ${barcodesPerPage[selectedBarcodeSize]}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: selectedBarcodeSize == 'Custom',
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Text(
                    'Side Length: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _barcodeSizeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {
                          barcodeSize = double.tryParse(value) ?? barcodeSize;
                        });
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Text(
                    ' x ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Flexible(
                    child: TextField(
                      controller: _barcodeSizeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {
                          barcodeSize = double.tryParse(value) ?? barcodeSize;
                        });
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Text(
                    'mm',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _generateButton() {
    return OutlinedButton(
      onPressed: () async {
        _generateBarcodeBatch();
      },
      child: Text(
        'Generate',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Future<void> _generateBarcodeBatch() async {
    //Time of creation
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    BarcodeBatch newBarcodeBatch = BarcodeBatch()
      ..width = barcodeSize
      ..height = barcodeSize
      ..timestamp = timestamp
      ..imported = false;

    List<String> barcodeUIDs = [];

    //Write to database.
    isar!.writeTxnSync(() {
      int batchID = isar!.barcodeBatchs.putSync(newBarcodeBatch);

      for (var i = 1; i <= numberOfBarcodes; i++) {
        String barcodeUID = '${i}_$timestamp';
        isar!.catalogedBarcodes.putSync(
          CatalogedBarcode()
            ..barcodeUID = barcodeUID
            ..width = barcodeSize
            ..height = barcodeSize
            ..batchID = batchID,
        );
        barcodeUIDs.add(barcodeUID);
      }
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PdfView(
          barcodeUIDs: barcodeUIDs,
          size: barcodeSize,
        ),
      ),
    );
  }
}
