// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_size_distance_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetBarcodeSizeDistanceEntryCollection on Isar {
  IsarCollection<BarcodeSizeDistanceEntry> get barcodeSizeDistanceEntrys {
    return getCollection('BarcodeSizeDistanceEntry');
  }
}

final BarcodeSizeDistanceEntrySchema = CollectionSchema(
  name: 'BarcodeSizeDistanceEntry',
  schema:
      '{"name":"BarcodeSizeDistanceEntry","idName":"id","properties":[{"name":"diagonalSize","type":"Double"},{"name":"distanceFromCamera","type":"Double"}],"indexes":[],"links":[]}',
  nativeAdapter: const _BarcodeSizeDistanceEntryNativeAdapter(),
  webAdapter: const _BarcodeSizeDistanceEntryWebAdapter(),
  idName: 'id',
  propertyIds: {'diagonalSize': 0, 'distanceFromCamera': 1},
  listProperties: {},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _BarcodeSizeDistanceEntryWebAdapter
    extends IsarWebTypeAdapter<BarcodeSizeDistanceEntry> {
  const _BarcodeSizeDistanceEntryWebAdapter();

  @override
  Object serialize(IsarCollection<BarcodeSizeDistanceEntry> collection,
      BarcodeSizeDistanceEntry object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'diagonalSize', object.diagonalSize);
    IsarNative.jsObjectSet(
        jsObj, 'distanceFromCamera', object.distanceFromCamera);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    return jsObj;
  }

  @override
  BarcodeSizeDistanceEntry deserialize(
      IsarCollection<BarcodeSizeDistanceEntry> collection, dynamic jsObj) {
    final object = BarcodeSizeDistanceEntry();
    object.diagonalSize = IsarNative.jsObjectGet(jsObj, 'diagonalSize') ??
        double.negativeInfinity;
    object.distanceFromCamera =
        IsarNative.jsObjectGet(jsObj, 'distanceFromCamera') ??
            double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'diagonalSize':
        return (IsarNative.jsObjectGet(jsObj, 'diagonalSize') ??
            double.negativeInfinity) as P;
      case 'distanceFromCamera':
        return (IsarNative.jsObjectGet(jsObj, 'distanceFromCamera') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, BarcodeSizeDistanceEntry object) {}
}

class _BarcodeSizeDistanceEntryNativeAdapter
    extends IsarNativeTypeAdapter<BarcodeSizeDistanceEntry> {
  const _BarcodeSizeDistanceEntryNativeAdapter();

  @override
  void serialize(
      IsarCollection<BarcodeSizeDistanceEntry> collection,
      IsarRawObject rawObj,
      BarcodeSizeDistanceEntry object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.diagonalSize;
    final _diagonalSize = value0;
    final value1 = object.distanceFromCamera;
    final _distanceFromCamera = value1;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDouble(offsets[0], _diagonalSize);
    writer.writeDouble(offsets[1], _distanceFromCamera);
  }

  @override
  BarcodeSizeDistanceEntry deserialize(
      IsarCollection<BarcodeSizeDistanceEntry> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = BarcodeSizeDistanceEntry();
    object.diagonalSize = reader.readDouble(offsets[0]);
    object.distanceFromCamera = reader.readDouble(offsets[1]);
    object.id = id;
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDouble(offset)) as P;
      case 1:
        return (reader.readDouble(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, BarcodeSizeDistanceEntry object) {}
}

extension BarcodeSizeDistanceEntryQueryWhereSort on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QWhere> {
  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension BarcodeSizeDistanceEntryQueryWhere on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QWhereClause> {
  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }
}

extension BarcodeSizeDistanceEntryQueryFilter on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QFilterCondition> {
  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterFilterCondition> diagonalSizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'diagonalSize',
      value: value,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterFilterCondition> diagonalSizeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'diagonalSize',
      value: value,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterFilterCondition> diagonalSizeBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'diagonalSize',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterFilterCondition> distanceFromCameraGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'distanceFromCamera',
      value: value,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterFilterCondition> distanceFromCameraLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'distanceFromCamera',
      value: value,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
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

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
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

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
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

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry,
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

extension BarcodeSizeDistanceEntryQueryLinks on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QFilterCondition> {}

extension BarcodeSizeDistanceEntryQueryWhereSortBy on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QSortBy> {
  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      sortByDiagonalSize() {
    return addSortByInternal('diagonalSize', Sort.asc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      sortByDiagonalSizeDesc() {
    return addSortByInternal('diagonalSize', Sort.desc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      sortByDistanceFromCamera() {
    return addSortByInternal('distanceFromCamera', Sort.asc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      sortByDistanceFromCameraDesc() {
    return addSortByInternal('distanceFromCamera', Sort.desc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension BarcodeSizeDistanceEntryQueryWhereSortThenBy on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QSortThenBy> {
  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      thenByDiagonalSize() {
    return addSortByInternal('diagonalSize', Sort.asc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      thenByDiagonalSizeDesc() {
    return addSortByInternal('diagonalSize', Sort.desc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      thenByDistanceFromCamera() {
    return addSortByInternal('distanceFromCamera', Sort.asc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      thenByDistanceFromCameraDesc() {
    return addSortByInternal('distanceFromCamera', Sort.desc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension BarcodeSizeDistanceEntryQueryWhereDistinct on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QDistinct> {
  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QDistinct>
      distinctByDiagonalSize() {
    return addDistinctByInternal('diagonalSize');
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QDistinct>
      distinctByDistanceFromCamera() {
    return addDistinctByInternal('distanceFromCamera');
  }

  QueryBuilder<BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }
}

extension BarcodeSizeDistanceEntryQueryProperty on QueryBuilder<
    BarcodeSizeDistanceEntry, BarcodeSizeDistanceEntry, QQueryProperty> {
  QueryBuilder<BarcodeSizeDistanceEntry, double, QQueryOperations>
      diagonalSizeProperty() {
    return addPropertyNameInternal('diagonalSize');
  }

  QueryBuilder<BarcodeSizeDistanceEntry, double, QQueryOperations>
      distanceFromCameraProperty() {
    return addPropertyNameInternal('distanceFromCamera');
  }

  QueryBuilder<BarcodeSizeDistanceEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }
}
