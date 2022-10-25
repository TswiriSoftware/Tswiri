import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/utilities/barcodes/barcodes_view.dart';
import 'package:tswiri/utilities/container_types/container_types_view.dart';
import 'package:tswiri/utilities/gallery/gallery_view.dart';
import 'package:tswiri/utilities/storage/storage_view.dart';

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
          CustomOpenContainer(
            title: 'Storage',
            iconData: Icons.storage_rounded,
            destination: const StorageView(),
            animationDuration: animationDuration,
          ),
          CustomOpenContainer(
            title: 'Gallery',
            iconData: Icons.photo_album_rounded,
            destination: const GalleryView(),
            animationDuration: animationDuration,
          ),
          CustomOpenContainer(
            title: 'QR Codes',
            iconData: Icons.qr_code_2_rounded,
            destination: const BarcodesView(),
            animationDuration: animationDuration,
          ),
          CustomOpenContainer(
            title: 'Container Types',
            iconData: Icons.code_rounded,
            destination: const ContainerTypesView(),
            animationDuration: animationDuration,
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
