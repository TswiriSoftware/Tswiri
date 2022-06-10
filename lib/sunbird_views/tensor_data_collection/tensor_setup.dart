import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_frame_visualizer.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/tensor_data_capturing_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'package:intl/intl.dart';
import 'dart:math' as m;
import 'package:vector_math/vector_math.dart' as vm;

class TensorSetupView extends StatefulWidget {
  const TensorSetupView({Key? key}) : super(key: key);

  @override
  State<TensorSetupView> createState() => _TensorSetupViewState();
}

class _TensorSetupViewState extends State<TensorSetupView> {
  List<TensorData> tensorData = [];

  final TextEditingController _textEditingControllerX = TextEditingController();
  final TextEditingController _textEditingControllerY = TextEditingController();
  final TextEditingController _textEditingControllerZ = TextEditingController();

  bool xAngleValid = false;
  bool yAngleValid = false;
  bool zAngleValid = false;

  bool isExporting = false;

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
        'Tensor Data Capturing',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                tensorData = [];
              });
            },
            child: const Icon(Icons.delete))
      ],
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _captureData(),
          _dataDisplay(),
        ],
      ),
    );
  }

  Widget _captureData() {
    return defaultCard(
      borderColor: sunbirdOrange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (xAngleValid && yAngleValid && zAngleValid) {
                List<TensorData>? data = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TensorDataCapturingView()),
                );
                if (data != null) {
                  tensorData = data;
                }
                //log(tensorData.toString());
                setState(() {});
              }
            },
            child: Text(
              'Capture Data',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _angleSelector(_textEditingControllerX, 'X'),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
                _angleSelector(_textEditingControllerY, 'Y'),
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                ),
                _angleSelector(_textEditingControllerZ, 'Z'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _angleSelector(
      TextEditingController textEditingController, String plane) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Angle $plane°',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: TextFormField(
            autofocus: false,
            textAlign: TextAlign.center,
            controller: textEditingController,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Angle';
              } else {
                double? x = double.tryParse(value);
                if (x == null) {
                  return 'Enter Valid Angle';
                } else {
                  switch (plane) {
                    case 'X':
                      xAngleValid = true;
                      break;
                    case 'Y':
                      yAngleValid = true;
                      break;
                    case 'Z':
                      zAngleValid = true;
                      break;
                  }
                  return null;
                }
              }
            },
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Text(
          'R: ${roundDouble(_degreesToRadians(double.tryParse(textEditingController.text) ?? 0), 5)}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _dataDisplay() {
    return defaultCard(
      borderColor: sunbirdOrange,
      body: Center(
        child: Column(
          children: [
            _exportData(),
            for (TensorData t in tensorData) _tensorData(t),
          ],
        ),
      ),
    );
  }

  Widget _exportData() {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          isExporting = true;
        });

        String name =
            'X${_textEditingControllerX.text}_Y${_textEditingControllerY.text}_Z${_textEditingControllerZ.text}.txt';

        File myFile = File('/storage/emulated/0/Download/TensorData/$name');

        DateTime now = DateTime.now();

        await myFile.writeAsString(
          '\n\nTimestamp: ${DateFormat('yyyy-MM-dd – kk:mm').format(now)} X: ${_textEditingControllerX.text}°, Y:${_textEditingControllerY.text}°, Z:${_textEditingControllerZ.text}°, X=${roundDouble(_degreesToRadians(double.tryParse(_textEditingControllerX.text) ?? 0), 5)}, Y=${roundDouble(_degreesToRadians(double.tryParse(_textEditingControllerY.text) ?? 0), 5)}, Z=${roundDouble(_degreesToRadians(double.tryParse(_textEditingControllerZ.text) ?? 0), 5)}',
          mode: FileMode.append,
        );

        for (var data in tensorData) {
          data.normalizeCornerPoints();
          List<vm.Vector2> cp = data.normalizeCornerPoints();
          await myFile.writeAsString(
            '\n[${cp[0].x}, ${cp[0].y}, ${cp[1].x}, ${cp[1].y}, ${cp[2].x}, ${cp[2].y}, ${cp[3].x}, ${cp[3].y}],',
            mode: FileMode.append,
          );
        }

        setState(() {
          isExporting = false;
        });
      },
      child: isExporting
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Export'),
    );
  }

  Widget _tensorData(TensorData t) {
    return defaultCard(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frame',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                  '${roundDouble(t.normalizeCornerPoints()[0].x, 6)}, ${roundDouble(t.normalizeCornerPoints()[0].y, 6)}'),
              Text(
                  '${roundDouble(t.normalizeCornerPoints()[1].x, 6)}, ${roundDouble(t.normalizeCornerPoints()[1].y, 6)}'),
              Text(
                  '${roundDouble(t.normalizeCornerPoints()[2].x, 6)}, ${roundDouble(t.normalizeCornerPoints()[2].y, 6)}'),
              Text(
                  '${roundDouble(t.normalizeCornerPoints()[3].x, 6)}, ${roundDouble(t.normalizeCornerPoints()[3].y, 6)}'),
            ],
          ),
          _viewer(t)
        ],
      ),
      borderColor: sunbirdOrange,
      color: Colors.black12,
    );
  }

  Widget _viewer(TensorData t) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: sunbirdOrange, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      height: 100,
      width: 100,
      child: InteractiveViewer(
        scaleFactor: 5,
        maxScale: 10,
        minScale: 1,
        child: CustomPaint(
          //size: Size.infinite,
          painter: TensorVisualizerPainter(tensorData: t),
        ),
      ),
    );
  }

  double _degreesToRadians(double degrees) {
    return degrees * (m.pi / 180);
  }
}
