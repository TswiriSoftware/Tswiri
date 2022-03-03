import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/appSettings/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings_functions.dart';
import 'class_app_settings.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late String selectedCameraPreset;
  late bool vibration;

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
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Future<Settings> getCurrentAppSettingsInView() async {
    final prefs = await SharedPreferences.getInstance();
    String cameraPreset = prefs.getString('cameraResolutionPreset') ?? 'high';
    await setCameraResolution(cameraPreset);
    bool hapticFeedback = prefs.getBool('hapticFeedBack') ?? true;

    Settings appSettings =
        Settings(cameraPreset: cameraPreset, hapticFeedback: hapticFeedback);
    return appSettings;
  }
}
