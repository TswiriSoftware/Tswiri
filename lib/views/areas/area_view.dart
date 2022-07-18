import 'package:flutter/material.dart';
import 'package:sunbird_v2/widgets/cards/new_area_card.dart';

class AreaView extends StatefulWidget {
  const AreaView({Key? key}) : super(key: key);

  @override
  State<AreaView> createState() => _AreaViewState();
}

class _AreaViewState extends State<AreaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: Text(
        "Area's",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [],
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const NewAreaCard(),
      ],
    );
  }
}
