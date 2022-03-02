import '../databaseAdapters/allBarcodes/barcode_entry.dart';
import '../databaseAdapters/calibrationAdapters/distance_from_camera_lookup_entry.dart';
import '../databaseAdapters/scanningAdapters/real_barocode_position_entry.dart';
import '../databaseAdapters/tagAdapters/barcode_tag_entry.dart';
import '../databaseAdapters/tagAdapters/tag_entry.dart';
import '../databaseAdapters/barcodePhotos/barcode_photo_entry.dart';

///Contains all real positional data as [RealBarcodePostionEntry]
const String realPositionsBoxName = 'realPositionsBox';

///Contains camera calibration data as [DistanceFromCameraLookupEntry].
const String distanceLookupTableBoxName = 'distanceLookupTableBox';

///Contains barcode tags as [BarcodeTagEntry].
const String barcodeTagsBoxName = 'barcodeTagsBox';

///Contains all barcodes tags as [TagEntry].
const String tagsBoxName = 'tagsBox';

///Contains all barcodes that have been generated as [BarcodeDataEntry].
const String allBarcodesBoxName = 'allBarcodesBox';

///Contains all barcodes Photos as [BarcodePhotoEntry].
const String barcodePhotosBoxName = 'barcodePhotos';
