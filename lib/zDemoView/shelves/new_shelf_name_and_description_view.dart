import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/zDemoView/shelves/shelfFunctions/shelfProvider.dart';
import 'package:provider/provider.dart';

class ShelfNameAndDescriptionView extends StatefulWidget {
  const ShelfNameAndDescriptionView(
      {Key? key, required this.shelfName, required this.shelfDescription})
      : super(key: key);

  final String shelfName;
  final String shelfDescription;

  @override
  State<ShelfNameAndDescriptionView> createState() =>
      _ShelfNameAndDescriptionViewState();
}

class _ShelfNameAndDescriptionViewState
    extends State<ShelfNameAndDescriptionView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.shelfName == 'Name') {
      _nameController.text = '';
    } else {
      _nameController.text = widget.shelfName;
    }
    if (widget.shelfDescription == 'Description') {
      _descriptionController.text = '';
    } else {
      _descriptionController.text = widget.shelfDescription;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Shelf',
          style: TextStyle(fontSize: 25),
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(
              context, [_nameController.text, _descriptionController.text]),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Shelf Name:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                color: Colors.black38,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _nameController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  onFieldSubmitted: (name) {
                    _nameController.text = name;
                  },
                  // onTap: () {
                  //   FocusScope.of(context).unfocus();
                  // },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Shelf Description:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                color: Colors.black38,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  controller: _descriptionController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  onFieldSubmitted: (name) {
                    _nameController.text = name;
                  },
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context,
                        [_nameController.text, _descriptionController.text]);
                  },
                  child: const Text('continue'))
            ],
          ),
        ),
      ),
    );
  }
}
