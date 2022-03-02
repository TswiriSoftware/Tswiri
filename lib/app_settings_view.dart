import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late String selectedCameraPreset;

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
      body: FutureBuilder<String>(
          future: getCurrentAppSettingsInView(),
          builder: (context, snapshot) {
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
                      child: Row(
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
                            value: snapshot.data,
                            items: cameraResolutionPresets,
                          )
                        ],
                      ),
                    )),
              ],
            );
          }),
    );
  }

  Future<String> getCurrentAppSettingsInView() async {
    final prefs = await SharedPreferences.getInstance();
    String cameraPreset = prefs.getString('cameraResolutionPreset') ?? 'high';
    switch (cameraPreset) {
      case 'high':
        cameraResolution = ResolutionPreset.high;
        break;
      case 'medium':
        cameraResolution = ResolutionPreset.medium;
        break;
      case 'low':
        cameraResolution = ResolutionPreset.low;
        break;
      default:
        cameraResolution = ResolutionPreset.high;
    }
    return cameraPreset;
  }
}

Future getCurrentAppSettings() async {
  final prefs = await SharedPreferences.getInstance();
  String cameraPreset = prefs.getString('cameraResolutionPreset') ?? 'high';
  switch (cameraPreset) {
    case 'high':
      cameraResolution = ResolutionPreset.high;
      break;
    case 'medium':
      cameraResolution = ResolutionPreset.medium;
      break;
    case 'low':
      cameraResolution = ResolutionPreset.low;
      break;
    default:
      cameraResolution = ResolutionPreset.high;
  }
}

Future setCameraResolution(String selectedCameraResolution) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('cameraResolutionPreset', selectedCameraResolution);
  switch (selectedCameraResolution) {
    case 'high':
      cameraResolution = ResolutionPreset.high;
      break;
    case 'medium':
      cameraResolution = ResolutionPreset.medium;
      break;
    case 'low':
      cameraResolution = ResolutionPreset.low;
      break;
    default:
      cameraResolution = ResolutionPreset.high;
  }
}
