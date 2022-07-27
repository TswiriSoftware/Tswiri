import 'dart:developer';
import 'dart:ui';

import 'package:sunbird/classes/display_point.dart';
import 'package:sunbird/classes/inter_barcode_vector.dart';
import 'package:sunbird/classes/on_image_inter_barcode_data.dart';
import 'package:sunbird/functions/data_processing.dart';
import 'package:sunbird/globals/globals_export.dart';
import 'package:sunbird/isar/isar_database.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

class GridController {
  GridController({
    required this.gridUID,
  });

  int gridUID;

  late List<Marker> markers = findGridMarkers();

  void processData(List<dynamic> barcodeDataBatches) {
    //1. Get the Cataloged Barcodes.
    List<CatalogedBarcode> barcodeProperties =
        isar!.catalogedBarcodes.where().findAllSync();

    //2. Create the onImageBarcodeData.
    List<OnImageInterBarcodeData> onImageInterBarcodeData =
        createOnImageBarcodeData(
      barcodeDataBatches,
    );

    //3. Create the InterBarcodeVectors.
    List<InterBarcodeVector> interBarcodeVectors = createInterbarcodeVectors(
      onImageInterBarcodeData,
      barcodeProperties,
      focalLength,
    );

    //4. Average the InterBarcodeVectors.
    List<InterBarcodeVector> finalRealInterBarcodeData =
        averageInterbarcodeData(
      interBarcodeVectors,
    );

    //5. Generate CatalogedCoordinates.
    List<CatalogedCoordinate> coordinates = generateCoordinates(
      gridUID,
      finalRealInterBarcodeData,
    );

    //6. Create/Update Coordinates.
    isar!.writeTxnSync((isar) {
      for (var coordinate in coordinates) {
        //1. detele IT if IT exists.
        isar.catalogedCoordinates
            .filter()
            .barcodeUIDMatches(coordinate.barcodeUID)
            .deleteAllSync();

        //2. input IT.
        isar.catalogedCoordinates.putSync(coordinate);
      }
    });

    log(isar!.catalogedCoordinates.where().findAllSync().toString());
  }

  ///Calculates a list of [DisplayPoint] to draw.
  List<DisplayPoint> calculateDisplayPoints(
    Size size,
    String? selectedBarcodeUID,
  ) {
    //1. Find all the coordinates in the grid.
    List<CatalogedCoordinate> coordinates = isar!.catalogedCoordinates
        .filter()
        .gridUIDEqualTo(gridUID)
        .findAllSync();

    // log(coordinates.toString());

    //2. Calcualte the unitOffset to use.
    Offset unitOffset = calculateUnitVectors(
      coordinateEntries: coordinates,
      width: size.width,
      height: size.height,
    );

    //3. List of all marker barcodeUIDs.
    List<String> markerBarcodeUIDs =
        isar!.markers.where().findAllSync().map((e) => e.barcodeUID).toList();

    List<DisplayPoint> myPoints = [];

    for (var i = 0; i < coordinates.length; i++) {
      CatalogedCoordinate catalogedCoordinate = coordinates.elementAt(i);

      if (catalogedCoordinate.coordinate != null) {
        Offset barcodePosition = Offset(
            (catalogedCoordinate.coordinate!.x * unitOffset.dx) +
                (size.width / 2) -
                (size.width / 8),
            (catalogedCoordinate.coordinate!.y * unitOffset.dy) +
                (size.height / 2) -
                (size.height / 8));

        List<String> barcodeRealPosition = [
          catalogedCoordinate.coordinate!.x.toStringAsFixed(4),
          catalogedCoordinate.coordinate!.y.toStringAsFixed(4),
          catalogedCoordinate.coordinate!.z.toStringAsFixed(4),
        ];

        DisplayPointType displayPointType = DisplayPointType.unkown;

        CatalogedContainer? container = isar!.catalogedContainers
            .filter()
            .barcodeUIDMatches(catalogedCoordinate.barcodeUID)
            .findFirstSync();

        if (container != null) {
          displayPointType = DisplayPointType.normal;
        }

        if (markerBarcodeUIDs.contains(catalogedCoordinate.barcodeUID)) {
          displayPointType = DisplayPointType.marker;
        }

        if (catalogedCoordinate.barcodeUID == selectedBarcodeUID) {
          displayPointType = DisplayPointType.selected;
        }

        myPoints.add(
          DisplayPoint(
            barcodeUID: catalogedCoordinate.barcodeUID,
            screenPosition: barcodePosition,
            realPosition: barcodeRealPosition,
            type: displayPointType,
          ),
        );
      }
    }
    return myPoints;
  }

