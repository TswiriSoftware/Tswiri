import 'package:animations/animations.dart';
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
      ),
      centerTitle: true,
      actions: [],
    );
  }

  Widget _body() {
    return Center(
      child: GridView.count(
        // padding:
        //     const EdgeInsets.only(top: 8.0, bottom: 100, left: 4, right: 4),
        crossAxisCount: 2,
        children: const [
          CustomOpenContainer(
            title: 'Barcodes',
            iconData: Icons.qr_code_rounded,
            destination: BarcodesView(),
            animationDuration: Duration(milliseconds: 500),
          ),
          CustomOpenContainer(
            title: 'Barcode Generator',
            iconData: Icons.scanner_rounded,
            destination: GeneratorView(),
            animationDuration: Duration(milliseconds: 500),
          ),
          CustomOpenContainer(
            title: 'Camera Calibration',
            iconData: Icons.camera_rounded,
            destination: CalibrationView(),
            animationDuration: Duration(milliseconds: 500),
          ),
          CustomOpenContainer(
            title: 'Gallery',
            iconData: Icons.photo_rounded,
            destination: GalleryView(),
            animationDuration: Duration(milliseconds: 500),
          ),
          CustomOpenContainer(
            title: 'Container Types',
            iconData: Icons.code_rounded,
            destination: ContainerTypesView(),
            animationDuration: Duration(milliseconds: 500),
          ),
          CustomOpenContainer(
            title: 'Grids',
            iconData: Icons.grid_4x4_rounded,
            destination: GridsView(),
            animationDuration: Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}

class CustomOpenContainer extends StatefulWidget {
  const CustomOpenContainer(
      {super.key,
      required this.title,
      required this.iconData,
      required this.destination,
      this.animationDuration});
  final String title;
  final IconData iconData;
  final Widget destination;
  final Duration? animationDuration;
  @override
  State<CustomOpenContainer> createState() => _CustomOpenContainerState();
}

class _CustomOpenContainerState extends State<CustomOpenContainer> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      transitionDuration:
          widget.animationDuration ?? const Duration(milliseconds: 300),
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          child: TextButton(
            onPressed: action,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraint) {
                      return Icon(
                        widget.iconData,
                        size: constraint.maxWidth / 3,
                        color: Theme.of(context).colorScheme.onBackground,
                      );
                    },
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      openBuilder: (context, _) => widget.destination,
    );
  }
}
