import 'package:flutter/material.dart';
import 'package:tswiri/add/add_container_view.dart';
import 'package:tswiri/navigation_widgets/open_list_tile.dart';
import 'package:tswiri/utilities/barcodes/barcode_generator_view.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => AddViewState();
}

class AddViewState extends State<AddView> {
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
      title: const Text('Add'),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Text('Container Shortcuts'),
          OpenListTile(
            title: 'Add Container',
            trailingIconData: Icons.add_rounded,
            leadingIconData: Icons.inventory_2_rounded,
            destination: AddContainerView(),
          ),
          Divider(),
          Text('QR Code Shortcuts'),
          OpenListTile(
            title: 'Generate QR Codes',
            trailingIconData: Icons.add_rounded,
            leadingIconData: Icons.qr_code_2_rounded,
            destination: BarcodeGeneratorView(),
          ),
          Divider(),
          Text('Grid Shortcuts'),
          Divider(),
          Text('Find Shortcuts'),
          Divider(),
        ],
      ),
    );
  }
}
