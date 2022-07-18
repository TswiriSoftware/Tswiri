import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sunbird_v2/views/areas/new_area_view.dart';

class NewAreaCard extends StatelessWidget {
  const NewAreaCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewAreaView()));
      },
      child: Tooltip(
        message: 'Creates a new area',
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '(New Area)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
