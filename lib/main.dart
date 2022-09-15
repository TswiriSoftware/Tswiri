// ignore_for_file: unused_import

import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbird/views/search/search_view.dart';
import 'package:sunbird/views/search/shopping_cart/shopping_cart.dart';
import 'package:tswiri_base/theme/theme.dart';
import 'globals/globals_export.dart';
import 'isar/isar_database.dart';
import 'views/containers/containers_view/containers_view.dart';
import 'views/settings/settings_view.dart';
import 'views/utilities/utilities_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Force portraitUp.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Get Camera descriptions.
  cameras = await availableCameras();

  //Load App Settigns.
  await loadAppSettings();
  await initiateIsarDirectory(currentSpacePath);
  await initiatePhotoStorage(currentSpacePath);

  //Initiate Isar
  isar = initiateIsar(inspector: false);
  createBasicContainerTypes();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://71d4f2ab67d54ec59fd8eb2a42d00fc8@o1364118.ingest.sentry.io/6657903';

      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      options.enableAutoPerformanceTracking = true;
    },
    appRunner: () => runApp(
      DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: ChangeNotifierProvider(
          child: const MyApp(),
          create: (context) => ShoppingCart(),
        ),
      ),
    ),
  );

  //Run app without Sentry.
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: sunbirdTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
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
  bool isSearching = false;

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
    if (hasShownBetaDialog == false) {
      return // set up the AlertDialog
          AlertDialog(
        title: const Text("Beta"),
        content: const Text(
          "The app is in beta please don't use it unless it is for experimental reasons",
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool(hasShownBetaDialogPref, true);
              setState(() {
                hasShownBetaDialog = true;
              });
            },
            child: const Text('Agree'),
          ),
        ],
      );
    }
    return Scaffold(
      body: _tabBarView(),
      bottomSheet: isSearching ? const SizedBox.shrink() : _bottomSheet(),
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      physics: isSearching ? const NeverScrollableScrollPhysics() : null,
      controller: _tabController,
      children: [
        ContainersView(
          isSearching: (value) => setState(() {
            isSearching = value;
          }),
        ),
        SearchView(
          isSearching: (value) => setState(() {
            isSearching = value;
          }),
        ),
        const UtilitiesView(),
        const SettingsView(),
      ],
    );
  }

  Widget _bottomSheet() {
    return TabBar(
      // isScrollable: !isSearching,
      controller: _tabController,
      labelPadding: const EdgeInsets.all(2.5),
      tabs: const [
        Tooltip(
          message: "Containers",
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
