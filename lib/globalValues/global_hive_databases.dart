import '../databaseAdapters/allBarcodes/barcode_data_entry.dart';
import '../databaseAdapters/barcodePhotoAdapter/barcode_photo_entry.dart';
import '../databaseAdapters/calibrationAdapter/distance_from_camera_lookup_entry.dart';
import '../databaseAdapters/containerAdapter/container_entry_adapter.dart';
import '../databaseAdapters/scanningAdapter/real_barcode_position_entry.dart';
import '../databaseAdapters/shelfAdapter/shelf_entry.dart';
import '../databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import '../databaseAdapters/tagAdapters/tag_entry.dart';

///Contains all real positional data as [RealBarcodePositionEntry]
const String realPositionsBoxName = 'realPositionsBox';

///Contains camera calibration data as [DistanceFromCameraLookupEntry].
const String distanceLookupTableBoxName = 'distanceLookupTableBox';

///Contains barcode tags as [BarcodeTagEntry].
const String barcodeTagsBoxName = 'barcodeTagsBox';

///Contains all barcodes tags as [TagEntry].
const String tagsBoxName = 'tagsBox';

///Contains all barcodes that have been generated as [BarcodeDataEntry].
const String allBarcodesBoxName = 'allBarcodesBox';

///Contains all barcodes Photos as [BarcodePhotosEntry].
const String barcodePhotosBoxName = 'barcodePhotosBox';

///Contains all barcodes Photos as [ShelfEntry].
const String shelvesBoxName = 'shelvesBox';

///Contains all containers [ContainerEntryOLD].
const String containersBoxName = 'containersBox';
