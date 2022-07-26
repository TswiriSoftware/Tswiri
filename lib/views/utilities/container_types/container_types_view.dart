import 'package:flutter/material.dart';
import 'package:sunbird/extentions/string_extentions.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';

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
    return Card(
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(
      //     color: Color(int.parse(containerType.containerColor)),
      //     width: 0.4,
      //   ),
      //   borderRadius: BorderRadius.circular(10),
      // ),
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
            Text('Contains: ${containerType.canContain}'),
            Text('Enclosing: ${containerType.enclosing}'),
          ],
        ),
      ),
    );
  }
}
