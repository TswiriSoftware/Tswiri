import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/globalValues/isar_dir.dart';
import 'package:flutter_google_ml_kit/globalValues/routes.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_generator/barcode_generator_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_manager/barcode_manager_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/camera_calibration/camera_calibration_tools_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_manager/container_manager.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tag_manager/tag_manager_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/tag_manager/tag_manager_view.dart';
import 'package:flutter_google_ml_kit/widgets/card_widgets/custom_card_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'databaseAdapters/allBarcodes/barcode_data_entry.dart';
import 'databaseAdapters/barcodePhotoAdapter/barcode_photo_entry.dart';
import 'databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';
import 'databaseAdapters/scanningAdapter/real_barcode_position_entry.dart';
import 'databaseAdapters/shelfAdapter/shelf_entry.dart';
import 'databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import 'databaseAdapters/tagAdapters/tag_entry.dart';
import 'databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'sunbird_views/app_settings/app_settings_functions.dart';
import 'sunbird_views/app_settings/app_settings_view.dart';
import 'sunbird_views/container_system_debug/container_views/containers_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MaterialApp(
    title: 'Sunbird',
    initialRoute: '/',
    routes: allRoutes,
    debugShowCheckedModeBanner: false,
  ));

  //Request Permissions.
  var status = await Permission.storage.status;
  if (status.isDenied) {
    Permission.storage.request();
  }
  //Get App Settings.
  getCurrentAppSettings();

  //Initiate Hive.
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);

  isarDirectory =
      await getApplicationSupportDirectory(); // path_provider package

  isarDatabase = openIsar();

  Hive.registerAdapter(RealBarcodePositionEntryAdapter()); //0
  Hive.registerAdapter(DistanceFromCameraLookupEntryAdapter()); //1
  Hive.registerAdapter(BarcodeTagEntryAdapter()); //3
  Hive.registerAdapter(TagEntryAdapter()); //4
  Hive.registerAdapter(TypeOffsetAdapter()); //5
  Hive.registerAdapter(BarcodeDataEntryAdapter()); //6
  Hive.registerAdapter(BarcodePhotosEntryAdapter()); //7
  Hive.registerAdapter(ShelfEntryAdapter()); //8
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black12,
        primaryColor: Colors.deepOrange[500],
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange, brightness: Brightness.dark),
        appBarTheme: AppBarTheme(
          //foregroundColor: Colors.deepOrange[900],
          backgroundColor: Colors.deepOrange[500],
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.deepOrangeAccent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepOrange[500],
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(Colors.deepOrange),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
          backgroundColor: Colors.deepOrange,
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.deepOrange),
        textTheme: const TextTheme(
            labelLarge: TextStyle(fontSize: 20),
            labelMedium: TextStyle(fontSize: 16),
            labelSmall: TextStyle(fontSize: 14),
            titleLarge: TextStyle(fontSize: 25),
            titleMedium: TextStyle(fontSize: 18),
            titleSmall: TextStyle(fontSize: 16)),
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
//TODO:@Spodeopieter implement navigator 2.0

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsView()));
              },
              icon: const Icon(Icons.settings))
        ],
        title: Text(
          'Sunbird',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 8,
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          children: const [
            CustomCard(
              'Container Manager',
              ContainerManagerView(),
              Icons.add_box_outlined,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            CustomCard(
              'Barcode Manager',
              BarcodeManagerView(),
              Icons.list,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            CustomCard(
              'Tag Manager',
              TagManagerView(),
              Icons.tag,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            CustomCard(
              'Generate Barcodes',
              BarcodeGeneratorView(),
              Icons.qr_code_2_rounded,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            CustomCard(
              'Camera Calibraion',
              CameraCalibrationToolsView(),
              Icons.camera,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            CustomCard(
              'Containers_debug',
              ContainersView(),
              Icons.add_box_outlined,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}
