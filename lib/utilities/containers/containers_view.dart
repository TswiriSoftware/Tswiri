import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tswiri/utilities/containers/container_type_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';
import 'package:tswiri_database_interface/functions/embedded/get_icon_data.dart';

import 'package:tswiri_database_interface/models/container_manager/container_manager.dart';
import 'package:tswiri_theme/transitions/left_to_right_transition.dart';

class ContainersView extends StatefulWidget {
  const ContainersView({Key? key}) : super(key: key);

  @override
  State<ContainersView> createState() => ContainersViewState();
}

class ContainersViewState extends State<ContainersView> {
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
      title: const Text('Containers'),
      centerTitle: true,
      elevation: 10,
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: Provider.of<ContainerManager>(context).containerTypes.length,
      itemBuilder: (context, index) {
        ContainerType containerType =
            Provider.of<ContainerManager>(context).containerTypes[index];
        return Card(
          elevation: 5,
          child: ListTile(
            title: Text(containerType.containerTypeName),
            subtitle: Text(
              'Number: ${getCatalogedContainersSync(containerTypeID: containerType.id).length}',
              //isar!.catalogedContainers.filter().containerTypeIDEqualTo(containerType.id).findAllSync().length
            ),
            trailing: Icon(getIconData(containerType.iconData.data!)),
            onTap: () {
              Navigator.of(context).push(
                leftToRightTransition(
                  ContainerTypeView(containerType: containerType),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
