import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/barcode_and_tag_data.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/classes.dart';
import 'package:flutter_google_ml_kit/sunbirdViews/barcodeControlPanel/widgets/unassigned_tags_widget.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../../functions/barcodeTools/get_data_functions.dart';
import '../../globalValues/global_hive_databases.dart';
import 'widgets/assigned_tags_widgets.dart';
import 'widgets/barcode_data_widget.dart';

class BarcodeControlPanelView extends StatefulWidget {
  const BarcodeControlPanelView({Key? key, required this.barcodeID})
      : super(key: key);

  final int barcodeID;
  @override
  State<BarcodeControlPanelView> createState() =>
      _BarcodeControlPanelViewState();
}

class _BarcodeControlPanelViewState extends State<BarcodeControlPanelView> {
  List<String> assignedTags = [];
  List<String> unassignedTags = [];
  bool isFixed = false;
  double barcodeSize = 0;

  @override
  void initState() {
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
      body: FutureBuilder<BarcodeAndTagData>(
        future: getCurrentBarcodeData(widget.barcodeID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                ChangeNotifierProvider(
                  create: (_) =>
                      Tags(assignedTags, unassignedTags, isFixed, barcodeSize),
                  child: Column(
                    children: [
                      BarcodeDataContainer(
                        barcodeAndTagData: snapshot.data!,
                        isFixed: isFixed,
                        barcodeSize: barcodeSize,
                      ),
                      AssignedTagsContainer(
                        assignedTags: assignedTags,
                        barcodeID: widget.barcodeID,
                      ),
                      UnassignedTagsContainer(
                        unassignedTags: unassignedTags,
                        barcodeID: widget.barcodeID,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<BarcodeAndTagData> getCurrentBarcodeData(int barcodeID) async {
    //Gets a list of all barcodeTagEntries
    List<String> barcodeTags = await getCurrentBarcodeTags(barcodeID);
    List<String> barcodeUnassignedTags = await getUnassignedTags();

    Box<BarcodeDataEntry> generatedBarcodesBox =
        await Hive.openBox(generatedBarcodesBoxName);
    BarcodeDataEntry barcodeData = generatedBarcodesBox.get(barcodeID)!;

    barcodeUnassignedTags
        .removeWhere((element) => barcodeTags.contains(element));

    BarcodeAndTagData barcodeAndTagData = BarcodeAndTagData(
        barcodeID: barcodeID,
        barcodeSize: barcodeData.barcodeSize,
        fixed: barcodeData.isFixed,
        tags: barcodeTags);

    unassignedTags = barcodeUnassignedTags;
    assignedTags = barcodeTags;
    isFixed = barcodeData.isFixed;
    barcodeSize = barcodeData.barcodeSize;

    return barcodeAndTagData;
  }
}