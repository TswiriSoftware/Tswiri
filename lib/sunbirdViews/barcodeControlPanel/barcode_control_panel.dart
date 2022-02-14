import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/classes.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/unassigned_tags_widget.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'assigned_tags_widgets.dart';
import 'barcode_data_widget.dart';

class BarcodeControlPanelView extends StatefulWidget {
  final BarcodeAndTagData barcodeAndTagData;
  final List<String> unassignedTags;
  const BarcodeControlPanelView(
      {Key? key, required this.barcodeAndTagData, required this.unassignedTags})
      : super(key: key);

  @override
  State<BarcodeControlPanelView> createState() =>
      _BarcodeControlPanelViewState();
}

class _BarcodeControlPanelViewState extends State<BarcodeControlPanelView> {
  List<String> assignedTags = [];
  List<String> unassignedTags = [];

  @override
  void initState() {
    assignedTags = widget.barcodeAndTagData.tags ?? [];
    unassignedTags = widget.unassignedTags
        .where((element) => !assignedTags.contains(element))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepSpaceSparkle,
        title: const Text(
          'Barcode',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Column(
        children: [
          BarcodeDataContainer(barcodeAndTagData: widget.barcodeAndTagData),
          ChangeNotifierProvider(
            create: (_) => Tags(assignedTags, unassignedTags),
            child: Column(
              children: [
                AssignedTagsContainer(
                  assignedTags: assignedTags,
                  barcodeID: widget.barcodeAndTagData.barcodeID,
                ),
                UnassignedTagsContainer(
                  unassignedTags: unassignedTags,
                  barcodeID: widget.barcodeAndTagData.barcodeID,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
