import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri_theme/widgets/list_tiles/custom_switch_list_tile.dart';

class ImageLabelingSettingsView extends StatefulWidget {
  const ImageLabelingSettingsView({super.key});

  @override
  State<ImageLabelingSettingsView> createState() =>
      _ImageLabelingSettingsViewState();
}

class _ImageLabelingSettingsViewState extends State<ImageLabelingSettingsView> {
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
      title: const Text('Image Labeling'),
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSwitchListTile(
            title: 'Image Labeling',
            initialValue: imageLabeling,
            onChanged: (value) {
              setState(() {
                imageLabeling = value;
                prefs.setBool(imageLabelingPref, value);
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
                    imageLabelingConfidence = newValue;
                    prefs.setDouble(imageLabelingConfidencePref, newValue);
                    _controller.text = imageLabelingConfidence.toString();
                  });
                }
              },
              child: const Text('Change'),
            ),
            subtitle:
                Text('${_controller.text} ~ ${imageLabelingConfidence * 100}%'),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = imageLabelingConfidence.toString();
    });
  }
}

Future<double?> confidenceThresholdDialog(
    BuildContext context, TextEditingController controller) {
  return showDialog<double?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confidence Threshold'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "The minimum likelihood that the output of a Machine Learning model is correct and will satisfy a user's request.",
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(contentPadding: EdgeInsets.zero),
                  ),
                ),
              ],
            ),
            const Text(
              "(0.0 - 1.0)",
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(),
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop(
                double.tryParse(controller.text),
              );
            },
          ),
        ],
      );
    },
  );
}
