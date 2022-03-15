import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../widgets/custom_container.dart';
import '../../../widgets/light_container.dart';
import '../../../widgets/orange_container.dart';
import '../container_children_view.dart';

class ContainerChildren extends StatelessWidget {
  const ContainerChildren(
      {Key? key, required this.currentContainerUID, this.children})
      : super(key: key);
  final String currentContainerUID;
  final List<String>? children;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Builder(builder: (context) {
        Color outlineColor = Colors.grey;
        if (children != null) {
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Children',
                        style: Theme.of(context).textTheme.bodyMedium),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainerChildrenView(
                              currentContainerUID: currentContainerUID,
                            ),
                          ),
                        );
                      },
                      child: OrangeOutlineContainer(
                        child: Text('Edit Children',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: children?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          log('message');
                        },
                        child: Text('data'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
