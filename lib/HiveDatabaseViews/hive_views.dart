import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/hive_database_consolidation.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/hive_database_visualization.dart';
import 'package:flutter_google_ml_kit/HiveDatabaseViews/hive_raw_database_view.dart';
import 'package:flutter_google_ml_kit/main.dart';

class HiveViews extends StatefulWidget {
  const HiveViews({Key? key}) : super(key: key);

  @override
  _HiveViewsState createState() => _HiveViewsState();
}

class _HiveViewsState extends State<HiveViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hive Database Tools',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              //help
              children: [
                Column(
                  //title: const Text("Vision"),
                  children: const [
                    CustomCard(' Raw Data Viewer', HiveDatabaseView(),
                        featureCompleted: true),
                    CustomCard(' Consolidated Data Viewer',
                        HiveDatabaseConsolidationView(),
                        featureCompleted: true),
                    CustomCard(
                        ' Consolidated Data Viewer', databaseVisualization(),
                        featureCompleted: true),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
