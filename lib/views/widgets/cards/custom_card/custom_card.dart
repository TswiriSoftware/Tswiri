import 'dart:io';

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  ///The cards label.
  final String _label;

  ///The screen it loads.
  final Widget _viewPage;
  //
  final bool featureCompleted;

  ///The icon it displays
  final IconData _icon;

  ///The tile color.
  final Color tileColor;
  // ignore: use_key_in_widget_constructors
  const CustomCard(this._label, this._viewPage, this._icon,
      {this.featureCompleted = false, required this.tileColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(_label),
      elevation: 5,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        tileColor: tileColor,
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _label,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  _icon,
                  color: Colors.white,
                  size: 45,
                ),
              )
            ],
          ),
        ),
        onTap: () {
          if (Platform.isIOS && !featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('This feature has not been implemented for iOS yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}
