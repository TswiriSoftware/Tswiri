import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';

class BarcodeGeneratorInfoView extends StatefulWidget {
  const BarcodeGeneratorInfoView({Key? key}) : super(key: key);

  @override
  _BarcodeGeneratorInfoViewState createState() =>
      _BarcodeGeneratorInfoViewState();
}

class _BarcodeGeneratorInfoViewState extends State<BarcodeGeneratorInfoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: skyBlue80,
          title: const Text(
            'Barcode Generator Info',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Barcode Generator Info',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('xx', style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 10,
                ),
                Text('xx', style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 10,
                ),
                Text('xx', style: TextStyle(fontSize: 16))
              ],
            ),
          ),
        ));
  }
}