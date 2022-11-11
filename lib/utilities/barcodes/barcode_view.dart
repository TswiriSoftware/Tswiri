import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/utilities/barcodes/pdf/pdf_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

class BarcodeView extends StatefulWidget {
  const BarcodeView({
    Key? key,
    required this.catalogedBarcode,
  }) : super(key: key);
  final CatalogedBarcode catalogedBarcode;
  @override
  State<BarcodeView> createState() => BarcodeViewState();
}

class BarcodeViewState extends State<BarcodeView> {
  late final CatalogedBarcode _catalogedBarcode = widget.catalogedBarcode;
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
      title: Text(_catalogedBarcode.barcodeUID),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarcodeWidget(
                barcode: Barcode.qrCode(
                  errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                ),
                data: _catalogedBarcode.barcodeUID,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                color: Colors.white,
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              title: Text('Print'),
              trailing: const Icon(Icons.print_rounded),
              onTap: () {
                //TODO: reprint barcode
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfView(
                        barcodeUIDs: [_catalogedBarcode.barcodeUID],
                        size: getBarcodeBatchSync(
                                batchID: _catalogedBarcode.batchID)!
                            .width
                        // isar!.barcodeBatchs
                        //     .filter()
                        //     .idEqualTo(_catalogedBarcode.batchID)
                        //     .findFirstSync()!
                        //     .width,
                        ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
