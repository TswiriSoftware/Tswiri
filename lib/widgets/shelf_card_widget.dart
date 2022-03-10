import 'package:flutter/material.dart';

import '../databaseAdapters/shelfAdapter/shelf_entry.dart';

class ShelfCard extends StatelessWidget {
  const ShelfCard({Key? key, required this.shelfEntry}) : super(key: key);

  final ShelfEntry shelfEntry;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5, left: 3, right: 3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.grey[800],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: (MediaQuery.of(context).size.width * 0.10),
                    decoration: const BoxDecoration(
                        color: Colors.deepOrange, shape: BoxShape.circle),
                    child: Center(
                      child: Text(shelfEntry.uid.toString()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name:  ' + shelfEntry.name,
                          style: const TextStyle(fontSize: 17),
                        ),
                        Text(
                          'Desc: ' + shelfEntry.description,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
