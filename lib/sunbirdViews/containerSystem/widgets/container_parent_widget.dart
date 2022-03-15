import 'package:flutter/material.dart';

import '../../../widgets/custom_container.dart';
import '../../../widgets/light_container.dart';

class ContainerParentWidget extends StatelessWidget {
  const ContainerParentWidget({
    Key? key,
    required this.child,
    this.parentContainerUID,
  }) : super(key: key);

  final String? parentContainerUID;
  final Widget child;

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
                Text('parentUID',
                    style: Theme.of(context).textTheme.bodyMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///Build text
                    Builder(builder: (context) {
                      if (parentContainerUID != null) {
                        return Text(parentContainerUID ?? '',
                            style: const TextStyle(fontSize: 18));
                      }
                      return Text('Select Parent',
                          style: Theme.of(context).textTheme.bodyMedium);
                    }),
                    child,
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
