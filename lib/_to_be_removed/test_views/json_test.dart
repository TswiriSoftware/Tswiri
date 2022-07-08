import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/objects/calibration/accelerometer_data.dart';
import 'package:flutter_google_ml_kit/objects/grid/processing/on_image_inter_barcode_data.dart';

import '../../objects/grid/processing/on_image_barcode_data.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart' as v;

class JsonTest extends StatefulWidget {
  const JsonTest({Key? key}) : super(key: key);

  @override
  State<JsonTest> createState() => _JsonTestState();
}

class _JsonTestState extends State<JsonTest> {
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
        'Json Tests',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                //1. Test AccelerometerData convertion "Check"
                //2. Test OnImageBarcodeData "Check"

                OnImageInterBarcodeData onImageInterBarcodeData =
                    OnImageInterBarcodeData(
                  startBarcode: startBarcode,
                  endBarcode: endBarcode,
                );

                // log('converting');

                var json = onImageInterBarcodeData.toJson();
                log(json.toString());
                OnImageInterBarcodeData a =
                    OnImageInterBarcodeData.fromJsopn(json);
                log(a.toString());

                // log(.toString());
              },
              child: const Text('Convert'),
            ),
          ],
        ),
      ],
    );
  }

  late OnImageBarcodeData startBarcode = OnImageBarcodeData(
      barcodeUID: '1',
      onImageCornerPoints: [
        const Offset(0, 0),
        const Offset(100, 0),
        const Offset(100, 100),
        const Offset(0, 100),
      ],
      timestamp: 1,
      accelerometerData: a1);

  late OnImageBarcodeData endBarcode = OnImageBarcodeData(
    barcodeUID: '2',
    onImageCornerPoints: [
      const Offset(300, 300),
      const Offset(400, 300),
      const Offset(400, 400),
      const Offset(300, 400),
    ],
    timestamp: 1,
    accelerometerData: a2,
  );

  AccelerometerData a1 = AccelerometerData(
    accelerometerEvent: v.Vector3(1.0, 0, 0),
    userAccelerometerEvent: v.Vector3(0, 2.0, 0),
  );

  AccelerometerData a2 = AccelerometerData(
    accelerometerEvent: v.Vector3(0, 0, 0),
    userAccelerometerEvent: v.Vector3(0, 0, 0),
  );
}
