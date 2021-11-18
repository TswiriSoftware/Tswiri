import 'package:flutter/material.dart';

showMyAboutDialog(BuildContext context, String message) {
  // Create button
  Widget okButton = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange[500], fixedSize: const Size(80, 35)),
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
