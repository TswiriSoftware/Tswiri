import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveDatabaseConsolidation2View extends StatefulWidget {
  const HiveDatabaseConsolidation2View({Key? key}) : super(key: key);

  @override
  _HiveDatabaseConsolidation2ViewState createState() =>
      _HiveDatabaseConsolidation2ViewState();
}

class _HiveDatabaseConsolidation2ViewState
    extends State<HiveDatabaseConsolidation2View> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List displayList = [];

  @override
  void initState() {
    displayList.clear();
    super.initState();
  }

  @override
  void dispose() {
    // Hive.close();
    // print("hive_database_consolidation Disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hive Database 2D'),
          centerTitle: true,
          elevation: 0,
        ),
        body: widget);
  }

  Future<List> consolidatingData(List displayList) async {
    displayList.clear();
    return displayList;
  }
}
