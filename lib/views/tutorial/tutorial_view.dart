import 'package:flutter/material.dart';
import 'package:sunbird/views/tutorial/tutorial_barcodes_view.dart';
import 'package:sunbird/views/tutorial/tutorial_calibration_view.dart';
import 'package:sunbird/views/tutorial/tutorial_container_types.dart';
import 'package:sunbird/views/tutorial/tutorial_container_view.dart';
import 'package:sunbird/views/tutorial/tutorial_grid_view.dart';
import 'package:sunbird/views/tutorial/tutorial_navigation_view.dart';
import 'package:sunbird/views/tutorial/tutorial_search_view.dart';
import 'package:sunbird/views/utilities/navigator_card.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Tutorials',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        children: const [
          NavigatorCard(
            label: 'Barcodes',
            icon: Icons.qr_code_2_sharp,
            viewPage: TutorialBarcodesView(),
          ),
          NavigatorCard(
            label: 'Calibration',
            icon: Icons.camera_sharp,
            viewPage: TutorialCalibrationView(),
          ),
          NavigatorCard(
            label: 'Container Types',
            icon: Icons.code_sharp,
            viewPage: TutorialContainerTypesView(),
          ),
          NavigatorCard(
            label: 'Containers',
            icon: Icons.account_tree_sharp,
            viewPage: TutorialContainerView(),
          ),
          NavigatorCard(
            label: 'Grid',
            icon: Icons.grid_3x3_sharp,
            viewPage: TutorialGridView(),
          ),
          NavigatorCard(
            label: 'Navigation',
            icon: Icons.navigation_sharp,
            viewPage: TutorialNavigationView(),
          ),
          NavigatorCard(
            label: 'Photo Label',
            icon: Icons.photo_sharp,
            viewPage: TutorialSearchView(),
          ),
          NavigatorCard(
            label: 'Search',
            icon: Icons.search_sharp,
            viewPage: TutorialSearchView(),
          ),
        ],
      ),
    );
  }
}
