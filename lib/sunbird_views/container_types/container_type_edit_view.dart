import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/functions/keyboard_functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/custom_outline_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:isar/isar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ContainerTypeEditView extends StatefulWidget {
  const ContainerTypeEditView({Key? key, required this.containerType})
      : super(key: key);

  final ContainerType containerType;
  @override
  State<ContainerTypeEditView> createState() => _ContainerTypeEditViewState();
}

class _ContainerTypeEditViewState extends State<ContainerTypeEditView> {
  late ContainerType containerType;
  late Color containerColor;
  late bool moveable;
  late bool markerToChildren;

  late List<ContainerType> containerTypes;
  List<String> canContainTypes = [];
  bool showCanContain = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late Color pickerColor;
  late Color currentColor;

  @override
  void initState() {
    //Current Setup
    containerType = widget.containerType;
    containerColor =
        Color(int.parse(containerType.containerColor)).withOpacity(1);
    moveable = containerType.moveable;
    markerToChildren = containerType.markerToChilren;
    nameController.text = containerType.containerType.capitalize();
    descriptionController.text = containerType.containerDescription;

    pickerColor = containerColor;

    //Other types
    containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    canContainTypes = containerType.canContain;

    log(canContainTypes.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            containerType.containerType.capitalize(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: containerColor,
          actions: [
            IconButton(
              onPressed: () {
                //Save changes
                //saveChanges();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Info
              _infoTile(),
              //CanContain.
              _canContainTile(),
              //Options.
              _optionsTile(),
              //Color.
              _colorTile(),
              //Bottom Space
              _bottomSpace(),
            ],
          ),
        ),
      ),
    );
  }

  ///INFO///
  Widget _infoTile() {
    return LightContainer(
      margin: 2.5,
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              'Type Info',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          _dividerHeavy(),
          _nameTextField(),
          _descriptionTextField(),
        ],
      ),
    );
  }

  Widget _nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: nameController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {});
          } else {
            setState(() {});
          }
        },
        style: const TextStyle(fontSize: 18),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Name',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextField(
        controller: descriptionController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {});
          } else {
            setState(() {});
          }
        },
        maxLines: 5,
        style: const TextStyle(fontSize: 16),
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          labelText: 'Description',
          labelStyle: const TextStyle(fontSize: 15, color: Colors.white),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: containerColor)),
        ),
      ),
    );
  }

  ///CAN CONTAIN///

  Widget _canContainTile() {
    return LightContainer(
      margin: 2.5,
      padding: 5,
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Can Contain',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                _canContainButtonBuilder(),
              ],
            ),
          ),
          _dividerHeavy(),
          _canContainListBuilder(),
        ],
      ),
    );
  }

  Widget _canContainListBuilder() {
    return Builder(builder: (context) {
      if (showCanContain) {
        return Column(
          children:
              containerTypes.map((e) => canContainCheckBoxTile(e)).toList(),
        );
      } else {
        return LightContainer(
          margin: 2.5,
          padding: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Number of containers: ' + canContainTypes.length.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      }
    });
  }

  Widget _canContainButtonBuilder() {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () {
          showCanContain = !showCanContain;
          setState(() {});
        },
        child: CustomOutlineContainer(
          height: 30,
          width: 80,
          child: Builder(builder: (context) {
            if (showCanContain) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'hide',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(Icons.arrow_drop_up)
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'show',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              );
            }
          }),
          outlineColor: containerColor,
        ),
      );
    });
  }

  Widget canContainCheckBoxTile(ContainerType canContainType) {
    return LightContainer(
      margin: 2.5,
      padding: 0,
      child: CustomOutlineContainer(
        margin: 2.5,
        padding: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  canContainType.containerType.capitalize(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Checkbox(
              fillColor: MaterialStateProperty.all(
                  Color(int.parse(canContainType.containerColor))
                      .withOpacity(1)),
              value: canContainTypes.contains(canContainType.containerType),
              onChanged: (value) {
                _onSelectedContainer(value!, canContainType.containerType);
              },
            ),
          ],
        ),
        outlineColor:
            Color(int.parse(canContainType.containerColor)).withOpacity(1),
      ),
    );
  }

  ///OPTIONS///

  Widget _optionsTile() {
    return LightContainer(
      margin: 2.5,
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              'Options',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          _dividerHeavy(),
          _moveableOption(),
          _isMarkerToChildrenOption(),
        ],
      ),
    );
  }

  Widget _moveableOption() {
    return LightContainer(
      margin: 2.5,
      padding: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Movable',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Checkbox(
            value: moveable,
            fillColor: MaterialStateProperty.all(containerColor),
            onChanged: (value) {
              moveable = value!;

              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _isMarkerToChildrenOption() {
    return LightContainer(
      margin: 2.5,
      padding: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Marker to Children',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Checkbox(
            value: markerToChildren,
            fillColor: MaterialStateProperty.all(containerColor),
            onChanged: (value) {
              markerToChildren = value!;

              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  ///COLOR///

  Widget _colorTile() {
    return LightContainer(
      margin: 2.5,
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              'Color',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          _dividerHeavy(),
          _changeColorButton(),
        ],
      ),
    );
  }

  Widget _changeColorButton() {
    return InkWell(
      onTap: () async {
        Color? newColor = await showColorDialog();
        if (newColor != null) {
          containerColor = newColor;
          log(containerColor.toString());
          setState(() {});
        }
      },
      child: CustomOutlineContainer(
        height: 50,
        outlineColor: containerColor,
        backgroundColor: containerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomOutlineContainer(
              height: 35,
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Change',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(Icons.color_lens)
                ],
              ),
              outlineColor: containerColor,
            ),
          ],
        ),
      ),
    );
  }

  Future showColorDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                // setState(() => currentColor = pickerColor);
                Navigator.pop(context, currentColor);
              },
              child: CustomOutlineContainer(
                  margin: 2.5,
                  padding: 5,
                  height: 35,
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'change',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  backgroundColor: containerColor,
                  outlineColor: containerColor),
            ),
          ],
        );
      },
    );
  }

  ///MISC///

  Widget _dividerHeavy() {
    return Divider(
      color: containerColor,
      thickness: 1,
      height: 10,
    );
  }

  Widget _bottomSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
    );
  }

  ///FUNCTIONS///

  void saveChanges() {
    if (nameController.text.isEmpty) {
      //If no name is entered revert to previous name;
      nameController.text = containerType.containerType;
    }

    if (descriptionController.text.isEmpty) {
      //If no description is entered revert to previous description;
      descriptionController.text = containerType.containerDescription;
    }

    log(containerColor.toString());
    isarDatabase!.writeTxnSync((isar) => isar.containerTypes.putSync(
        ContainerType()
          ..id = containerType.id
          ..containerType = nameController.text.toLowerCase()
          ..containerDescription = descriptionController.text
          ..canContain = canContainTypes
          ..containerColor = containerColor.value.toString()
          ..moveable = moveable
          ..markerToChilren = markerToChildren,
        replaceOnConflict: true));

    log(containerType.toString());
    Navigator.pop(context);
  }

  void _onSelectedContainer(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        canContainTypes.add(dataName);
      });
    } else {
      setState(() {
        canContainTypes.remove(dataName);
      });
    }
  }

  void changeColor(Color color) {
    setState(() {
      containerColor = color;
      pickerColor = color;
      currentColor = color;
    });
  }
}
