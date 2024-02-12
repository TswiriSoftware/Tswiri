import 'package:flutter/material.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/views/abstract_screen.dart';
import 'package:tswiri/widgets/form_fields/container_type_form_field.dart';
import 'package:tswiri/widgets/form_fields/scanner_form_field.dart';
import 'package:tswiri_database/collections/collections_export.dart';

class CreateContainerScreen extends ConsumerStatefulWidget {
  final CatalogedContainer? _parentContainer;

  const CreateContainerScreen({
    required CatalogedContainer? parentContainer,
    super.key,
  }) : _parentContainer = parentContainer;

  @override
  AbstractScreen<CreateContainerScreen> createState() =>
      _CreateContainerScreenState();
}

class _CreateContainerScreenState
    extends AbstractScreen<CreateContainerScreen> {
  late CatalogedContainer? _parentContainer;
  late ContainerType _containerType;
  late List<ContainerType> _validContainerTypes;
  CatalogedBarcode? _barcode = null;

  final _formKey = GlobalKey<FormState>();
  late final Map<String, dynamic> _initialState;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _barcodeFocusNode = FocusNode();

  ContainerType? get parentContainerType {
    return getContainerType(_parentContainer?.typeUUID);
  }

  ContainerType get preferredContainerType {
    return getContainerType(parentContainerType?.preferredChild) ??
        containerTypes.first;
  }

  bool get hasChanged {
    return _containerType != _initialState['containerType'] ||
        _nameController.text != _initialState['name'] ||
        _descriptionController.text != _initialState['description'] ||
        _barcode != _initialState['barcode'] ||
        _parentContainer != _initialState['parentContainer'];
  }

  @override
  void initState() {
    super.initState();
    _parentContainer = widget._parentContainer;
    _containerType = preferredContainerType;
    _validContainerTypes = containerTypes.where((type) {
      return parentContainerType?.canContain.contains(type.uuid) ?? true;
    }).toList();

    _initialState = {
      'containerType': _containerType,
      'name': _nameController.text,
      'description': _descriptionController.text,
      'barcode': _barcode,
      'parentContainer': _parentContainer,
    };
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Container'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async {
            if (hasChanged) {
              await _showDiscardChangesDialog();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ContainerTypeFormField(
                  containerTypes: _validContainerTypes,
                  initialValue: _containerType,
                  onSaved: (newValue) {
                    if (newValue == null) return;
                    setState(() {
                      _containerType = newValue;
                    });
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _containerType = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a container type';
                    }
                    return null;
                  },
                ),
                spacer,
                TextFormField(
                  focusNode: _nameFocusNode,
                  controller: _nameController,
                  onSaved: (newValue) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    _descriptionFocusNode.requestFocus();
                  },
                  autocorrect: true,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                spacer,
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  controller: _descriptionController,
                  autocorrect: true,
                  onFieldSubmitted: (value) {
                    _barcodeFocusNode.requestFocus();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                spacer,
                ScannerFormField<CatalogedBarcode>(
                  focusNode: _barcodeFocusNode,
                  validator: (value) {
                    if (value == null) {
                      return 'Please scan a barcode';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    // TODO: implement this.
                  },
                ),
                spacer,
                ScannerFormField<CatalogedBarcode>(
                  focusNode: _barcodeFocusNode,
                  validator: (value) {
                    if (value == null && _containerType.moveable) {
                      return 'Please scan a parent container';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Parent',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) {
                    if (newValue == null) return;

                    // setState(() {
                    //   parentContainer = newValue;
                    // });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Created')),
            );
          }

          // TODO: Save to db.
        },
        label: const Text('Create'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Future<void> _showDiscardChangesDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Discard changes?'),
          content: const Text(
            'Are you sure you want to discard your changes?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );
  }
}
