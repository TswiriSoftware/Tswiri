import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/settings/settings.dart';
import 'package:tswiri_database/space.dart';

abstract class AbstractScreen<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  Settings get settings => ref.read(settingsProvider);
  Space get space => ref.read(spaceProvider);
  Isar? get isar => space.db;
}
