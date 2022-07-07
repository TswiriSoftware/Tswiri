import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/global_values/all_globals.dart';
import 'package:flutter_google_ml_kit/firebase_options.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/theme.dart';
import 'package:flutter_google_ml_kit/views/scan/scan_view.dart';
import 'package:flutter_google_ml_kit/views/search/search_view_v2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'views/main_views.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Set screen orientation.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Initialize Firebase.
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    Firebase.app();
  }

  //debugRepaintRainbowEnabled = true;

  runApp(
    const MaterialApp(
      title: 'Sunbird',
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );

  // Get camera's
  cameras = await availableCameras();

  //Request Permissions.
  var storageStatus = await Permission.storage.status;
  if (storageStatus.isDenied) {
    Permission.storage.request();
  }

  // Get App Settings. From Shared Prefernces.
  getStoredAppSettings();

  //Get support directory
  isarDirectory = await getApplicationSupportDirectory();
  //Open Isar.
  isarDatabase = openIsar();

  createBasicContainerTypes();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

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
                  builder: (context) => const SettingsView(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
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
              'Search',
              SearchViewV2(),
              Icons.search,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Containers',
              ContainersView(),
              Icons.add_box_outlined,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Tags',
              TagManagerView(),
              Icons.tag,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Gallery',
              GalleryView(),
              Icons.photo,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Barcode Generator',
              BarcodeGeneratorView(),
              Icons.qr_code_2_rounded,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Container Types',
              ContainerTypeView(),
              Icons.code,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Barcodes',
              BarcodesView(),
              Icons.list,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),
            CustomCard(
              'Calibration',
              CalibrationToolsView(),
              Icons.camera,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),

            CustomCard(
              'Grid Scan',
              ScanView(),
              Icons.scanner,
              featureCompleted: true,
              tileColor: sunbirdOrange,
            ),

            //Extras for testing
            // CustomCard(
            //   'Tree Visualizer',
            //   GridVisualizerView(),
            //   Icons.grid_4x4_sharp,
            //   featureCompleted: true,
            //   tileColor: sunbirdOrange,
            // ),
            // CustomCard(
            //   'Integration Test',
            //   MainTest(),
            //   Icons.integration_instructions,
            //   featureCompleted: true,
            //   tileColor: sunbirdOrange,
            // ),
          ],
        ),
      ),
    );
  }
}
