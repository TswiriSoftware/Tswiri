import 'package:flutter/material.dart';

import '../../basic_outline_containers/custom_outline_container.dart';
import '../../basic_outline_containers/light_container.dart';

class NewContainerNameWidget extends StatelessWidget {
  const NewContainerNameWidget(
      {Key? key,
      required this.nameController,
      this.onChanged,
      this.onFieldSubmitted,
      this.name,
      this.description})
      : super(key: key);

  final TextEditingController nameController;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? name;
  final Widget? description;

  @override
  Widget build(BuildContext context) {
    return LightContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Builder(builder: (context) {
              Color outlineColor = Colors.deepOrange;

              return Column(
                children: [
                  CustomOutlineContainer(
                    outlineColor: outlineColor,
                    padding: 0,
                    margin: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 0),
                      child: TextFormField(
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.always,
                        style: Theme.of(context).textTheme.titleSmall,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          icon: Builder(
                            builder: (context) {
                              if (nameController.text.isNotEmpty) {
                                return const Icon(
                                  Icons.hexagon_rounded,
                                  color: Colors.blue,
                                );
                              }
                              return const Icon(Icons.hexagon_rounded);
                            },
                          ),
                          hintText: 'Name',
                          labelText: 'Container Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
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
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  description ?? Container(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}