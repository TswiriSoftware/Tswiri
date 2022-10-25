import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri/settings/advanced_settings/image_labeling_settings_view.dart';
import 'package:tswiri_theme/widgets/list_tiles/custom_switch_list_tile.dart';

class ObjectLabelingSettingsView extends StatefulWidget {
  const ObjectLabelingSettingsView({super.key});

  @override
  State<ObjectLabelingSettingsView> createState() =>
      _ObjectLabelingSettingsViewState();
}

class _ObjectLabelingSettingsViewState
    extends State<ObjectLabelingSettingsView> {
  late SharedPreferences prefs;
  final TextEditingController _controller = TextEditingController();
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
      title: const Text('Object Detection'),
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSwitchListTile(
            title: 'Object Detection',
            initialValue: objectDetection,
            onChanged: (value) {
              setState(() {
                objectDetection = value;
                prefs.setBool(objectDetectionPref, value);
              });
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Confidence Threshold'),
            trailing: OutlinedButton(
              onPressed: () async {
                double? newValue =
                    await confidenceThresholdDialog(context, _controller);
                if (newValue != null && newValue >= 0.0 && newValue <= 1.0) {
                  setState(() {
                    objectDetectionConfidence = newValue;
                    prefs.setDouble(objectDetectionConfidencePref, newValue);
                    _controller.text = objectDetectionConfidence.toString();
                  });
                }
              },
              child: const Text('Change'),
            ),
            subtitle: Text(
                '${_controller.text} ~ ${objectDetectionConfidence * 100}%'),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = objectDetectionConfidence.toString();
    });
  }
}
