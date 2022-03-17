import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/light_container.dart';

import '../../../widgets/custom_container.dart';

class ContainerTypeWidget extends StatelessWidget {
  const ContainerTypeWidget(
      {Key? key, this.containerType, required this.builder})
      : super(key: key);

  final String? containerType;
  final Widget builder;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 5,
      padding: 5,
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (containerType != null) {
          outlineColor = Colors.blue;
        }
        return CustomOutlineContainer(
          outlineColor: outlineColor,
          margin: 0,
          padding: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Container type:',
                      style: TextStyle(fontSize: 18),
                    ),
                    builder,
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
