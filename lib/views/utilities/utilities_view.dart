import 'package:tswiri/views/utilities/barcode_generator/generator_view.dart';
import 'package:tswiri/views/utilities/barcodes/barcodes_view.dart';
import 'package:tswiri/views/utilities/camera_calibration/calibration_view.dart';
import 'package:tswiri/views/utilities/container_types/container_types_view.dart';
import 'package:tswiri/views/utilities/gallery/gallery_view.dart';
import 'package:tswiri/views/utilities/grid/grids_view.dart';
import 'package:flutter/material.dart';
import 'package:tswiri_widgets/widgets/general/navigation_card.dart';

class UtilitiesView extends StatefulWidget {
  const UtilitiesView({Key? key}) : super(key: key);

  @override
  State<UtilitiesView> createState() => _UtilitiesViewState();
}

class _UtilitiesViewState extends State<UtilitiesView> {
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
        'Utilities',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
      actions: [],
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 100, left: 8, right: 8),
        crossAxisCount: 2,
        children: const [
          NavigationCard(
            key: Key('barcodes'),
            label: 'Barcodes',
            icon: Icons.qr_code,
            viewPage: BarcodesView(),
          ),
          NavigationCard(
            key: Key('barcode_generator'),
            label: 'Barcode Generator',
            icon: Icons.scanner_sharp,
            viewPage: GeneratorView(),
          ),
          NavigationCard(
            key: Key('camera_calibration'),
            label: 'Camera Calibration (WIP)',
            icon: Icons.camera_sharp,
            viewPage: CalibrationView(),
          ),
          NavigationCard(
            key: Key('gallery'),
            label: 'Gallery',
            icon: Icons.photo_sharp,
            viewPage: GalleryView(),
          ),
          NavigationCard(
            key: Key('container_types'),
            label: 'Container Types',
            icon: Icons.code_sharp,
            viewPage: ContainerTypesView(),
          ),
          NavigationCard(
            key: Key('grids'),
            label: 'Grids',
            icon: Icons.border_clear,
            viewPage: GridsView(),
          ),
        ],
      ),
    );
  }
}
