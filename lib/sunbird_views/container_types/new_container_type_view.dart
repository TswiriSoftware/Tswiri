import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_google_ml_kit/extentions/capitalize_first_character.dart';
import 'package:flutter_google_ml_kit/functions/keyboard_functions/hide_keyboard.dart';
import 'package:flutter_google_ml_kit/isar_database/container_type/container_type.dart';
import 'package:flutter_google_ml_kit/isar_database/functions/isar_functions.dart';

import 'package:isar/isar.dart';

import '../../widgets/basic_outline_containers/custom_outline_container.dart';
import '../../widgets/basic_outline_containers/light_container.dart';

class NewContainerTypeView extends StatefulWidget {
  const NewContainerTypeView({Key? key}) : super(key: key);

  @override
  State<NewContainerTypeView> createState() => _NewContainerTypeViewState();
}

class _NewContainerTypeViewState extends State<NewContainerTypeView> {
  String? newContainerType;
  Color? newContainerColor;
  Color pickerColor = Colors.deepOrange;
  Color currentColor = Colors.deepOrange;
  bool moveable = false;
  bool markerToChildren = false;
  bool canContainSelf = false;

  late List<ContainerType> containerTypes;
  List<String> canContainTypes = [];
  bool showCanContain = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    containerTypes = isarDatabase!.containerTypes.where().findAllSync();
    nameController.text = '';
    descriptionController.text = '';
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
            newContainerType ?? 'New Container Type',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: newContainerColor ?? Colors.deepOrange,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              createType();
            },
            backgroundColor: newContainerColor ?? Colors.deepOrange,
            label: Text(
              'Create',
              style: Theme.of(context).textTheme.labelMedium,
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //INFO.
              _infoTile(),
              //CAN CONTAIN.
              _canContainTile(),
              //OPTIONS.
              _optionsTile(),
              //COLOR.
              _colorTile(),
              //BOTTOM SPACE.
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
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
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
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: newContainerColor ?? Colors.deepOrange)),
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
          children: [
            _canContainSelf(),
            Column(
              children:
                  containerTypes.map((e) => canContainCheckBoxTile(e)).toList(),
            ),
          ],
        );
      } else {
        return Row();
      }
    });
  }

  Widget _canContainSelf() {
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
                  'Can contain self',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Checkbox(
              value: canContainSelf,
              fillColor: MaterialStateProperty.all(
                  newContainerColor ?? Colors.deepOrange),
              onChanged: (value) {
                setState(() {
                  canContainSelf = value!;
                });
              },
            ),
          ],
        ),
        outlineColor: newContainerColor ?? Colors.deepOrange,
      ),
    );
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
          outlineColor: newContainerColor ?? Colors.deepOrange,
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
              value: canContainTypes.contains(canContainType.containerType),
              fillColor: MaterialStateProperty.all(
                  Color(int.parse(canContainType.containerColor))
                      .withOpacity(1)),
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
            fillColor: MaterialStateProperty.all(
                newContainerColor ?? Colors.deepOrange),
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
            fillColor: MaterialStateProperty.all(
                newContainerColor ?? Colors.deepOrange),
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
          newContainerColor = newColor;

          setState(() {});
        }
      },
      child: CustomOutlineContainer(
        height: 50,
        outlineColor: newContainerColor ?? Colors.deepOrange,
        backgroundColor: newContainerColor ?? Colors.deepOrange,
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
              outlineColor: newContainerColor ?? Colors.deepOrange,
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
                  backgroundColor: newContainerColor ?? Colors.deepOrange,
                  outlineColor: newContainerColor ?? Colors.deepOrange),
            ),
          ],
        );
      },
    );
  }

  ///MISC///

  Widget _dividerHeavy() {
    return Divider(
      color: newContainerColor ?? Colors.deepOrange,
      thickness: 1,
      height: 10,
    );
  }

  Widget _bottomSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 10,
    );
  }

  SnackBar snackBar(String error) {
    return SnackBar(
      duration: const Duration(milliseconds: 500),
      content: Text(error),
    );
  }

  ///FUNCTIONS///

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
      newContainerColor = color;
      pickerColor = color;
      currentColor = color;
    });
  }

  void createType() {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Please enter a name'));
    } else if (canContainTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          'Please select at least one Can Contain (other than self).'));
    } else if (newContainerColor == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar('Please select a custom color.'));
    } else {
      if (canContainSelf) {
        canContainTypes.add(nameController.text.toLowerCase());
      }
      ContainerType newContainerType = ContainerType()
        ..containerType = nameController.text.toLowerCase()
        ..containerDescription = descriptionController.text
        ..containerColor = newContainerColor!.value.toString()
        ..moveable = moveable
        ..markerToChilren = markerToChildren
        ..canContain = canContainTypes;

      if (isarDatabase!.containerTypes
              .filter()
              .containerTypeMatches(nameController.text.toLowerCase())
              .findFirstSync() ==
          null) {
        isarDatabase!.writeTxnSync(
            (isar) => isar.containerTypes.putSync(newContainerType));
        Navigator.pop(context);
        //Write to isar
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar('Type already exists.'));
      }
    }
  }
}
