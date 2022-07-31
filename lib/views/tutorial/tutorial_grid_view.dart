import 'package:flutter/material.dart';

class TutorialGridView extends StatefulWidget {
  const TutorialGridView({Key? key}) : super(key: key);

  @override
  State<TutorialGridView> createState() => _TutorialGridViewState();
}

class _TutorialGridViewState extends State<TutorialGridView> {
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
        'Grid Tutorial',
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
