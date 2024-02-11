import 'package:isar/isar.dart';
import 'package:tswiri/providers.dart';
import 'package:tswiri/settings/settings.dart';
import 'package:tswiri_database/collections/collections_export.dart';
import 'package:tswiri_database/space.dart';

abstract class AbstractScreen<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> {
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

  /// The list of all container types in the current space.
  List<ContainerType> get containerTypes {
    return isar.containerTypes.where().findAllSync();
  }

  /// Get the container type with the given UUID.
  ContainerType? getContainerType(String? typeUUID) {
    if (typeUUID == null) return null;
    return isar.containerTypes.filter().uuidMatches(typeUUID).findFirstSync();
  }
}
