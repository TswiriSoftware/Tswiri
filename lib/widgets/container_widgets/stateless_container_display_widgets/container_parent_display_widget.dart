import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';

import '../../basic_outline_containers/dark_container.dart';
import '../../basic_outline_containers/light_container.dart';

class ContainerParentDisplayWidget extends StatelessWidget {
  const ContainerParentDisplayWidget(
      {Key? key, required this.parentName, required this.parentUID})
      : super(key: key);
  final String? parentUID;
  final String? parentName;
  @override
  Widget build(BuildContext context) {
    return LightContainer(
        margin: 2.5,
        padding: 2.5,
        child: OrangeOutlineContainer(
            borderWidth: 0.5,
            margin: 0,
            padding: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parentName',
                    style: Theme.of(context).textTheme.bodySmall),
                Text(parentName ?? parentUID ?? 'none',
                    style: Theme.of(context).textTheme.subtitle2),
                const Divider(
                  height: 10,
                  color: Colors.white54,
                ),
                Text('parentUID', style: Theme.of(context).textTheme.bodySmall),
                Text(parentUID ?? 'none',
                    style: Theme.of(context).textTheme.subtitle2),
              ],
            )));
  }
}
