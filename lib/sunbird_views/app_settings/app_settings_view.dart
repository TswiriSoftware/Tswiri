import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/google_drive_backup.dart';
import 'package:flutter_google_ml_kit/sunbird_views/widgets/cards/default_card/defualt_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings_functions.dart';
import '../../objects/reworked/app_settings_class.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late String selectedCameraPreset;

  @override
  void initState() {
    googleImageLabelingConfidenceThresholdController.text =
        googleVisionConfidenceThreshold.toString();
    inceptionV4PreferenceConfidenceThresholdController.text =
        inceptionV4ConfidenceThreshold.toString();

    super.initState();
  }

  final TextEditingController barcodeSizeController = TextEditingController();
  final TextEditingController googleImageLabelingConfidenceThresholdController =
      TextEditingController();
  final TextEditingController
      googleVisionProductsConfidenceThresholdController =
      TextEditingController();
  final TextEditingController
      inceptionV4PreferenceConfidenceThresholdController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Settings>(
          future: getCurrentAppSettingsInView(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //Camera resolution
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60, width: 2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            //Camera Resolution.
                            cameraResolution(snapshot.data!),
                            const Divider(),
                            //Default barcode size
                            defaultBarcodeSize(snapshot.data!),
                            const Divider(),
                            //HapticFeedBack.
                            hapticFeedback(snapshot.data!),
                            const Divider(),
                            //Tflite Models
                            mlKitModels(snapshot.data!),
                            const Divider(),
                            //Account
                            googleAccount(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  Widget cameraResolution(Settings snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Camera Resolution: '),
        DropdownButton<String>(
          onChanged: (String? value) {
            setState(() {
              selectedCameraPreset = value!;
              setCameraResolution(selectedCameraPreset);
            });
          },
          value: snapshot.cameraPreset,
          items: cameraResolutionPresets,
        ),
      ],
    );
  }

  Widget defaultBarcodeSize(Settings snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Default Barcode Size: '),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          child: TextFormField(
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                log(value);
                setDefaultBarcodeDiagonalLength(double.parse(value));
                setDefaultBarcodeSize(double.parse(value));
                barcodeSizeController.text = double.parse(value).toString();

                //log(defaultBarcodeDiagonalLength.toString());
              }
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                setDefaultBarcodeDiagonalLength(double.parse(value));
                setDefaultBarcodeSize(double.parse(value));
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: barcodeSizeController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Text(
          'mm',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'x',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          child: TextFormField(
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                setDefaultBarcodeDiagonalLength(double.parse(value));
                setDefaultBarcodeSize(double.parse(value));
                barcodeSizeController.text = double.parse(value).toString();
              }
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                setDefaultBarcodeDiagonalLength(double.parse(value));
                setDefaultBarcodeSize(double.parse(value));
              }
            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: barcodeSizeController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        Text(
          'mm',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget hapticFeedback(Settings snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Vibration: '),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: snapshot.hapticFeedback,
          onChanged: (bool? value) {
            setState(() {
              hapticFeedBack = value!;
              setHapticFeedback(hapticFeedBack);
            });
          },
        ),
      ],
    );
  }

  Widget mlKitModels(Settings snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Image Labeling: ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        //googleVisionSettings(snapshot),
        googleVisionSettings(snapshot),
        inceptionV4Settings(snapshot),
      ],
    );
  }

  Widget googleVisionSettings(Settings snapshot) {
    return defaultCard(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Google Vision: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: snapshot.googleVision,
                onChanged: (bool? value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    googleVision = value!;
                    prefs.setBool(googleImageLabelingPreference, googleVision);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Google Vision Confidnce: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: TextFormField(
                  controller: googleImageLabelingConfidenceThresholdController,
                  onFieldSubmitted: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    googleVisionConfidenceThreshold = int.parse(value);
                    prefs.setInt(
                        googleImageLabelingConfidenceThresholdPreference,
                        googleVisionConfidenceThreshold);
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    prefix: Text('0.'),
                    border: UnderlineInputBorder(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      borderColor: sunbirdOrange,
      color: Colors.black38,
    );
  }

  Widget inceptionV4Settings(Settings snapshot) {
    return defaultCard(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'InceptionV4 ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: snapshot.inceptionV4,
                onChanged: (bool? value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    inceptionV4 = value!;
                    prefs.setBool(inceptionV4Preference, inceptionV4);
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Google Vision Products Confidnce: ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                child: TextFormField(
                  controller:
                      inceptionV4PreferenceConfidenceThresholdController,
                  onFieldSubmitted: (value) async {
                    final prefs = await SharedPreferences.getInstance();
                    inceptionV4ConfidenceThreshold = int.parse(value);
                    prefs.setInt(
                        inceptionV4PreferenceConfidenceThresholdPreference,
                        inceptionV4ConfidenceThreshold);
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    prefix: Text('0.'),
                    border: UnderlineInputBorder(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      borderColor: sunbirdOrange,
      color: Colors.black38,
    );
  }

  Widget googleAccount() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GoogleDriveBackup()),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Manage Google Account',
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  Future<Settings> getCurrentAppSettingsInView() async {
    final prefs = await SharedPreferences.getInstance();
    String cameraPreset =
        prefs.getString(cameraResolutionPresetPreference) ?? 'high';

    await setCameraResolution(cameraPreset);

    double defaultBarcodeSize =
        prefs.getDouble(defaultBarcodeSizePeference) ?? 100;

    bool hapticFeedback = prefs.getBool(hapticFeedBackPreference) ?? true;

    bool googleImageLabeling =
        prefs.getBool(googleImageLabelingPreference) ?? true;
    googleVisionConfidenceThreshold =
        prefs.getInt(googleImageLabelingConfidenceThresholdPreference) ?? 50;

    bool inceptionV4 = prefs.getBool(inceptionV4Preference) ?? true;
    inceptionV4ConfidenceThreshold =
        prefs.getInt(inceptionV4PreferenceConfidenceThresholdPreference) ?? 50;

    Settings appSettings = Settings(
      cameraPreset: cameraPreset,
      hapticFeedback: hapticFeedback,
      defaultBarcodeSize: defaultBarcodeSize,
      googleVision: googleImageLabeling,
      googleImageLabelingConfidenceThreshold: googleVisionConfidenceThreshold,
      inceptionV4: inceptionV4,
      inceptionV4PreferenceConfidenceThreshold: inceptionV4ConfidenceThreshold,
    );

    if (barcodeSizeController.text.isEmpty) {
      barcodeSizeController.text = defaultBarcodeSize.toString();
    }

    return appSettings;
  }
}
