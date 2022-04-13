import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/app_settings.dart';
import 'package:flutter_google_ml_kit/sunbird_views/app_settings/google_drive_backup.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings_functions.dart';
import '../../objects/app_settings_class.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late String selectedCameraPreset;
  // late bool vibration;
  // late double getDefaultBarcodeDiagonalLength;
  // late bool googleImageLabeling;
  // late bool googleVisionProducts;
  // late bool inceptionV4;

  @override
  void initState() {
    googleImageLabelingConfidenceThresholdController.text =
        googleImageLabelingConfidenceThreshold.toString();
    // googleVisionProductsConfidenceThresholdController.text =
    //     googleVisionProductsConfidenceThreshold.toString();
    inceptionV4PreferenceConfidenceThresholdController.text =
        inceptionV4PreferenceConfidenceThreshold.toString();

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
                            models(snapshot.data!),
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
    googleImageLabelingConfidenceThreshold =
        prefs.getInt(googleImageLabelingConfidenceThresholdPreference) ?? 50;

    // bool googleVisionProducts =
    //     prefs.getBool(googleVisionProductsPreference) ?? true;
    // googleVisionProductsConfidenceThreshold =
    //     prefs.getInt(googleVisionProductsConfidenceThresholdPreference) ?? 50;

    bool inceptionV4 = prefs.getBool(inceptionV4Preference) ?? true;
    inceptionV4PreferenceConfidenceThreshold =
        prefs.getInt(inceptionV4PreferenceConfidenceThresholdPreference) ?? 50;

    Settings appSettings = Settings(
      cameraPreset: cameraPreset,
      hapticFeedback: hapticFeedback,
      defaultBarcodeSize: defaultBarcodeSize,
      googleImageLabeling: googleImageLabeling,
      googleImageLabelingConfidenceThreshold:
          googleImageLabelingConfidenceThreshold,
      // googleVisionProducts: googleVisionProducts,
      // googleVisionProductsConfidenceThreshold:
      //     googleVisionProductsConfidenceThreshold,
      inceptionV4: inceptionV4,
      inceptionV4PreferenceConfidenceThreshold:
          inceptionV4PreferenceConfidenceThreshold,
    );

    if (barcodeSizeController.text.isEmpty) {
      barcodeSizeController.text = defaultBarcodeSize.toString();
    }

    return appSettings;
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

  Widget models(Settings snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Labeling: ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        googleVisionImageLabelingSettings(snapshot),
        //googleVisionProductsSettings(snapshot),
        inceptionV4Settings(snapshot),
      ],
    );
  }

  Widget googleVisionImageLabelingSettings(Settings snapshot) {
    return OrangeOutlineContainer(
      margin: 2.5,
      padding: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                value: snapshot.googleImageLabeling,
                onChanged: (bool? value) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    googleImageLabeling = value!;
                    prefs.setBool(
                        googleImageLabelingPreference, googleImageLabeling);
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
                    googleImageLabelingConfidenceThreshold = int.parse(value);
                    prefs.setInt(
                        googleImageLabelingConfidenceThresholdPreference,
                        googleImageLabelingConfidenceThreshold);
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
    );
  }

  // Widget googleVisionProductsSettings(Settings snapshot) {
  //   return OrangeOutlineContainer(
  //     margin: 2.5,
  //     padding: 5,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Google Vision Products: ',
  //               style: Theme.of(context).textTheme.bodyMedium,
  //             ),
  //             Checkbox(
  //               checkColor: Colors.white,
  //               fillColor: MaterialStateProperty.resolveWith(getColor),
  //               value: snapshot.googleVisionProducts,
  //               onChanged: (bool? value) async {
  //                 final prefs = await SharedPreferences.getInstance();
  //                 setState(() {
  //                   googleVisionProducts = value!;
  //                   prefs.setBool(
  //                       googleVisionProductsPreference, googleVisionProducts);
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'Google Vision Products Confidnce: ',
  //               style: Theme.of(context).textTheme.bodyMedium,
  //             ),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.15,
  //               child: TextFormField(
  //                 controller: googleVisionProductsConfidenceThresholdController,
  //                 onFieldSubmitted: (value) async {
  //                   final prefs = await SharedPreferences.getInstance();
  //                   googleVisionProductsConfidenceThreshold = int.parse(value);
  //                   prefs.setInt(
  //                       googleVisionProductsConfidenceThresholdPreference,
  //                       googleVisionProductsConfidenceThreshold);
  //                 },
  //                 textAlign: TextAlign.center,
  //                 keyboardType: TextInputType.number,
  //                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //                 decoration: const InputDecoration(
  //                   prefix: Text('0.'),
  //                   border: UnderlineInputBorder(),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget inceptionV4Settings(Settings snapshot) {
    return OrangeOutlineContainer(
      margin: 2.5,
      padding: 5,
      child: Column(
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
                    inceptionV4PreferenceConfidenceThreshold = int.parse(value);
                    prefs.setInt(
                        inceptionV4PreferenceConfidenceThresholdPreference,
                        inceptionV4PreferenceConfidenceThreshold);
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
    );
  }

  Widget googleAccount() {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GoogleDriveBackup()),
        );
      }),
      child: OrangeOutlineContainer(
          margin: 2.5,
          padding: 10,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Manage Google Account',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          )),
    );
  }
}
