import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tswiri/navigation_widgets/open_navigation_tile.dart';
import 'package:tswiri/utilities/barcodes/barcode_batches_view.dart';
import 'package:tswiri/utilities/container_types/container_types_view.dart';
import 'package:tswiri/utilities/containers/containers_view.dart';
import 'package:tswiri/utilities/gallery/gallery_view.dart';
import 'package:tswiri/utilities/grid/grids_view.dart';
import 'package:tswiri/utilities/storage/storage_view.dart';
import 'package:tswiri_database_interface/models/container_manager/container_manager.dart';

class ManageView extends StatefulWidget {
  const ManageView({super.key});

  @override
  State<ManageView> createState() => _ManageViewState();
}

class _ManageViewState extends State<ManageView> {
  ///Specify the duration of the openContainer animation.
  final Duration animationDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _sliverAppBar(),
        _sliverGrid(),
      ],
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      expandedHeight: 0,
      flexibleSpace: AppBar(
        title: const Text(
          'Manage',
        ),
        centerTitle: true,
        elevation: 5,
      ),
    );
  }

  SliverPadding _sliverGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(4),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        children: [
          OpenNavigationTile(
            title: 'Containers',
            iconData: Icons.clear_all_rounded,
            destination: ChangeNotifierProvider(
              create: (context) => ContainerManager(),
              child: const ContainersView(),
            ),
            animationDuration: animationDuration,
          ),
          OpenNavigationTile(
            title: 'Storage',
            iconData: Icons.storage_rounded,
            destination: const StorageView(),
            animationDuration: animationDuration,
          ),
          OpenNavigationTile(
            title: 'Gallery',
            iconData: Icons.photo_album_rounded,
            destination: const GalleryView(),
            animationDuration: animationDuration,
          ),
          OpenNavigationTile(
            title: 'QR Codes',
            iconData: Icons.qr_code_2_rounded,
            destination: const BarcodeBatchesView(),
            animationDuration: animationDuration,
          ),
          OpenNavigationTile(
            title: 'Container Types',
            iconData: Icons.code_rounded,
            destination: const ContainerTypesView(),
            animationDuration: animationDuration,
          ),
          OpenNavigationTile(
            title: 'Grids',
            iconData: Icons.grid_4x4_rounded,
            destination: const GridsView(),
            animationDuration: animationDuration,
          ),
        ],
      ),
    );
  }
}
