import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/global_values/shared_prefrences.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/real_interbarcode_vector_entry/real_interbarcode_vector_entry.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/raw_on_image_inter_barcode_data.dart';
import 'package:flutter_google_ml_kit/objects/real_inter_barcode_offset.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/functions/build_real_inter_barcode_offsets.dart';
import 'package:flutter_google_ml_kit/sunbird_views/barcode_scanning/barcode_position_scanner/functions/functions.dart';
import 'package:googleapis/file/v1.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInterBarcodeData extends StatefulWidget {
  const CheckInterBarcodeData(
      {Key? key, required this.allRawOnImageBarcodeData})
      : super(key: key);
  final List<RawOnImageBarcodeData> allRawOnImageBarcodeData;
  @override
  State<CheckInterBarcodeData> createState() => _CheckInterBarcodeDataState();
}

class _CheckInterBarcodeDataState extends State<CheckInterBarcodeData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
      centerTitle: true,
      title: Text(
        'Checking Positions',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _body() {
    return FutureBuilder<List<RealInterBarcodeVectorEntry>>(
      future: checkPositions(widget.allRawOnImageBarcodeData),
      builder: (context, snapshot) {
        if (snapshot.hasData && mounted) {
          List<RealInterBarcodeVectorEntry> data = snapshot.data!;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Text(
                        data[index].startBarcodeUID +
                            ' => ' +
                            data[index].endBarcodeUID,
                      ),
                    ],
                  ),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<RealInterBarcodeVectorEntry>> checkPositions(
      List<RawOnImageBarcodeData> allRawOnImageBarcodeData) async {
    List<RealInterBarcodeVectorEntry> changedPositions = [];

    List<RawOnImageInterBarcodeData> allOnImageInterBarcodeData =
        buildAllOnImageInterBarcodeData(allRawOnImageBarcodeData);

    final prefs = await SharedPreferences.getInstance();
    double focalLength = prefs.getDouble(focalLengthPreference) ?? 0;

    //Check Function for details.
    List<RealInterBarcodeOffset> allRealInterBarcodeOffsets =
        buildAllRealInterBarcodeOffsets(
      allOnImageInterBarcodeData: allOnImageInterBarcodeData,
      database: isarDatabase!,
      focalLength: focalLength,
    );

    //4.2 This list contains only unique realInterBarcodeOffsets
    List<RealInterBarcodeOffset> uniqueRealInterBarcodeOffsets =
        allRealInterBarcodeOffsets.toSet().toList();

    //5. To build the list of final RealInterBarcodeOffsets we:
    //  i. Remove all the outliers from allOnImageInterBarcodeData
    //  ii. Then use the uniqueRealInterBarcodeOffsets as a reference to
    //      calculate the average from allRealInterBarcodeOffsets.

    List<RealInterBarcodeOffset> finalRealInterBarcodeOffsets =
        processRealInterBarcodeData(
            uniqueRealInterBarcodeOffsets: uniqueRealInterBarcodeOffsets,
            listOfRealInterBarcodeOffsets: allRealInterBarcodeOffsets);

    List<RealInterBarcodeVectorEntry> interbarcodeOffsetEntries = [];

    for (RealInterBarcodeOffset interBarcodeOffset
        in finalRealInterBarcodeOffsets) {
      RealInterBarcodeVectorEntry vectorEntry = RealInterBarcodeVectorEntry()
        ..startBarcodeUID = interBarcodeOffset.uidStart
        ..endBarcodeUID = interBarcodeOffset.uidEnd
        ..x = interBarcodeOffset.offset.dx
        ..y = interBarcodeOffset.offset.dy
        ..z = interBarcodeOffset.zOffset
        ..timestamp = interBarcodeOffset.timestamp;
      interbarcodeOffsetEntries.add(vectorEntry);
    }

    //Run Comparison Script

    for (RealInterBarcodeVectorEntry realInterBarcodeOffset
        in interbarcodeOffsetEntries) {
      RealInterBarcodeVectorEntry? matching = isarDatabase!
          .realInterBarcodeVectorEntrys
          .filter()
          .group((q) => q
              .startBarcodeUIDMatches(realInterBarcodeOffset.startBarcodeUID)
              .and()
              .endBarcodeUIDMatches(realInterBarcodeOffset.endBarcodeUID))
          .findFirstSync();

      if (matching != null) {
        bool hasMoved = check(realInterBarcodeOffset, matching);
        if (hasMoved) {
          isarDatabase!.writeTxnSync((isar) => isar.realInterBarcodeVectorEntrys
              .filter()
              .startBarcodeUIDMatches(matching.startBarcodeUID)
              .or()
              .endBarcodeUIDMatches(matching.endBarcodeUID)
              .or()
              .startBarcodeUIDMatches(matching.endBarcodeUID)
              .or()
              .endBarcodeUIDMatches(matching.startBarcodeUID)
              .deleteAllSync());

          matching.x = realInterBarcodeOffset.x;
          matching.y = realInterBarcodeOffset.y;
          matching.z = realInterBarcodeOffset.z;
          matching.timestamp = realInterBarcodeOffset.timestamp;

          isarDatabase!.writeTxnSync((isar) => isar.realInterBarcodeVectorEntrys
              .putSync(matching, replaceOnConflict: true));
          changedPositions.add(matching);
        }
      }
      // else {
      //   matching = isarDatabase!.realInterBarcodeVectorEntrys
      //       .filter()
      //       .group((q) => q
      //           .startBarcodeUIDMatches(realInterBarcodeOffset.endBarcodeUID)
      //           .and()
      //           .endBarcodeUIDMatches(realInterBarcodeOffset.startBarcodeUID))
      //       .findFirstSync();

      //   if (matching != null) {
      //     bool hasMoved = check(realInterBarcodeOffset, matching);
      //     if (hasMoved) {
      //       log('has Moved');
      //       isarDatabase!.writeTxnSync((isar) =>
      //           isar.realInterBarcodeVectorEntrys.deleteSync(matching!.id));

      //       matching.x = -realInterBarcodeOffset.x;
      //       matching.y = -realInterBarcodeOffset.y;
      //       matching.z = realInterBarcodeOffset.z;
      //       matching.timestamp = realInterBarcodeOffset.timestamp;

      //       isarDatabase!.writeTxnSync((isar) => isar
      //           .realInterBarcodeVectorEntrys
      //           .putSync(matching!, replaceOnConflict: true));
      //       changedPositions.add(matching);
      //     }
      //   }
      // }
    }

    return changedPositions;
  }

  bool check(
      RealInterBarcodeVectorEntry current, RealInterBarcodeVectorEntry stored) {
    double errorValue = 50; // max error value in mm
    double currentX = current.x;
    double currentXLowerBoundry = currentX - (errorValue);
    double currentXUpperBoundry = currentX + (errorValue);

    double currentY = current.y;
    double currentYLowerBoundry = currentY - (errorValue);
    double currentYUpperBoundry = currentY + (errorValue);

    double storedX = stored.x;
    double storedY = stored.y;

    if (storedX <= currentXUpperBoundry &&
        storedX >= currentXLowerBoundry &&
        storedY <= currentYUpperBoundry &&
        storedY >= currentYLowerBoundry) {
      return false;
    } else {
      return true;
    }
  }
}
