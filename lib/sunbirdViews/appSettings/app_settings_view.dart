import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/appSettings/app_settings.dart';
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
  late bool vibration;
  late double getDefaultBarcodeDiagonalLength;

  final TextEditingController barcodeSizeController = TextEditingController();
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
              barcodeSizeController.text =
                  snapshot.data!.defaultBarcodeDiagonalLength.toString();
              return Column(
                children: [
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
                            Row(
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
                                  value: snapshot.data!.cameraPreset,
                                  items: cameraResolutionPresets,
                                ),
                              ],
                            ),
                            const Divider(),

                            //Default barcode size
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Default Barcode Size: '),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.38,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onFieldSubmitted: (value) {
                                      setDefaultBarcodeDiagonalLength(
                                          double.parse(value));
                                      barcodeSizeController.text =
                                          double.parse(value).toString();
                                    },
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    controller: barcodeSizeController,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Divider(),

                            //HapticFeedBack.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Vibration: '),
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: snapshot.data!.hapticFeedback,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        vibration = value!;
                                        setHapticFeedback(vibration);
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
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
    bool hapticFeedback = prefs.getBool(hapticFeedBackPreference) ?? true;
    double defaultBarcodeDiagonalLength =
        prefs.getDouble(defaultBarcodeDiagonalLengthPreference) ?? 100;

    Settings appSettings = Settings(
        cameraPreset: cameraPreset,
        hapticFeedback: hapticFeedback,
        defaultBarcodeDiagonalLength: defaultBarcodeDiagonalLength);

    return appSettings;
  }
}
