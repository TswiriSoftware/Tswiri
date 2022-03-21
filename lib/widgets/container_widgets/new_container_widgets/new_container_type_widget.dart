import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';

import '../../basic_outline_containers/custom_outline_container.dart';

class NewContainerTypeWidget extends StatelessWidget {
  const NewContainerTypeWidget(
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
          padding: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Container type:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  builder,
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
