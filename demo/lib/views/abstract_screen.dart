import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/settings/settings.dart';
import 'package:tswiri_database/space.dart';
export 'package:isar/isar.dart';

abstract class AbstractScreen<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
  Settings get settings => ref.read(settingsProvider);

  /// The current space.
  Space get space => ref.read(spaceProvider);

  /// The Isar instance for the current space.
  Isar get db {
    assert(
      space.isLoaded,
      'Space is not loaded',
    );
    return space.db!;
  }

  Future<bool> showConfirmDialog({
    required String title,
    required String content,
    String negative = 'OK',
    String positive = 'Cancel',
  }) async {
    final value = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(negative),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(positive),
            ),
          ],
        );
      },
    );

    return value ?? false;
  }

  Future<void> showInfoDialog({
    required String title,
    required String content,
    String okText = 'Ok',
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(okText),
            ),
          ],
        );
      },
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        showCloseIcon: true,
      ),
    );
  }
}
