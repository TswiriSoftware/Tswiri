import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerBarcodeDisplayWidget extends StatelessWidget {
  const ContainerBarcodeDisplayWidget({Key? key, required this.barcodeUID})
      : super(key: key);
  final String? barcodeUID;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 2.5,
      padding: 2.5,
      child: OrangeOutlineContainer(
        margin: 0,
        padding: 8,
        borderWidth: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('barcodeUID', style: Theme.of(context).textTheme.bodySmall),
            const Divider(
              height: 3,
            ),
            Text(barcodeUID ?? 'none',
                style: Theme.of(context).textTheme.subtitle2),
          ],
        ),
      ),
    );
  }
}
