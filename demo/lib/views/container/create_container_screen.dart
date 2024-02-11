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
  late CatalogedContainer? parentContainer = widget._parentContainer;

  late ContainerType containerType;
  late List<ContainerType> validContainerTypes;

  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _barcodeFocusNode = FocusNode();

  ContainerType? get parentContainerType {
    return getContainerType(parentContainer?.typeUUID);
  }

  ContainerType get preferredContainerType {
    return getContainerType(parentContainerType?.preferredChild) ??
        containerTypes.first;
  }

  @override
  void initState() {
    super.initState();
    containerType = preferredContainerType;
    validContainerTypes = containerTypes.where((type) {
      return parentContainerType?.canContain.contains(type.uuid) ?? true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Container'),
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
                  containerTypes: validContainerTypes,
                  initialValue: containerType,
                  onSaved: (newValue) {
                    if (newValue == null) return;
                    setState(() {
                      containerType = newValue;
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
                ScannerFormField(
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
                ),
                spacer,
                ScannerFormField(
                  focusNode: _barcodeFocusNode,
                  validator: (value) {
                    if (value == null && containerType.moveable) {
                      return 'Please scan a parent container';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Parent',
                    border: OutlineInputBorder(),
                  ),
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
}
