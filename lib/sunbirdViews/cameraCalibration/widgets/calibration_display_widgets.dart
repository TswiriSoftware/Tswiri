import 'package:flutter/material.dart';

import '../../../databaseAdapters/calibrationAdapters/matched_calibration_data_adapter.dart';
import '../../../globalValues/global_colours.dart';

class DisplayMatchedDataWidget extends StatelessWidget {
  const DisplayMatchedDataWidget({Key? key, required this.dataObject})
      : super(key: key);

  final MatchedCalibrationDataHiveObject dataObject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: deepSpaceSparkle),
                top: BorderSide(color: deepSpaceSparkle),
                left: BorderSide(color: deepSpaceSparkle),
                right: BorderSide(color: deepSpaceSparkle))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: deepSpaceSparkle))),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: SizedBox(
                  child: Text(dataObject.objectSize.toString(),
                      textAlign: TextAlign.start),
                  width: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                child: Text(dataObject.distanceFromCamera.toString(),
                    textAlign: TextAlign.start),
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayDataHeader extends StatelessWidget {
  const DisplayDataHeader({Key? key, required this.dataObject})
      : super(key: key);
  final List dataObject;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            color: deepSpaceSparkle,
            border: Border(
                bottom: BorderSide(color: deepSpaceSparkle),
                top: BorderSide(color: deepSpaceSparkle),
                left: BorderSide(color: deepSpaceSparkle),
                right: BorderSide(color: deepSpaceSparkle))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.white))),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  child: Text(dataObject[0], textAlign: TextAlign.start),
                  width: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                child: Text(dataObject[1], textAlign: TextAlign.start),
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
