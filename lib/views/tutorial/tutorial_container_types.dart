import 'package:flutter/material.dart';

class TutorialContainerTypesView extends StatefulWidget {
  const TutorialContainerTypesView({Key? key}) : super(key: key);

  @override
  State<TutorialContainerTypesView> createState() =>
      _TutorialContainerTypesViewState();
}

class _TutorialContainerTypesViewState
    extends State<TutorialContainerTypesView> {
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
        'Container Types Tutorial',
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
