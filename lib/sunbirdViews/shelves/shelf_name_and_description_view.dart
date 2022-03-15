import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/padded_margin_light_container.dart';

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
  //Name controller.
  final TextEditingController _nameController = TextEditingController();
  //Description contoller.
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: BasicLightContainer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Shelf Name:',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.black38,
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _nameController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onFieldSubmitted: (name) {
                  _nameController.text = name;
                },
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
                minLines: 1,
                controller: _descriptionController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onFieldSubmitted: (name) {
                  _nameController.text = name;
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
        )),
      ),
    );
  }
}
