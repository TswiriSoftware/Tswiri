import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri_database_interface/models/settings/app_settings.dart';
import 'package:tswiri_theme/widgets/list_tiles/custom_switch_list_tile.dart';

class TextDetectionSettingsView extends StatefulWidget {
  const TextDetectionSettingsView({super.key});

  @override
  State<TextDetectionSettingsView> createState() =>
      _TextDetectionSettingsViewState();
}

class _TextDetectionSettingsViewState extends State<TextDetectionSettingsView> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadSettings();
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
      title: const Text('Text Detection'),
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSwitchListTile(
            title: 'Text Detection',
            initialValue: textDetection,
            onChanged: (value) {
              setState(() {
                textDetection = value;
                prefs.setBool(textDetectionPref, value);
              });
            },
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _loadSettings() async {
    loadAppSettings();
    prefs = await SharedPreferences.getInstance();
  }
}
