import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/isar_database/barcodes/barcode_size_distance_entry/barcode_size_distance_entry.dart';

class CameraCalibrationDisplayWidget extends StatelessWidget {
  const CameraCalibrationDisplayWidget({Key? key, required this.dataObject})
      : super(key: key);

  final BarcodeSizeDistanceEntry dataObject;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.deepOrange),
                top: BorderSide(color: Colors.deepOrange),
                left: BorderSide(color: Colors.deepOrange),
                right: BorderSide(color: Colors.deepOrange))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.deepOrange))),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: SizedBox(
                  width: 150,
                  child: Text(dataObject.diagonalSize.toString(),
                      textAlign: TextAlign.start),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                width: 150,
                child: Text(dataObject.distanceFromCamera.toString(),
                    textAlign: TextAlign.start),
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
            color: Colors.deepOrange,
            border: Border(
                bottom: BorderSide(color: Colors.deepOrange),
                top: BorderSide(color: Colors.deepOrange),
                left: BorderSide(color: Colors.deepOrange),
                right: BorderSide(color: Colors.deepOrange))),
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
                  width: 150,
                  child: Text(dataObject[0], textAlign: TextAlign.start),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                width: 150,
                child: Text(dataObject[1], textAlign: TextAlign.start),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
