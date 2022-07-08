import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/global_values/global_colours.dart';
import 'package:flutter_google_ml_kit/isar_database/isar_export.dart';
import 'package:flutter_google_ml_kit/views/scanning/position/position_scanner_view.dart';
import 'package:flutter_google_ml_kit/views/widgets/cards/default_card/defualt_card.dart';
import 'package:flutter_google_ml_kit/views/widgets/grid_view/grid_viewer.dart';

// ignore: must_be_immutable
class GridDisplayView extends StatefulWidget {
  GridDisplayView({Key? key, required this.containerEntry}) : super(key: key);
  ContainerEntry containerEntry;

  @override
  State<GridDisplayView> createState() => _GridDisplayViewState();
}

class _GridDisplayViewState extends State<GridDisplayView> {
  late final ContainerEntry _parentContainer = isarDatabase!.containerEntrys
      .filter()
      .barcodeUIDMatches(gridUID)
      .findFirstSync()!;

  late String gridUID = isarDatabase!.coordinateEntrys
      .filter()
      .barcodeUIDMatches(widget.containerEntry.barcodeUID!)
      .findFirstSync()!
      .gridUID;

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
        'Grid: $gridUID',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return Column(
      children: [
        GridViewer(
          girdUID: gridUID,
          highlightBarcode: widget.containerEntry.barcodeUID,
        ),
        _actions()
      ],
    );
  }

  Card _actions() {
    return defaultCard(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Row(
            //     children: const [
            //       Text('Clear'),
            //       Icon(Icons.delete),
            //     ],
            //   ),
            // ),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PositionScannerView(
                      parentContainer: _parentContainer,
                      customColor: sunbirdOrange,
                    ),
                  ),
                );
              },
              child: Row(
                children: const [Text('Scan'), Icon(Icons.scatter_plot)],
              ),
            ),
          ],
        ),
        borderColor: sunbirdOrange);
  }
}
