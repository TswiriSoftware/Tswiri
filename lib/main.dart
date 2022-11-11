import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/general/clear_temp_directory.dart';
import 'package:tswiri_database_interface/functions/isar/isar_functions.dart';
import 'package:tswiri_database_interface/models/find/find.dart';
import 'package:tswiri_database_interface/models/find/shopping_cart.dart';
import 'package:tswiri_database_interface/models/settings/app_settings.dart';
import 'package:tswiri/add/add_view.dart';
import 'package:tswiri/find/find_view.dart';
import 'package:tswiri/settings/settings_view.dart';
import 'package:tswiri/utilities/utilities_view.dart';
import 'package:tswiri_network_interface/client/client.dart';
import 'package:tswiri_theme/tswiri_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //Load app settings.
  await loadAppSettings();

  //Initiate Isar Storage Directories.
  await initiateSpaceDirectory();
  await initiateIsarStorage();
  await initiatePhotoStorage();
  await initiateThumnailStorage();

  //Initiate Isar.
  initiateMobileIsar();
  createDefaultContainerTypes();

  //Clear temp directory whenever the app is opened.
  clearTemporaryDirectory();

  // runApp(const MyApp());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Find>(create: (_) => Find()),
        ChangeNotifierProvider<ShoppingCart>(create: (_) => ShoppingCart()),
        ChangeNotifierProvider<Client>(create: (_) => Client()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  List<Widget> views = [
    const FindView(),
    const AddView(),
    const ManageView(),
    const SettingsView(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<Client>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: views[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Find',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_rounded),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_rounded),
            label: 'Manage',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
