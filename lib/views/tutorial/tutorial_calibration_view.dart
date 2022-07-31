import 'package:flutter/material.dart';

class TutorialCalibrationView extends StatefulWidget {
  const TutorialCalibrationView({Key? key}) : super(key: key);

  @override
  State<TutorialCalibrationView> createState() =>
      _TutorialCalibrationViewState();
}

class _TutorialCalibrationViewState extends State<TutorialCalibrationView> {
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
        'Camera Calibration Tutorial',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [],
    );
  }
}
