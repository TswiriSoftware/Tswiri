import 'package:flutter/material.dart';

class BarcodeImportView extends StatefulWidget {
  const BarcodeImportView({Key? key}) : super(key: key);

  @override
  State<BarcodeImportView> createState() => BarcodeImportViewState();
}

class BarcodeImportViewState extends State<BarcodeImportView> {
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
      title: const Text('Barcode Import'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: const [],
      ),
    );
  }
}
