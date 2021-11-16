import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDatabaseView extends StatefulWidget {
  const HiveDatabaseView({Key? key}) : super(key: key);

  @override
  _HiveDatabaseViewState createState() => _HiveDatabaseViewState();
}

class _HiveDatabaseViewState extends State<HiveDatabaseView> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            showMyAboutDialog(context, "Deleted Hive Database");
            Hive.box('testBox').clear();
            setState(() {});
          },
          child: const Icon(Icons.delete),
        ),
      ),
      body: FutureBuilder<List>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            List myList = snapshot.data ?? [];
            return ListView.builder(
                itemCount: myList.length,
                itemBuilder: (context, index) {
                  var text = myList[index].toString();
                  return Text(text);
                });
          }
        },

        //builder: (context, AsyncSnapshot snapshot) {
        // if (!snapshot.hasData) {
        //   return Center(child: CircularProgressIndicator());
        // } else {
        //   List myList = snapshot.data ?? [];
        //   ListView.builder(
        //       itemCount: myList.length,
        //       itemBuilder: (context, int index) {
        //         return Text('${snapshot.data[index].title}');
        //       });
        // }
        //}
      ),
    );
  }

  Future<List> loadData() async {
    List list = [];
    var box = await Hive.openBox('testBox');
    var data = box.toMap();
    data.forEach((key, value) {
      list.add([key, value]);
    });
    return list;
  }
}

//  ListView.builder(itemBuilder: (BuildContext ctxt, int index) {
//           return Text(list[index]);
//         }));

showMyAboutDialog(BuildContext context, String message) {
  // Create button
  Widget okButton = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange[500], fixedSize: Size(80, 35)),
        child: const Text(
          "Ok",
          style: TextStyle(fontSize: 15),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      message,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
