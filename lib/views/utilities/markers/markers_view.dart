import 'package:flutter/material.dart';
import 'package:sunbird/isar/isar_database.dart';

class MarkersView extends StatefulWidget {
  const MarkersView({Key? key}) : super(key: key);

  @override
  State<MarkersView> createState() => _MarkersViewState();
}

class _MarkersViewState extends State<MarkersView> {
  late List<Marker> markers = isar!.markers.where().findAllSync();

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
          'Markers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true);
  }

  Widget _body() {
    return ListView.builder(
      itemCount: markers.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _newMarkerBatch();
        } else {
          return _markerCard(markers[index - 1]);
        }
      },
    );
  }

  Widget _newMarkerBatch() {
    return InkWell(
      onTap: () {
        //TODO: implement marker scanner. ??
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '+',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '(new marker batch)',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _markerCard(Marker marker) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'BarcodeUID: ${marker.barcodeUID}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Divider(),
            marker.containerUID != null
                ? Text(
                    'ContainerUID: ${marker.containerUID}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
