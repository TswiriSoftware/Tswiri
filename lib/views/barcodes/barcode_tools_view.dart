import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/views/barcode_generator/barcode_generator_view.dart';
import 'package:flutter_google_ml_kit/views/barcodes/barcodes_view.dart';
import 'package:flutter_google_ml_kit/views/widgets/cards/custom_card/custom_card.dart';

import '../../global_values/all_globals.dart';

class BarcodeToolsView extends StatefulWidget {
  const BarcodeToolsView({Key? key}) : super(key: key);

  @override
  State<BarcodeToolsView> createState() => _BarcodeToolsViewState();
}

class _BarcodeToolsViewState extends State<BarcodeToolsView> {
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
      title: Text(
        'Barcode Tools',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        children: const [
          CustomCard(
            'Barcode Generator',
            BarcodeGeneratorView(),
            Icons.qr_code_2_rounded,
            featureCompleted: true,
            tileColor: sunbirdOrange,
          ),
          CustomCard(
            'All Barcodes',
            BarcodesView(),
            Icons.list,
            featureCompleted: true,
            tileColor: sunbirdOrange,
          ),
        ],
      ),
    );
  }
}
