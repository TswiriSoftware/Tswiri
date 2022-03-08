import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/zDemoView/shelves/shelves_view.dart';

import '../globalValues/global_colours.dart';
import '../sunbirdViews/appSettings/app_settings_view.dart';
import '../widgets/custom_card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()));
              },
              icon: const Icon(Icons.settings))
        ],
        title: const Text(
          'Sunbird',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: const [
            CustomCard(
              'Shelves',
              ShelvesView(),
              Icons.qr_code_scanner_rounded,
              featureCompleted: true,
              tileColor: deeperOrange,
            ),
          ],
        ),
      ),
    );
  }
}
