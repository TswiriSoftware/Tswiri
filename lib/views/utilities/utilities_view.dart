import 'package:flutter/material.dart';
import 'package:sunbird_v2/views/utilities/barcode_generator/barcode_generator_view.dart';
import 'package:sunbird_v2/views/utilities/barcodes/barcodes_view.dart';
import 'package:sunbird_v2/widgets/cards/navigator_card.dart';

class UtilitiesView extends StatefulWidget {
  const UtilitiesView({Key? key}) : super(key: key);

  @override
  State<UtilitiesView> createState() => _UtilitiesViewState();
}

class _UtilitiesViewState extends State<UtilitiesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text(
        "Utilities",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [],
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding: EdgeInsets.all(8),
        crossAxisCount: 2,
        children: const [
          NavigatorCard(
            label: 'Barcodes',
            icon: Icons.qr_code,
            viewPage: BarcodesView(),
          ),
          NavigatorCard(
            label: 'Barcode Generator',
            icon: Icons.scanner_sharp,
            viewPage: BarcodeGeneratorView(),
          ),
        ],
      ),
    );
  }
}
