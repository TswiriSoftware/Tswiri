import 'package:flutter/material.dart';
import 'package:tswiri/settings/advanced_settings/image_labeling_settings_view.dart';
import 'package:tswiri/settings/advanced_settings/object_labeling_settings_view.dart';
import 'package:tswiri/settings/advanced_settings/text_detection_settings_view.dart';
import 'package:tswiri_theme/transitions/left_to_right_transition.dart';

class AdvancedSettingsView extends StatefulWidget {
  const AdvancedSettingsView({super.key});

  @override
  State<AdvancedSettingsView> createState() => _AdvancedSettingsViewState();
}

class _AdvancedSettingsViewState extends State<AdvancedSettingsView> {
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
        'Advanced Settings',
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _imageLabeling(),
          const Divider(),
          _objectDetection(),
          const Divider(),
          _textDetection(),
        ],
      ),
    );
  }

  Widget _imageLabeling() {
    return ListTile(
      title: const Text(
        'Image Labeling',
      ),
      leading: const Icon(Icons.image_rounded),
      onTap: () {
        Navigator.of(context).push(
          leftToRightTransition(const ImageLabelingSettingsView()),
        );
      },
    );
  }

  Widget _objectDetection() {
    return ListTile(
      title: const Text(
        'Object detection',
      ),
      leading: const Icon(Icons.data_object_rounded),
      onTap: () {
        Navigator.of(context).push(
          leftToRightTransition(const ObjectLabelingSettingsView()),
        );
      },
    );
  }

  Widget _textDetection() {
    return ListTile(
      title: const Text(
        'Text detection',
      ),
      leading: const Icon(Icons.format_size_rounded),
      onTap: () {
        Navigator.of(context).push(
          leftToRightTransition(const TextDetectionSettingsView()),
        );
      },
    );
  }
}
