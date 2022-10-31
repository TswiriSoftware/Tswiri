import 'package:flutter/material.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => FilterViewState();
}

class FilterViewState extends State<FilterView> {
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
      elevation: 10,
      title: Text('Filters'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
