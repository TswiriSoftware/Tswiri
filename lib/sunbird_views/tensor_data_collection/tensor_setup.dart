import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/math_functionts/round_to_double.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_data.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/supporting/tensor_frame_visualizer.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tensor_data_collection/tensor_data_capturing_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'dart:math' as m;

import 'package:path_provider/path_provider.dart';

class TensorSetupView extends StatefulWidget {
  const TensorSetupView({Key? key}) : super(key: key);

  @override
  State<TensorSetupView> createState() => _TensorSetupViewState();
}

class _TensorSetupViewState extends State<TensorSetupView> {
  List<TensorData> tensorData = [];

  final TextEditingController _textEditingControllerX = TextEditingController();
  final TextEditingController _textEditingControllerY = TextEditingController();

  bool xAngleValid = false;
  bool yAngleValid = false;

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
              if (xAngleValid && yAngleValid) {
                tensorData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TensorDataCapturingView()),
                );
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
          width: MediaQuery.of(context).size.width / 2.5,
          child: TextFormField(
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
          'Radians: ${roundDouble(_degreesToRadians(double.tryParse(textEditingController.text) ?? 0), 5)}',
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
        final directory = (await getApplicationDocumentsDirectory());

        String name =
            '${DateTime.now().millisecondsSinceEpoch}_X${_textEditingControllerX.text}_Y${_textEditingControllerY.text}.txt';

        File myFile = File('${directory.path}/$name');

        await myFile.writeAsString(
            'Timestamp: ${DateTime.now().millisecondsSinceEpoch} X: ${_textEditingControllerX.text}, Y:${_textEditingControllerY.text}');
        for (var element in tensorData) {
          await myFile.writeAsString(
            '[${element.cornerPoints[0].x}, ${element.cornerPoints[0].y}], [${element.cornerPoints[1].x}, ${element.cornerPoints[1].y}], [${element.cornerPoints[2].x}, ${element.cornerPoints[2].y}], [${element.cornerPoints[3].x}, ${element.cornerPoints[3].y}]\n',
            mode: FileMode.append,
          );
        }

        File file = File('${directory.path}/$name');
        log(file.path);

        // await Share.shareFiles(['${directory.path}/$name'],
        //     text: name, mimeTypes: ['text/plain']);
      },
      child: const Text('Export'),
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
              Text(t.cornerPoints[0].toString()),
              Text(t.cornerPoints[1].toString()),
              Text(t.cornerPoints[2].toString()),
              Text(t.cornerPoints[3].toString()),
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
