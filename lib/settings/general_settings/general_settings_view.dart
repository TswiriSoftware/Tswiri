import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_theme/widgets/list_tiles/custom_switch_list_tile.dart';

class GeneralSettingsView extends StatefulWidget {
  const GeneralSettingsView({super.key});

  @override
  State<GeneralSettingsView> createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> {
  late SharedPreferences prefs;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    await loadAppSettings();
    setState(() {
      _controller.text = defaultBarcodeSize.toString();
    });
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
      title: const Text(
        'General Settings',
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _defaultBarcodeSize(),
          const Divider(),
          _vibration(),
          const Divider(),
          _colorMode(),
          const Divider(),
          _defaultFlash(),
          const Divider(),
        ],
      ),
    );
  }

  Widget _defaultBarcodeSize() {
    return ListTile(
      title: const Text(
        'Default QR Code Size',
      ),
      subtitle: Text(
        '${_controller.text} x ${_controller.text} mm',
      ),
      onTap: () async {
        double? size = await _defaultBarcodeSizeDialog(context);
        if (size != null) {
          prefs.setDouble(defaultBarcodeSizePref, size);
          defaultBarcodeSize = size;
          setState(() {
            _controller.text = size.toString();
          });
        }
      },
    );
  }

  Widget _vibration() {
    return CustomSwitchListTile(
      title: 'Vibration',
      initialValue: vibrate,
      onChanged: (bool value) {
        vibrate = value;
        prefs.setBool(vibratePref, value);
      },
    );
  }

  Widget _colorMode() {
    return CustomSwitchListTile(
      title: 'Color Mode',
      initialValue: colorModeEnabled,
      onChanged: (bool value) {
        colorModeEnabled = value;
        prefs.setBool(colorModeEnabledPref, value);
      },
    );
  }

  Widget _defaultFlash() {
    return ExpansionTile(
      title: const Text('Flash Preferences'),
      children: [
        CustomSwitchListTile(
          title: 'Photo Flash',
          initialValue: flashOnPhotos,
          onChanged: (bool value) {
            setState(() {
              flashOnPhotos = value;
              prefs.setBool(flashOnPhotosPref, value);
            });
          },
        ),
        CustomSwitchListTile(
          title: 'Grid Flash',
          initialValue: flashOnGrids,
          onChanged: (bool value) {
            setState(() {
              flashOnGrids = value;
              prefs.setBool(flashOnGridsPref, value);
            });
          },
        ),
        CustomSwitchListTile(
          title: 'Barcode Flash',
          initialValue: flashOnBarcodes,
          onChanged: (bool value) {
            setState(() {
              flashOnBarcodes = value;
              prefs.setBool(flashOnBarcodesPref, value);
            });
          },
        ),
        CustomSwitchListTile(
          title: 'Navigation Flash',
          initialValue: flashOnNavigation,
          onChanged: (bool value) {
            setState(() {
              flashOnNavigation = value;
              prefs.setBool(flashOnNavigationPref, value);
            });
          },
        ),
      ],
    );
  }

  Future<double?> _defaultBarcodeSizeDialog(BuildContext context) {
    return showDialog<double?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Default QR Code Size'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'This is the default value used by Tswiri for unkown QR Codes.',
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Text('x'),
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Text('mm'),
                ],
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: <Widget>[
            TextButton(
              // style: TextButton.styleFrom(
              //   textStyle: Theme.of(context).textTheme.labelLarge,
              // ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              // style: TextButton.styleFrom(
              //   textStyle: Theme.of(context).textTheme.labelLarge,
              // ),
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop(
                  double.tryParse(_controller.text),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
