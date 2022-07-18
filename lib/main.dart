import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunbird_v2/isar/isar_database.dart';
import 'package:sunbird_v2/scripts/app_settings.dart';
import 'package:sunbird_v2/views/areas/area_view.dart';
import 'package:sunbird_v2/views/search/search_view.dart';
import 'package:sunbird_v2/views/settings/settings_view.dart';
import 'package:sunbird_v2/views/utilities/utilities_view.dart';
import 'globals/globals_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Force portraitUp.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //TODO: Implement Firebase.

  //Get Camera descriptions.
  cameras = await availableCameras();

  //Request Permissions.
  var storageStatus = await Permission.storage.status;
  if (storageStatus.isDenied) {
    Permission.storage.request();
  }

  //Initiate Isar
  isarDirectory = await getApplicationSupportDirectory();
  isar = initiateIsar(inspector: false);
  createBasicContainerTypes();

  //Load Settigns.
  loadAppSettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabBarView(),
      bottomSheet: _bottomSheet(),
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      controller: _tabController,
      children: const [
        AreaView(),
        SearchView(),
        UtilitiesView(),
        SettingsView(),
      ],
    );
  }

  Widget _bottomSheet() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tooltip(
          message: "Area's",
          child: Tab(
            icon: Icon(
              Icons.account_tree_sharp,
            ),
          ),
        ),
        Tooltip(
          message: "Search",
          child: Tab(
            icon: Icon(
              Icons.search_sharp,
            ),
          ),
        ),
        Tooltip(
          message: "Utilities",
          child: Tab(
            icon: Icon(Icons.build_sharp),
          ),
        ),
        Tooltip(
          message: "Settings",
          child: Tab(
            icon: Icon(
              Icons.settings_sharp,
            ),
          ),
        ),
      ],
    );
  }
}
