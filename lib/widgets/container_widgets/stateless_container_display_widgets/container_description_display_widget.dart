import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';

import '../../basic_outline_containers/light_container.dart';

class ContainerDescriptionDisplayWidget extends StatelessWidget {
  const ContainerDescriptionDisplayWidget({Key? key, required this.description})
      : super(key: key);
  final String? description;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 2.5,
      padding: 2.5,
      child: OrangeOutlineContainer(
        borderWidth: 0.5,
        padding: 8,
        margin: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'description',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Divider(
              height: 3,
            ),
            Builder(builder: (context) {
              if (description != null) {
                return Text(
                  description!,
                  style: Theme.of(context).textTheme.subtitle2,
                );
              } else {
                return Text(
                  'no description',
                  style: Theme.of(context).textTheme.bodySmall,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
