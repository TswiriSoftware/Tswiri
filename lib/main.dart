import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tswiri/views/containers/containers_view.dart';
import 'package:tswiri/views/search/search_view.dart';
import 'package:tswiri/views/settings/settings_view.dart';
import 'package:tswiri/views/utilities/utilities_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/functions/isar/create_functions.dart';
import 'package:tswiri_database/functions/other/clear_temp_directory.dart';
import 'package:tswiri_database/mobile_database.dart';
import 'package:tswiri_database/models/search/shopping_cart.dart';
import 'package:tswiri_database/models/settings/app_settings.dart';
import 'package:tswiri_widgets/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Force portraitUp.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Load app settings.
  await loadAppSettings();

  //Initiate Isar Storage Directories.
  await initiateIsarDirectory();
  await initiatePhotoStorage();

  //Initiate Isar.
  isar = initiateMobileIsar();
  createBasicContainerTypes();

  //Clear temp directory whenever the app is opened.
  clearTemporaryDirectory();

  //Run app with shoppingcart provider.
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShoppingCart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tswiri App',
      theme: tswiriTheme,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //Tab controller.
  late final TabController _tabController = TabController(
    vsync: this,
    length: 4,
    initialIndex: 1,
    animationDuration: const Duration(milliseconds: 500),
  );

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    //Show the beta warning for the app.
    if (hasShownBetaWarning == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showBetaWarning();
      });
    }
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
      key: const Key('tab_bar'),
      controller: _tabController,
      labelPadding: const EdgeInsets.all(2.5),
      tabs: const [
        Tooltip(
          message: "Containers",
          child: Tab(
            key: Key('containers_tab'),
            icon: Icon(
              Icons.account_tree_sharp,
            ),
          ),
        ),
        Tooltip(
          message: "Search",
          child: Tab(
            key: Key('search_tab'),
            icon: Icon(
              Icons.search_sharp,
            ),
          ),
        ),
        Tooltip(
          message: "Utilities",
          child: Tab(
            key: Key('utilities_tab'),
            icon: Icon(Icons.build_sharp),
          ),
        ),
        Tooltip(
          message: "Settings",
          child: Tab(
            key: Key('settings_tab'),
            icon: Icon(
              Icons.settings_sharp,
            ),
          ),
        ),
      ],
    );
  }

  void showBetaWarning() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Center(
        child: AlertDialog(
          title: const Text('Beta Warning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Use only for testing or experimenting.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'You could lose all your data at some point.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Noted'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool(hasShownBetaWarningPref, true);
                hasShownBetaWarning = true;
                if (mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
