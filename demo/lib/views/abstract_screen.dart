import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/settings/settings.dart';
import 'package:tswiri_database/space.dart';

abstract class AbstractScreen<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  Settings get settings => ref.read(settingsProvider);

  /// The current space.
  Space get space => ref.read(spaceProvider);

  /// The Isar instance for the current space.
  Isar get isar {
    assert(
      space.isLoaded,
      'Space is not loaded',
    );
    return space.db!;
  }
}
