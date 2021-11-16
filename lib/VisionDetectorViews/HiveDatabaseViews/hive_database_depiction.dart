import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDatabaseDepictionView extends StatefulWidget {
  const HiveDatabaseDepictionView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseDepictionViewState createState() =>
      _HiveDatabaseDepictionViewState();
}

class _HiveDatabaseDepictionViewState extends State<HiveDatabaseDepictionView> {
  @override
  void dispose() {
    Hive.close();
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
      body: Container(
        color: Colors.white,
        child: CustomPaint(),
      ),
    );
  }

  Future<List> loadData() async {
    List list = [];
    var box = await Hive.openBox('testBox');
    var data = box.toMap();
    data.forEach((key, value) {
      list.add([key, value]);
    });
    return list;
  }
}
