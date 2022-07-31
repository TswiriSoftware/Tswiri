import 'package:flutter/material.dart';

class TutorialNavigationView extends StatefulWidget {
  const TutorialNavigationView({Key? key}) : super(key: key);

  @override
  State<TutorialNavigationView> createState() => _TutorialNavigationViewState();
}

class _TutorialNavigationViewState extends State<TutorialNavigationView> {
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
        'Navigation Tutorial',
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
