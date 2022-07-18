import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbird_v2/scripts/app_settings.dart';

import '../../globals/globals_export.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SharedPreferences prefs;

  final TextEditingController _barcodeSizeController = TextEditingController();

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

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
        "Settings",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _basicSettigns(),
        ],
      ),
    );
  }

  Widget _basicSettigns() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _defaultBarcodeSize(),
            _vibration(),
            _manageGoogleBackup(),
          ],
        ),
      ),
    );
  }

  Widget _defaultBarcodeSize() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Default Barcode Size: ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Flexible(
            child: TextField(
              controller: _barcodeSizeController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onSubmitted: (value) async {
                setState(() {
                  if (double.tryParse(value) != null) {
                    _barcodeSizeController.text =
                        double.tryParse(value).toString();
                    prefs.setDouble(defaultBarcodeSizePref,
                        double.tryParse(value) ?? defaultBarcodeSize);
                  } else {
                    _barcodeSizeController.text = defaultBarcodeSize.toString();
                  }
                });
              },
            ),
          ),
          Text(
            ' x ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Flexible(
            child: TextField(
              controller: _barcodeSizeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          Text(
            'mm',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _vibration() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Vibration',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Checkbox(
            value: vibrate,
            onChanged: (value) {
              setState(() {
                vibrate = value ?? true;
                prefs.setBool(vibratePref, value ?? true);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _manageGoogleBackup() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Manage Backup',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _loadSettings() async {
    loadAppSettings();
    prefs = await SharedPreferences.getInstance();
    _barcodeSizeController.text = defaultBarcodeSize.toString();
  }
}
