import 'package:flutter/material.dart';

import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ScanBarcodeWidget extends StatelessWidget {
  const ScanBarcodeWidget({Key? key, this.barcodeUID, required this.button})
      : super(key: key);
  final String? barcodeUID;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (barcodeUID != null) {
          outlineColor = Colors.blue;
        }

        return CustomOutlineContainer(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('barcodeUID',
                    style: Theme.of(context).textTheme.bodySmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      if (barcodeUID == null) {
                        return Text('Scan Barcode',
                            style: Theme.of(context).textTheme.subtitle2);
                      } else {
                        return Text(barcodeUID!,
                            style: Theme.of(context).textTheme.labelMedium);
                      }
                    }),
                    button,
                  ],
                ),
              ],
            ),
          ),
          outlineColor: outlineColor,
          margin: 0,
          padding: 0,
        );
      }),
    );
  }
}
