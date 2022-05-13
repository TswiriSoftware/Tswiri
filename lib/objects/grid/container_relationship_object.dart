import 'package:flutter_google_ml_kit/functions/isar_functions/isar_functions.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_entry/container_entry.dart';
import 'package:flutter_google_ml_kit/isar_database/containers/container_relationship/container_relationship.dart';
import 'package:isar/isar.dart';

class ContainerRelationshipObject {
  ContainerRelationshipObject({required this.parentContainer});
  final ContainerEntry parentContainer;

  List<ContainerEntry> get children {
    List<ContainerRelationship> decendants = [];
    decendants.addAll(isarDatabase!.containerRelationships
        .filter()
        .parentUIDMatches(parentContainer.containerUID)
        .findAllSync());
    List<ContainerEntry> children = [];
    if (decendants.isNotEmpty) {
      children.addAll(isarDatabase!.containerEntrys
          .filter()
          .repeat(
              decendants,
              (q, ContainerRelationship element) =>
                  q.containerUIDMatches(element.containerUID))
          .findAllSync());
    }

    return children;
  }
}
