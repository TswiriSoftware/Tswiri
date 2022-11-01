import 'package:flutter/material.dart';
import 'package:tswiri/add/add_container_view.dart';
import 'package:tswiri/navigation_widgets/open_list_tile.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => AddViewState();
}

class AddViewState extends State<AddView> {
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
      elevation: 10,
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          OpenListTile(
            title: 'Add Container',
            trailingIconData: Icons.add_rounded,
            destination: AddContainerView(),
          ),
        ],
      ),
    );
  }
}
