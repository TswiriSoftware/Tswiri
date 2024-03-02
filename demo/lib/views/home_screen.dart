import 'package:flutter/material.dart';
import 'package:tswiri/views/containers_screen.dart';
import 'package:tswiri/views/find_screen.dart';
import 'package:tswiri/views/manage_screen.dart';
import 'package:tswiri/views/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  List<Widget> pages = const [
    FindScreen(),
    ContainersScreen(),
    ManageScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Find',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_sharp),
            label: 'Containers',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_sharp),
            label: 'Manage',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        selectedIndex: currentPageIndex,
      ),
    );
  }
}
