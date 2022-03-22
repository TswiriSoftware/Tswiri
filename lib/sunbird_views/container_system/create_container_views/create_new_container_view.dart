import 'package:flutter/material.dart';
import 'package:flutter_google_ml_kit/widgets/container_widgets/stateless_container_display_widgets/create_new_container_description_widget.dart';
import 'package:isar/isar.dart';

import 'container_batch_create_view.dart';
import 'container_single_create_view.dart';

class CreateNewContainerView extends StatefulWidget {
  const CreateNewContainerView({Key? key, required this.database})
      : super(key: key);
  final Isar database;
  @override
  State<CreateNewContainerView> createState() => _CreateNewContainerViewState();
}

class _CreateNewContainerViewState extends State<CreateNewContainerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create',
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                //TODO: Info Dialog => Single Create VS batch Create.
              },
              icon: const Icon(Icons.info_outline_rounded))
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Single Create.
            _singleCreate(),
            //Batch Create
            _batchCreate(),
          ],
        ),
      ),
    );
  }

  Widget _singleCreate() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          (MaterialPageRoute(
            builder: (context) => SingleContainerCreateView(
              database: widget.database,
            ),
          )),
        );
        Navigator.pop(context);
      },
      child: const DescriptionWidget(
        name: 'Create Single',
        description:
            '- Create a single container.\n- Select a parent.\n- Generate \n OR\n- Scan a barcode the container',
      ),
    );
  }

  Widget _batchCreate() {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          (MaterialPageRoute(
            builder: (context) => BatchContainerCreateView(
              database: widget.database,
            ),
          )),
        );
        Navigator.pop(context);
      },
      child: const DescriptionWidget(
        name: 'Batch create',
        description:
            '- Create multiple containers.\n- Select a parent.\n- Generate \n OR\n- Scan barcodes for these containers',
      ),
    );
  }
}
