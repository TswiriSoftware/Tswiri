import 'package:flutter/material.dart';

import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class NewContainerParentWidget extends StatelessWidget {
  const NewContainerParentWidget({
    Key? key,
    required this.button,
    this.parentContainerUID,
    this.parentContainerName,
  }) : super(key: key);

  final String? parentContainerUID;
  final String? parentContainerName;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (parentContainerUID != null) {
          outlineColor = Colors.blue;
        }
        return CustomOutlineContainer(
          outlineColor: outlineColor,
          padding: 0,
          margin: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('parentName',
                    style: Theme.of(context).textTheme.bodySmall),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(parentContainerName ?? parentContainerUID ?? ''),
                ),
                Text('parentUID', style: Theme.of(context).textTheme.bodySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Build text
                    Builder(builder: (context) {
                      if (parentContainerUID != null) {
                        return Text(parentContainerUID ?? '',
                            style: Theme.of(context).textTheme.labelMedium);
                      }
                      return Text('Select Parent',
                          style: Theme.of(context).textTheme.subtitle2);
                    }),
                    button,
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
