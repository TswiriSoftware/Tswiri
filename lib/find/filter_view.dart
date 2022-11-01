import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tswiri_database/models/find/find.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => FilterViewState();
}

class FilterViewState extends State<FilterView> {
  // late Map<String, String> filters = Provider.of<Find>(context).findFilters;

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
      title: const Text('Filters'),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var e in Provider.of<Find>(context).findFilters.keys)
            SwitchListTile(
              value: Provider.of<Find>(context).isFilterActive(e),
              onChanged: (value) =>
                  Provider.of<Find>(context, listen: false).toggleFilter(e),
              title: Text(e),
              subtitle:
                  Text(Provider.of<Find>(context).findFilters[e].toString()),
            )
        ],
      ),
    );
  }
}
