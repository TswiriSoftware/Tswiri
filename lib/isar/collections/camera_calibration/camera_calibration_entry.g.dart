// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'camera_calibration_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCameraCalibrationEntryCollection on Isar {
  IsarCollection<CameraCalibrationEntry> get cameraCalibrationEntrys =>
      getCollection();
}

const CameraCalibrationEntrySchema = CollectionSchema(
  name: 'CameraCalibrationEntry',
  schema:
      '{"name":"CameraCalibrationEntry","idName":"id","properties":[{"name":"diagonalSize","type":"Double"},{"name":"distanceFromCamera","type":"Double"},{"name":"hashCode","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'diagonalSize': 0, 'distanceFromCamera': 1, 'hashCode': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _cameraCalibrationEntryGetId,
  setId: _cameraCalibrationEntrySetId,
  getLinks: _cameraCalibrationEntryGetLinks,
  attachLinks: _cameraCalibrationEntryAttachLinks,
  serializeNative: _cameraCalibrationEntrySerializeNative,
  deserializeNative: _cameraCalibrationEntryDeserializeNative,
  deserializePropNative: _cameraCalibrationEntryDeserializePropNative,
  serializeWeb: _cameraCalibrationEntrySerializeWeb,
  deserializeWeb: _cameraCalibrationEntryDeserializeWeb,
  deserializePropWeb: _cameraCalibrationEntryDeserializePropWeb,
  version: 3,
);

int? _cameraCalibrationEntryGetId(CameraCalibrationEntry object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _cameraCalibrationEntrySetId(CameraCalibrationEntry object, int id) {
  object.id = id;
}

List<IsarLinkBase> _cameraCalibrationEntryGetLinks(
    CameraCalibrationEntry object) {
  return [];
}

void _cameraCalibrationEntrySerializeNative(
    IsarCollection<CameraCalibrationEntry> collection,
    IsarRawObject rawObj,
    CameraCalibrationEntry object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.diagonalSize;
  final _diagonalSize = value0;
  final value1 = object.distanceFromCamera;
  final _distanceFromCamera = value1;
  final value2 = object.hashCode;
  final _hashCode = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDouble(offsets[0], _diagonalSize);
  writer.writeDouble(offsets[1], _distanceFromCamera);
  writer.writeLong(offsets[2], _hashCode);
}

CameraCalibrationEntry _cameraCalibrationEntryDeserializeNative(
    IsarCollection<CameraCalibrationEntry> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CameraCalibrationEntry();
  object.diagonalSize = reader.readDouble(offsets[0]);
  object.distanceFromCamera = reader.readDouble(offsets[1]);
  object.id = id;
  return object;
}

P _cameraCalibrationEntryDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _cameraCalibrationEntrySerializeWeb(
    IsarCollection<CameraCalibrationEntry> collection,
    CameraCalibrationEntry object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'diagonalSize', object.diagonalSize);
  IsarNative.jsObjectSet(
      jsObj, 'distanceFromCamera', object.distanceFromCamera);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  return jsObj;
}

CameraCalibrationEntry _cameraCalibrationEntryDeserializeWeb(
    IsarCollection<CameraCalibrationEntry> collection, dynamic jsObj) {
  final object = CameraCalibrationEntry();
  object.diagonalSize =
      IsarNative.jsObjectGet(jsObj, 'diagonalSize') ?? double.negativeInfinity;
  object.distanceFromCamera =
      IsarNative.jsObjectGet(jsObj, 'distanceFromCamera') ??
          double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _cameraCalibrationEntryDeserializePropWeb<P>(
    Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'diagonalSize':
      return (IsarNative.jsObjectGet(jsObj, 'diagonalSize') ??
          double.negativeInfinity) as P;
    case 'distanceFromCamera':
      return (IsarNative.jsObjectGet(jsObj, 'distanceFromCamera') ??
          double.negativeInfinity) as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _cameraCalibrationEntryAttachLinks(
    IsarCollection col, int id, CameraCalibrationEntry object) {}

extension CameraCalibrationEntryQueryWhereSort
    on QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QWhere> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CameraCalibrationEntryQueryWhere on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QWhereClause> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension CameraCalibrationEntryQueryFilter on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QFilterCondition> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'diagonalSize',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'diagonalSize',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'diagonalSize',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> distanceFromCameraGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'distanceFromCamera',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> distanceFromCameraLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'distanceFromCamera',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
          QAfterFilterCondition>
      distanceFromCameraBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'distanceFromCamera',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hashCode',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension CameraCalibrationEntryQueryLinks on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QFilterCondition> {}

extension CameraCalibrationEntryQueryWhereSortBy
    on QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QSortBy> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDiagonalSize() {
    return addSortByInternal('diagonalSize', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDiagonalSizeDesc() {
    return addSortByInternal('diagonalSize', Sort.desc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDistanceFromCamera() {
    return addSortByInternal('distanceFromCamera', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDistanceFromCameraDesc() {
    return addSortByInternal('distanceFromCamera', Sort.desc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension CameraCalibrationEntryQueryWhereSortThenBy on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QSortThenBy> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDiagonalSize() {
    return addSortByInternal('diagonalSize', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDiagonalSizeDesc() {
    return addSortByInternal('diagonalSize', Sort.desc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDistanceFromCamera() {
    return addSortByInternal('distanceFromCamera', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDistanceFromCameraDesc() {
    return addSortByInternal('distanceFromCamera', Sort.desc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension CameraCalibrationEntryQueryWhereDistinct
    on QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctByDiagonalSize() {
    return addDistinctByInternal('diagonalSize');
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctByDistanceFromCamera() {
    return addDistinctByInternal('distanceFromCamera');
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }
}

extension CameraCalibrationEntryQueryProperty on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QQueryProperty> {
  QueryBuilder<CameraCalibrationEntry, double, QQueryOperations>
      diagonalSizeProperty() {
    return addPropertyNameInternal('diagonalSize');
  }

  QueryBuilder<CameraCalibrationEntry, double, QQueryOperations>
      distanceFromCameraProperty() {
    return addPropertyNameInternal('distanceFromCamera');
  }

  QueryBuilder<CameraCalibrationEntry, int, QQueryOperations>
      hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<CameraCalibrationEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }
}
