import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:tswiri/utilities/grid/grid_view.dart';
import 'package:tswiri/utilities/grid/new_grid_view.dart';
import 'package:tswiri_database/export.dart';
import 'package:tswiri_database/tswiri_database.dart';

class GridsView extends StatefulWidget {
  const GridsView({Key? key}) : super(key: key);

  @override
  State<GridsView> createState() => GridsViewState();
}

class GridsViewState extends State<GridsView> {
  late List<CatalogedGrid> grids = getCatalogedGridsSync();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _newGrid(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Grids'),
      centerTitle: true,
      elevation: 10,
    );
  }

  ListView _body() {
    return ListView.builder(
      itemCount: grids.length,
      itemBuilder: (context, index) {
        return _gridCard(grids[index]);
      },
    );
  }

  Widget _gridCard(CatalogedGrid grid) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          child: ListTile(
            trailing: Text(grid.id.toString()),
            title: const Text('Grid'),
            subtitle: Text(
                'Children: ${getCatalogedCoordinatesSync(gridUID: grid.id).length}'),
          ),
        );
      },
      openBuilder: (context, action) {
        return GridViewer(
          grid: grid,
        );
      },
      onClosed: (data) {
        setState(() {
          grids = getCatalogedGridsSync();
        });
      },
    );
  }

  Widget _newGrid() {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedBuilder: (context, action) {
        return FloatingActionButton.extended(
          onPressed: action,
          label: const Text('Grid'),
          icon: const Icon(Icons.add_rounded),
        );
      },
      openBuilder: (context, action) {
        return const NewGridView();
      },
      onClosed: (data) {
        setState(() {
          grids = getCatalogedGridsSync();
        });
      },
    );
  }
}
