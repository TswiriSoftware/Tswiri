import 'dart:developer';

import 'package:tswiri/views/settings/backup/backup_options_view.dart';
import 'package:tswiri/views/settings/spaces/spaces_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri_database/models/settings/global_settings.dart';
import 'package:tswiri_widgets/colors/colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SharedPreferences prefs;

  final TextEditingController _barcodeSizeController = TextEditingController();
  final TextEditingController _imageLabelingConfidence =
      TextEditingController();
  final TextEditingController _objectDetectionConfidence =
      TextEditingController();

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

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 150),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _manageBackup(),
          _vibration(),
          _colorMode(),
          _defaultQRCodeSize(),
          _flashSettings(),
          _advancedSettings(),
        ],
      ),
    );
  }

  Widget _advancedSettings() {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Advanced',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          _spaces(),
          _imageLabeling(),
          _objectDetection(),
          _textDetection(),
        ],
      ),
    );
  }

  Widget _flashSettings() {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Flash Settings',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          _photoFlash(),
          _gridFlash(),
          _barcodeFlash(),
          _navigationFlash(),
        ],
      ),
    );
  }

  Widget _photoFlash() {
    return Card(
      color: background[300],
      child: ListTile(
        title: Text(
          'Photo Flash',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '(default setting)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: flashOnPhotos
            ? TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnPhotosPref, false);
                  setState(() {
                    flashOnPhotos = false;
                  });
                },
                child: const Text(
                  'ON',
                ),
              )
            : TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnPhotosPref, true);
                  setState(() {
                    flashOnPhotos = true;
                  });
                },
                child: const Text('OFF'),
              ),
      ),
    );
  }

  Widget _gridFlash() {
    return Card(
      color: background[300],
      child: ListTile(
        title: Text(
          'Grid Flash',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '(default setting)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: flashOnGrids
            ? TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnGridsPref, false);
                  setState(() {
                    flashOnGrids = false;
                  });
                },
                child: const Text(
                  'ON',
                ),
              )
            : TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnGridsPref, true);
                  setState(() {
                    flashOnGrids = true;
                  });
                },
                child: const Text('OFF'),
              ),
      ),
    );
  }

  Widget _barcodeFlash() {
    return Card(
      color: background[300],
      child: ListTile(
        title: Text(
          'Barcode Flash',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '(default setting)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: flashOnBarcodes
            ? TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnBarcodesPref, false);
                  setState(() {
                    flashOnBarcodes = false;
                  });
                },
                child: const Text(
                  'ON',
                ),
              )
            : TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnBarcodesPref, true);
                  setState(() {
                    flashOnBarcodes = true;
                  });
                },
                child: const Text('OFF'),
              ),
      ),
    );
  }

  Widget _navigationFlash() {
    return Card(
      color: background[300],
      child: ListTile(
        title: Text(
          'Navigation Flash',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          '(default setting)',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: flashOnNavigation
            ? TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnNavigationPref, false);
                  setState(() {
                    flashOnNavigation = false;
                  });
                },
                child: const Text(
                  'ON',
                ),
              )
            : TextButton(
                onPressed: () async {
                  prefs.setBool(flashOnNavigationPref, true);
                  setState(() {
                    flashOnNavigation = true;
                  });
                },
                child: const Text('OFF'),
              ),
      ),
    );
  }

  Widget _defaultQRCodeSize() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Text(
              'QRCode Size:',
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
                      _barcodeSizeController.text =
                          defaultBarcodeSize.toString();
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
      ),
    );
  }

  Widget _vibration() {
    return Card(
      child: ListTile(
        title: Text(
          'Vibration',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Checkbox(
          value: vibrate,
          onChanged: (value) {
            setState(() {
              vibrate = value ?? true;
              prefs.setBool(vibratePref, value ?? true);
            });
          },
        ),
      ),
    );
  }

  Widget _colorMode() {
    return Card(
      child: ListTile(
        title: Text(
          'Color Mode',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Checkbox(
          value: colorModeEnabled,
          onChanged: (value) {
            setState(() {
              colorModeEnabled = value ?? false;
              prefs.setBool(colorModeEnabledPref, value ?? false);
            });
            // log(colorModeEnabled.toString());
          },
        ),
      ),
    );
  }

  Widget _imageLabeling() {
    return Card(
      color: background[300],
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Image Labeling',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Checkbox(
              value: imageLabeling,
              onChanged: (value) {
                setState(() {
                  imageLabeling = value ?? true;
                  prefs.setBool(imageLabelingPref, value ?? true);
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Confidence Threshold: ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: TextField(
                controller: _imageLabelingConfidence,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  double enteredValue =
                      double.tryParse(value) ?? imageLabelingConfidence;
                  if (enteredValue > 0 && enteredValue < 1) {
                    setState(() {
                      imageLabelingConfidence = enteredValue;
                      prefs.setDouble(
                          imageLabelingConfidencePref, enteredValue);
                      _imageLabelingConfidence.text =
                          imageLabelingConfidence.toString();
                    });
                  } else {
                    imageLabelingConfidence =
                        prefs.getDouble(imageLabelingConfidencePref) ??
                            imageLabelingConfidence;
                    _imageLabelingConfidence.text =
                        imageLabelingConfidence.toString();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _objectDetection() {
    return Card(
      color: background[300],
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Object Detection',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Checkbox(
              value: objectDetection,
              onChanged: (value) {
                setState(() {
                  objectDetection = value ?? true;
                  prefs.setBool(objectDetectionPref, value ?? true);
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              'Confidence Threshold: ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: TextField(
                controller: _objectDetectionConfidence,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(),
                onSubmitted: (value) {
                  double enteredValue =
                      double.tryParse(value) ?? objectDetectionConfidence;
                  if (enteredValue > 0 && enteredValue < 1) {
                    setState(() {
                      objectDetectionConfidence = enteredValue;
                      prefs.setDouble(
                          objectDetectionConfidencePref, enteredValue);
                      _objectDetectionConfidence.text =
                          objectDetectionConfidence.toString();
                    });
                  } else {
                    objectDetectionConfidence =
                        prefs.getDouble(objectDetectionConfidencePref) ??
                            objectDetectionConfidence;
                    _objectDetectionConfidence.text =
                        objectDetectionConfidence.toString();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textDetection() {
    return Card(
      color: background[300],
      child: ListTile(
        title: Text(
          'Text Detection',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Checkbox(
          value: textDetection,
          onChanged: (value) {
            setState(() {
              textDetection = value ?? true;
              prefs.setBool(textDetectionPref, value ?? true);
            });
          },
        ),
      ),
    );
  }

  Widget _manageBackup() {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BackupOptionsView(),
            ),
          );
        },
        child: ListTile(
          title: Text(
            'Manage Backup',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: const Icon(
            Icons.backup,
            color: tswiriOrange,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _spaces() {
    return Card(
      color: background[300],
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SpacesView(),
            ),
          );
        },
        child: ListTile(
          title: Text(
            'Spaces (WIP)',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: const Icon(
            Icons.space_dashboard_sharp,
            color: tswiriOrange,
            size: 30,
          ),
        ),
      ),
    );
  }

  void _loadSettings() async {
    loadAppSettings();
    prefs = await SharedPreferences.getInstance();
    _barcodeSizeController.text = defaultBarcodeSize.toString();
    _objectDetectionConfidence.text = objectDetectionConfidence.toString();
    _imageLabelingConfidence.text = imageLabelingConfidence.toString();
  }
}
