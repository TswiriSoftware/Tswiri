import 'package:flutter/material.dart';
import 'barcodes/barcodes_view.dart';
import 'calibration/calibration_view.dart';
import 'container_types/container_types_view.dart';
import 'gallery/gallery_view.dart';
import 'generator/generator_view.dart';
import 'grids/grids_view.dart';
import 'navigator_card.dart';

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
        centerTitle: true);
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 2,
        children: const [
          NavigatorCard(
            label: 'Barcodes',
            icon: Icons.qr_code,
            viewPage: BarcodesView(),
          ),
          NavigatorCard(
            label: 'Barcode Generator',
            icon: Icons.scanner_sharp,
            viewPage: GeneratorView(),
          ),
          NavigatorCard(
            label: 'Camera Calibration',
            icon: Icons.camera_sharp,
            viewPage: CalibrationView(),
          ),
          NavigatorCard(
            label: 'Gallery',
            icon: Icons.photo_sharp,
            viewPage: GalleryView(),
          ),
          NavigatorCard(
            label: 'Container Types',
            icon: Icons.code_sharp,
            viewPage: ContainerTypesView(),
          ),
          NavigatorCard(
            label: 'Grids',
            icon: Icons.grid_4x4_sharp,
            viewPage: MarkersView(),
          ),
        ],
      ),
    );
  }
}
