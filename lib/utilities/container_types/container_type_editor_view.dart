import 'package:flutter/material.dart';
import 'package:tswiri_database/embedded/embedded_color/embedded_color.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/embedded/get_color.dart';

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

  late int red = getColor(_containerType.containerColor.data!).red;
  late int blue = getColor(_containerType.containerColor.data!).blue;
  late int green = getColor(_containerType.containerColor.data!).green;

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
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          initialValue: _containerType.containerTypeName,
          onFieldSubmitted: (value) {
            setState(() {
              _containerType.containerTypeName = value;
            });
            _updateIsar();
          },
        ),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          initialValue: _containerType.containerDescription,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            setState(() {
              _containerType.containerDescription = value;
            });

            _updateIsar();
          },
          maxLines: null,
        ),
      ),
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
            Padding(
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
            const Divider(),
            Text(
              'Preferred Child',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
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
            const Divider(),
            Text(
              'Color',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Card(
              color: Color.fromRGBO(red, green, blue, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: red.toString(),
                          decoration: const InputDecoration(label: Text('Red')),
                          onFieldSubmitted: (value) {
                            setState(() {
                              red = int.tryParse(value) ?? red;
                            });
                            _updateColor();
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: green.toString(),
                          decoration:
                              const InputDecoration(label: Text('Green')),
                          onFieldSubmitted: (value) {
                            setState(() {
                              green = int.tryParse(value) ?? green;
                            });
                            _updateColor();
                          },
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: blue.toString(),
                          decoration:
                              const InputDecoration(label: Text('Blue')),
                          onFieldSubmitted: (value) {
                            setState(() {
                              blue = int.tryParse(value) ?? blue;
                            });
                            _updateColor();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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
      _containerType.containerColor = EmbeddedColor.fromColor(fromColor(color));
    });
    _updateIsar();
  }

  void _updateIsar() {
    isar!.writeTxnSync(() {
      isar!.containerTypes.putSync(
        _containerType,
      );
    });
  }
}
