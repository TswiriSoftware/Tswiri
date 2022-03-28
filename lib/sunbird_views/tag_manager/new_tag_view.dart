import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/dark_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/light_container.dart';
import 'package:flutter_google_ml_kit/widgets/basic_outline_containers/orange_outline_container.dart';

class NewTagView extends StatefulWidget {
  const NewTagView({Key? key}) : super(key: key);

  @override
  State<NewTagView> createState() => _NewTagViewState();
}

class _NewTagViewState extends State<NewTagView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('New Tag(s)', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          LightContainer(
            margin: 2.5,
            padding: 0,
            child: OrangeOutlineContainer(
              margin: 2.5,
              padding: 5,
              child: TextField(),
            ),
          ),
        ],
      ),
    );
  }
}
