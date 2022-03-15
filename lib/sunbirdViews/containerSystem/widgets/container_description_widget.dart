import 'package:flutter/material.dart';

import '../../../widgets/custom_container.dart';
import '../../../widgets/light_container.dart';

class ContainerDescriptionWidget extends StatelessWidget {
  const ContainerDescriptionWidget({
    Key? key,
    required this.descriptionController,
    this.onChanged,
    this.onFieldSubmitted,
    this.description,
  }) : super(key: key);
  final TextEditingController descriptionController;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onChanged;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      margin: 5,
      padding: 5,
      child: Row(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              Color outlineColor = Colors.grey;
              if (descriptionController.text.isNotEmpty) {
                outlineColor = Colors.blue;
              }
              return CustomOutlineContainer(
                outlineColor: outlineColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 5, top: 0),
                  child: TextFormField(
                    controller: descriptionController,
                    style: Theme.of(context).textTheme.titleSmall,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      icon: Builder(builder: (context) {
                        if (descriptionController.text.isNotEmpty) {
                          return const Icon(
                            Icons.hexagon_rounded,
                            color: Colors.blue,
                          );
                        }
                        return const Icon(Icons.hexagon_rounded);
                      }),
                      hintText: 'Description',
                      labelText: 'Container description',
                    ),
                    onFieldSubmitted: (value) {
                      if (onFieldSubmitted != null) {
                        onFieldSubmitted!(value);
                      }
                    },
                    onChanged: (value) {
                      if (onChanged != null) {
                        onChanged!(value);
                      }
                    },
                  ),
                ),
                margin: 0,
                padding: 0,
              );
            }),
          ),
        ],
      ),
    );
  }
}
