import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_types/container_type_edit_view.dart';
import 'package:flutter_google_ml_kit/sunbird_views/container_types/new_container_type_view.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';

class ContainerTypeView extends StatefulWidget {
  const ContainerTypeView({Key? key}) : super(key: key);

  @override
  State<ContainerTypeView> createState() => _ContainerTypeViewState();
}

class _ContainerTypeViewState extends State<ContainerTypeView> {
  late List<ContainerType> containerTypes;

  List<ContainerType> selectedContainers = [];
  bool showCheckBox = false;

  @override
  void initState() {
    //Get all Container Types.
    containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Container Types',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Builder(builder: (context) {
            if (showCheckBox) {
              return IconButton(
                onPressed: () {
                  _deleteSelectedContainers();
                  selectedContainers = [];
                  setState(() {
                    showCheckBox = false;
                  });
                },
                icon: Icon(Icons.delete),
              );
            } else {
              return Row();
            }
          })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: addNewTypeButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _select(),
            _typeListBuilder(),
            _bottomSpace(),
          ],
        ),
      ),
    );
  }

  ///SELECT///
  Widget _select() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hold to select',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  ///TYPES///

  Widget _typeListBuilder() {
    return Column(
      children: containerTypes.map((e) => typeListTile(e)).toList(),
    );
  }

  Widget typeListTile(ContainerType containerType) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            showCheckBox = true;
            selectedContainers.add(containerType);
          });
        },
        child: CustomOutlineContainer(
          margin: 2.5,
          padding: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      containerType.containerType.toString().capitalize(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Builder(builder: (context) {
                      if (showCheckBox) {
                        return Checkbox(
                          value: selectedContainers.contains(containerType),
                          onChanged: (value) {
                            _onSelectedContainer(value!, containerType);
                          },
                          fillColor: MaterialStateProperty.all(
                            Color(int.parse(containerType.containerColor))
                                .withOpacity(1),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
                _dividerHeavy(),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  containerType.containerDescription,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                _dividerLight(),
                Text(
                  'Can Contain',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  containerType.canContain.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                _dividerLight(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Options',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Movable: ' + containerType.moveable.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Marker to Children: ' +
                              containerType.markerToChilren.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    typeEditButton(containerType),
                  ],
                ),
              ],
            ),
          ),
          outlineColor:
              Color(int.parse(containerType.containerColor)).withOpacity(1),
        ),
      ),
    );
  }

  Widget typeEditButton(ContainerType containerType) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ContainerTypeEditView(containerType: containerType),
          ),
        );
        setState(() {
          containerTypes = isarDatabase!.containerTypes.where().findAllSync();
        });
      },
      child: CustomOutlineContainer(
        width: 80,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'edit',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Icon(Icons.edit),
          ],
        ),
        outlineColor:
            Color(int.parse(containerType.containerColor)).withOpacity(1),
      ),
    );
  }

  Widget addNewTypeButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewContainerTypeView()),
        );
        setState(() {
          containerTypes = isarDatabase!.containerTypes.where().findAllSync();
        });
      },
    );
  }

  ///MISC///
  Widget _dividerHeavy() {
    return const Divider(
      color: Colors.white54,
      thickness: 1,
      height: 10,
    );
  }

  Widget _dividerLight() {
    return const Divider(
      color: Colors.white30,
      height: 10,
    );
  }

  Widget _bottomSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
    );
  }

  ///FUNCTIONS///

  void _deleteSelectedContainers() {
    isarDatabase!.writeTxnSync((isar) => isar.containerTypes
        .deleteAllSync(selectedContainers.map((e) => e.id).toList()));

    setState(() {
      containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    });
  }

  void _onSelectedContainer(bool selected, ContainerType dataName) {
    if (selected == true) {
      setState(() {
        selectedContainers.add(dataName);
      });
    } else {
      setState(() {
        selectedContainers.remove(dataName);
        if (selectedContainers.isEmpty) {
          showCheckBox = false;
        }
      });
    }
  }
}
