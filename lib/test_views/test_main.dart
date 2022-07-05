import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/test_views/database_manager.dart';

import '../global_values/all_globals.dart';
import '../views/widgets/cards/custom_card/custom_card.dart';

class MainTest extends StatefulWidget {
  const MainTest({Key? key}) : super(key: key);

  @override
  State<MainTest> createState() => _MainTestState();
}

class _MainTestState extends State<MainTest> {
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
        'Integration Test',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        children: const [
          CustomCard(
            'Database',
            DatabaseManager(),
            Icons.data_array,
            featureCompleted: true,
            tileColor: sunbirdOrange,
          ),
        ],
      ),
    );
  }
}
