import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/functions/mathfunctions/round_to_double.dart';
import 'package:flutter_google_ml_kit/globalValues/global_colours.dart';
import 'package:flutter_google_ml_kit/objects/real_barcode_position.dart';

class RealPositionDisplayWidget extends StatelessWidget {
  const RealPositionDisplayWidget({Key? key, required this.realBarcodePosition})
      : super(key: key);
  final RealBarcodePosition realBarcodePosition;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 0.8),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(2),
              height: 30,
              width: (MediaQuery.of(context).size.width * 0.12),
              decoration: const BoxDecoration(
                  color: brightOrange,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Center(
                child: Text(realBarcodePosition.uid),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(2),
              height: 28,
              width: (MediaQuery.of(context).size.width * 0.25),
              decoration: BoxDecoration(
                  color: deepSpaceSparkle[100],
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(3))),
              child: Container(
                margin: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'X: ${roundDouble(realBarcodePosition.interBarcodeOffset!.dx, 2)}',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(2),
              height: 28,
              width: (MediaQuery.of(context).size.width * 0.25),
              decoration: BoxDecoration(
                  color: deepSpaceSparkle[100],
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(3))),
              child: Container(
                margin: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Y: ${roundDouble(realBarcodePosition.interBarcodeOffset!.dy, 2)}',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(2),
              height: 28,
              width: (MediaQuery.of(context).size.width * 0.325),
              decoration: BoxDecoration(
                  color: deepSpaceSparkle[100],
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(3))),
              child: Container(
                margin: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Z: ${roundDouble(realBarcodePosition.distanceFromCamera, 2)}',
                ),
              ),
            ),
          ],
        ));
  }
}
