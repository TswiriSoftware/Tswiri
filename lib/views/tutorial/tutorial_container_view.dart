import 'package:flutter/material.dart';

class TutorialContainerView extends StatefulWidget {
  const TutorialContainerView({Key? key}) : super(key: key);

  @override
  State<TutorialContainerView> createState() => _TutorialContainerViewState();
}

class _TutorialContainerViewState extends State<TutorialContainerView> {
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
        'Container Tutorial',
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