  ///Finds all the markers of a given GridUID.
  List<Marker> findGridMarkers() {
    //If you have a grid id.
    List<CatalogedCoordinate> catalogedCoordinates = isar!.catalogedCoordinates
        .filter()
        .gridUIDEqualTo(gridUID)
        .findAllSync();

    if (catalogedCoordinates.isNotEmpty) {
      return isar!.markers
          .filter()
          .repeat(catalogedCoordinates,
              (q, CatalogedCoordinate e) => q.barcodeUIDMatches(e.barcodeUID))
          .findAllSync();
    } else {
      //No Coordinates found so create a marker from the grid barcode.
      CatalogedCoordinate catalogedCoordinate = CatalogedCoordinate()
        ..barcodeUID = isar!.catalogedGrids.getSync(gridUID)!.barcodeUID
        ..coordinate = vm.Vector3(0, 0, 0)
        ..gridUID = gridUID
        ..rotation = null
        ..timestamp = DateTime.now().millisecondsSinceEpoch;

      isar!.writeTxnSync(
          (isar) => isar.catalogedCoordinates.putSync(catalogedCoordinate));

      Marker marker = isar!.markers
          .filter()
          .barcodeUIDMatches(isar!.catalogedGrids.getSync(gridUID)!.barcodeUID)
          .findFirstSync()!;

      return [marker];
    }
  }
}

// ///Finds the origin container of a [CatalogedContainer]
// ///  _____              _____
// /// |     |     /\        |     |\   |
// /// |_____|    /__\       |     | \  |
// /// |         /    \      |     |  \ |
// /// |        /      \   __|__   |   \|
// ///
// ///
// ///           |
// ///           |
// ///       \   |   /
// ///        \  |  /
// ///         \ | /
// ///          \ /
// ///
// ///

// CatalogedContainer findOriginContainer(
//     CatalogedContainer catalogedContainer) {
//   //hOw tO fInD tHe OrIgIn CoNtAiNeR ???
//   //THINK.

//   //1. Check if any Grids exist
//   List<CatalogedCoordinate> catalogedCoordinates =
//       isar!.catalogedCoordinates.where().findAllSync();

//   if (catalogedCoordinates.isEmpty) {
//     //No Grids exist yet.
//     //Check if this container is linked to a marker.

//     Marker? marker = isar!.markers
//         .filter()
//         .parentContainerUIDMatches(catalogedContainer.containerUID)
//         .findFirstSync();

//     if (marker != null) {
//       //This container is a marker.
//       return catalogedContainer;
//     } else {
//       //This container is not a marker.
//       //Check if parent is a marker.
//       ContainerRelationship? containerRelationship = isar!
//           .containerRelationships
//           .filter()
//           .containerUIDMatches(catalogedContainer.containerUID)
//           .findFirstSync();

//       if (containerRelationship != null) {
//         //Has Parent.
//         CatalogedContainer parentContainer = isar!.catalogedContainers
//             .filter()
//             .containerUIDMatches(containerRelationship.parentUID!)
//             .findFirstSync()!;

//         Marker? parentMarker = isar!.markers
//             .filter()
//             .parentContainerUIDMatches(containerRelationship.parentUID!)
//             .findFirstSync();

//         if (parentMarker != null) {
//           //Parent is marker.
//           return parentContainer;
//         } else {
//           //Parent is not marker.
//           return catalogedContainer;
//         }
//       } else {
//         //Does not have parent.
//         return catalogedContainer;
//       }
//     }

//     // return catalogedContainer;
//   } else {
//     //No Grids do exist.
//     return catalogedContainer;
//   }
// }
