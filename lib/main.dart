import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/globalValues/isar_dir.dart';
import 'package:flutter_google_ml_kit/globalValues/routes.dart';
import 'package:flutter_google_ml_kit/isar/container_type.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeNavigation/barcode_selection_view.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/containerSystem/all_containers_view.dart';
import 'package:flutter_google_ml_kit/widgets/custom_card_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'databaseAdapters/allBarcodes/barcode_data_entry.dart';
import 'databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';
import 'databaseAdapters/scanningAdapter/real_barcode_position_entry.dart';
import 'databaseAdapters/typeAdapters/type_offset_adapter.dart';
import 'isar/container_type.dart';
import 'sunbirdViews/appSettings/app_settings_functions.dart';
import 'sunbirdViews/appSettings/app_settings_view.dart';
import 'sunbirdViews/containerSystem/functions/isar_functions.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  //await Firebase.initializeApp();
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

  ///Temporary solution.
  createBoxTypes();

  Hive.registerAdapter(RealBarcodePositionEntryAdapter()); //0
  Hive.registerAdapter(DistanceFromCameraLookupEntryAdapter()); //1
  //Hive.registerAdapter(BarcodeTagEntryAdapter()); //3
  //Hive.registerAdapter(TagEntryAdapter()); //4
  Hive.registerAdapter(TypeOffsetAdapter()); //5
  Hive.registerAdapter(BarcodeDataEntryAdapter()); //6
  //Hive.registerAdapter(BarcodePhotosEntryAdapter()); //7
  //Hive.registerAdapter(ShelfEntryAdapter()); //8
  //Hive.registerAdapter(ContainerTypeAdapter()); //9
  //Hive.registerAdapter(ContainerEntryAdapterOLD()); //2
  //Hive.registerAdapter(Vector3EntryAdapter()); //11
  //Hive.registerAdapter(PhotoEntryAdapter()); //12
  //Hive.registerAdapter(BarcodeEntryAdapter()); //13
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.black, backgroundColor: Colors.deepOrange),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.deepOrange),
        textTheme: const TextTheme(
            labelLarge: TextStyle(fontSize: 18),
            labelMedium: TextStyle(fontSize: 15),
            labelSmall: TextStyle(fontSize: 12),
            titleMedium: TextStyle(fontSize: 18),
            titleSmall: TextStyle(fontSize: 16)),
      ),

      debugShowCheckedModeBanner: false,

      //home: const Home(), //OLD HOME VIEW
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
        title: const Text(
          'Sunbird',
          style: TextStyle(fontSize: 25),
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
              'Containers',
              ContainersView(),
              Icons.add_box_outlined,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
            CustomCard(
              'Find a box',
              BarcodeSelectionView(),
              Icons.navigation,
              featureCompleted: true,
              tileColor: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}

///Temporary.
void createBoxTypes() {
  Isar database = openIsar();

  database.writeTxnSync((database) {
    database.containerTypes.putSync(
        ContainerType()
          ..id = 1
          ..containerType = 'area'
          ..canContain = ['shelf', 'box', 'drawer']
          ..structured = true
          ..containerColor = poppyOrange.value.toString(),
        replaceOnConflict: true);

    database.containerTypes.putSync(
        ContainerType()
          ..id = 2
          ..containerType = 'shelf'
          ..canContain = ['box', 'drawer']
          ..structured = true
          ..containerColor = Colors.blue.value.toString(),
        replaceOnConflict: true);

    database.containerTypes.putSync(
        ContainerType()
          ..id = 3
          ..containerType = 'drawer'
          ..canContain = ['box', 'shelf']
          ..structured = true
          ..containerColor = springGreen.value.toString(),
        replaceOnConflict: true);

    database.containerTypes.putSync(
        ContainerType()
          ..id = 4
          ..containerType = 'box'
          ..canContain = ['box', 'shelf']
          ..structured = true
          ..containerColor = petalOrange.value.toString(),
        replaceOnConflict: true);
  });

  database.close();
}
