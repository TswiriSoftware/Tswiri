import 'package:flutter/material.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_widgets/colors/colors.dart';
import 'package:tswiri_widgets/widgets/general/custom_text_field.dart';

class ContainerTypeEditorView extends StatefulWidget {
  const ContainerTypeEditorView({
    Key? key,
    required this.containerType,
  }) : super(key: key);

  final ContainerType containerType;

  @override
  State<ContainerTypeEditorView> createState() =>
      _ContainerTypeEditorViewState();
}

class _ContainerTypeEditorViewState extends State<ContainerTypeEditorView> {
  late final ContainerType _containerType = widget.containerType;
  late final List<ContainerType> _containerTypes =
      isar!.containerTypes.where().findAllSync();

  late int red = _containerType.containerColor.red;
  late int blue = _containerType.containerColor.blue;
  late int green = _containerType.containerColor.green;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        _containerType.containerTypeName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            _nameTextField(),
            _descriptionTextField(),
            _booleanOptions(),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return CustomTextField(
      label: 'name',
      initialValue: _containerType.containerTypeName,
      onSubmitted: (value) {
        setState(() {
          _containerType.containerTypeName = value;
        });

        _updateIsar();
      },
      backgroundColor: background[300]!,
      borderColor: tswiriOrange,
    );
  }

  Widget _descriptionTextField() {
    return CustomTextField(
      label: 'description',
      initialValue: _containerType.containerDescription,
      maxLines: 5,
      onSubmitted: (value) {
        setState(() {
          _containerType.containerDescription = value;
        });

        _updateIsar();
      },
      backgroundColor: background[300]!,
      borderColor: tswiriOrange,
    );
  }

  Widget _booleanOptions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Moveable',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Checkbox(
                  value: _containerType.moveable,
                  onChanged: (value) {
                    setState(() {
                      _containerType.moveable = value!;
                    });

                    _updateIsar();
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enclosing',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Checkbox(
                  value: _containerType.enclosing,
                  onChanged: (value) {
                    setState(() {
                      _containerType.enclosing = value!;
                    });

                    _updateIsar();
                  },
                ),
              ],
            ),
            const Divider(),
            Text(
              'Can Contain',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Card(
              color: background[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (ContainerType containerType in _containerTypes)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            containerType.containerTypeName,
                          ),
                          Checkbox(
                            value: _containerType.canContain
                                .contains(containerType.id),
                            onChanged: (value) {
                              List<int> canContain =
                                  List.from(_containerType.canContain);
                              if (_containerType.canContain
                                  .contains(containerType.id)) {
                                setState(() {
                                  canContain.remove(containerType.id);
                                  _containerType.canContain = canContain;
                                });
                              } else {
                                setState(() {
                                  canContain.add(containerType.id);
                                  _containerType.canContain = canContain;
                                });
                              }

                              _updateIsar();
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Text(
              'Preferred Child',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Card(
              color: background[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    for (ContainerType containerType in _containerTypes)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            containerType.containerTypeName,
                          ),
                          Checkbox(
                            value: _containerType.preferredChildContainer ==
                                containerType.id,
                            onChanged: (value) {
                              if (value == true) {
                                setState(() {
                                  _containerType.preferredChildContainer =
                                      containerType.id;
                                });
                              }
                              _updateIsar();
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Text(
              'Color',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Card(
              color: Color.fromRGBO(red, green, blue, 1.0),
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Red',
                    initialValue: red.toString(),
                    textInputType: TextInputType.number,
                    onSubmitted: (value) {
                      setState(() {
                        red = int.tryParse(value) ?? red;
                      });
                      _updateColor();
                    },
                    backgroundColor: background[300]!,
                    borderColor: tswiriOrange,
                  ),
                  CustomTextField(
                    label: 'Green',
                    initialValue: blue.toString(),
                    textInputType: TextInputType.number,
                    onSubmitted: (value) {
                      setState(() {
                        green = int.tryParse(value) ?? green;
                      });
                      _updateColor();
                    },
                    backgroundColor: background[300]!,
                    borderColor: tswiriOrange,
                  ),
                  CustomTextField(
                    label: 'Blue',
                    initialValue: green.toString(),
                    textInputType: TextInputType.number,
                    onSubmitted: (value) {
                      setState(() {
                        blue = int.tryParse(value) ?? blue;
                      });
                      _updateColor();
                    },
                    backgroundColor: background[300]!,
                    borderColor: tswiriOrange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //TODO: Implement Icon Picker.

  void _updateColor() {
    Color color = Color.fromRGBO(red, green, blue, 1.0);
    setState(() {
      _containerType.containerColor = color;
    });
    _updateIsar();
  }

  void _updateIsar() {
    isar!.writeTxnSync((isar) {
      isar.containerTypes.putSync(_containerType, replaceOnConflict: true);
    });
  }
}
