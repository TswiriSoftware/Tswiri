import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import '../../../widgets/custom_card_widget.dart';

///Shows camera calibration tools.
class GettingStartedView extends StatefulWidget {
  const GettingStartedView({Key? key}) : super(key: key);

  @override
  _GettingStartedViewState createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
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
            'Getting Started',
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
                  'Getting Started',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '1. Generate some barcodes. \n     Print them out and stick them on boxes.',
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 10,
                ),
                Text('2. Calibrate the camera.',
                    style: TextStyle(fontSize: 16)),
                SizedBox(
                  height: 10,
                ),
                Text('3. etc.', style: TextStyle(fontSize: 16))
              ],
            ),
          ),
        ));
  }
}
