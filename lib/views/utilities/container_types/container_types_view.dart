import 'package:flutter/material.dart';
import 'package:sunbird/extentions/string_extentions.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:sunbird/views/utilities/container_types/container_type_editor/container_type_editor_view.dart';

class ContainerTypesView extends StatefulWidget {
  const ContainerTypesView({Key? key}) : super(key: key);

  @override
  State<ContainerTypesView> createState() => _ContainerTypesViewState();
}

class _ContainerTypesViewState extends State<ContainerTypesView> {
  late List<ContainerType> containerTypes =
      isar!.containerTypes.where().findAllSync();

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
        'Container Types',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      centerTitle: true,
    );
  }

  Widget _body() {
    return ListView.builder(
      itemCount: containerTypes.length,
      itemBuilder: (context, index) {
        return _containerTypeCard(containerTypes[index]);
      },
    );
  }

  Widget _containerTypeCard(ContainerType containerType) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContainerTypeEditorView(
              containerType: containerType,
            ),
          ),
        );

        setState(() {
          containerTypes = isar!.containerTypes.where().findAllSync();
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    containerType.containerTypeName.capitalizeFirstCharacter(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Icon(containerType.iconData),
                ],
              ),
              Divider(
                color: colorModeEnabled ? containerType.containerColor : null,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(containerType.containerDescription),
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    'Can contain: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  for (int x in containerType.canContain)
                    Text(
                        '${isar!.containerTypes.getSync(x)!.containerTypeName}, '),
                ],
              ),
              const Divider(),
              Text('Enclosing: ${containerType.enclosing}'),
              const Divider(),
              Text('Moveable: ${containerType.moveable}'),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: New ContainerType.

}
