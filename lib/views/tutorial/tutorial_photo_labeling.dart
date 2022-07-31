import 'package:flutter/material.dart';

class TutorialPhotoLabelView extends StatefulWidget {
  const TutorialPhotoLabelView({Key? key}) : super(key: key);

  @override
  State<TutorialPhotoLabelView> createState() => _TutorialPhotoLabelViewState();
}

class _TutorialPhotoLabelViewState extends State<TutorialPhotoLabelView> {
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
        'Photo Label Tutorial',
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
