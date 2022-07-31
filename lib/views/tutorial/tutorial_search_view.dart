import 'package:flutter/material.dart';

class TutorialSearchView extends StatefulWidget {
  const TutorialSearchView({Key? key}) : super(key: key);

  @override
  State<TutorialSearchView> createState() => _TutorialSearchViewState();
}

class _TutorialSearchViewState extends State<TutorialSearchView> {
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
        'Search Tutorial',
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
