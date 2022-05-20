// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_generation_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetBarcodeGenerationEntryCollection on Isar {
  IsarCollection<BarcodeGenerationEntry> get barcodeGenerationEntrys {
    return getCollection('BarcodeGenerationEntry');
  }
}

final BarcodeGenerationEntrySchema = CollectionSchema(
  name: 'BarcodeGenerationEntry',
  schema:
      '{"name":"BarcodeGenerationEntry","idName":"id","properties":[{"name":"rangeEnd","type":"Long"},{"name":"rangeStart","type":"Long"},{"name":"size","type":"Double"},{"name":"timestamp","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _BarcodeGenerationEntryNativeAdapter(),
  webAdapter: const _BarcodeGenerationEntryWebAdapter(),
  idName: 'id',
  propertyIds: {'rangeEnd': 0, 'rangeStart': 1, 'size': 2, 'timestamp': 3},
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

class _BarcodeGenerationEntryWebAdapter
    extends IsarWebTypeAdapter<BarcodeGenerationEntry> {
  const _BarcodeGenerationEntryWebAdapter();

  @override
  Object serialize(IsarCollection<BarcodeGenerationEntry> collection,
      BarcodeGenerationEntry object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'rangeEnd', object.rangeEnd);
    IsarNative.jsObjectSet(jsObj, 'rangeStart', object.rangeStart);
    IsarNative.jsObjectSet(jsObj, 'size', object.size);
    IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
    return jsObj;
  }

  @override
  BarcodeGenerationEntry deserialize(
      IsarCollection<BarcodeGenerationEntry> collection, dynamic jsObj) {
    final object = BarcodeGenerationEntry();
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.rangeEnd =
        IsarNative.jsObjectGet(jsObj, 'rangeEnd') ?? double.negativeInfinity;
    object.rangeStart =
        IsarNative.jsObjectGet(jsObj, 'rangeStart') ?? double.negativeInfinity;
    object.size =
        IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity;
    object.timestamp =
        IsarNative.jsObjectGet(jsObj, 'timestamp') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'rangeEnd':
        return (IsarNative.jsObjectGet(jsObj, 'rangeEnd') ??
            double.negativeInfinity) as P;
      case 'rangeStart':
        return (IsarNative.jsObjectGet(jsObj, 'rangeStart') ??
            double.negativeInfinity) as P;
      case 'size':
        return (IsarNative.jsObjectGet(jsObj, 'size') ??
            double.negativeInfinity) as P;
      case 'timestamp':
        return (IsarNative.jsObjectGet(jsObj, 'timestamp') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, BarcodeGenerationEntry object) {}
}

class _BarcodeGenerationEntryNativeAdapter
    extends IsarNativeTypeAdapter<BarcodeGenerationEntry> {
  const _BarcodeGenerationEntryNativeAdapter();

  @override
  void serialize(
      IsarCollection<BarcodeGenerationEntry> collection,
      IsarRawObject rawObj,
      BarcodeGenerationEntry object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.rangeEnd;
    final _rangeEnd = value0;
    final value1 = object.rangeStart;
    final _rangeStart = value1;
    final value2 = object.size;
    final _size = value2;
    final value3 = object.timestamp;
    final _timestamp = value3;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _rangeEnd);
    writer.writeLong(offsets[1], _rangeStart);
    writer.writeDouble(offsets[2], _size);
    writer.writeLong(offsets[3], _timestamp);
  }

  @override
  BarcodeGenerationEntry deserialize(
      IsarCollection<BarcodeGenerationEntry> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = BarcodeGenerationEntry();
    object.id = id;
    object.rangeEnd = reader.readLong(offsets[0]);
    object.rangeStart = reader.readLong(offsets[1]);
    object.size = reader.readDouble(offsets[2]);
    object.timestamp = reader.readLong(offsets[3]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readLong(offset)) as P;
      case 1:
        return (reader.readLong(offset)) as P;
      case 2:
        return (reader.readDouble(offset)) as P;
      case 3:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, BarcodeGenerationEntry object) {}
}

extension BarcodeGenerationEntryQueryWhereSort
    on QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QWhere> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension BarcodeGenerationEntryQueryWhere on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QWhereClause> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

extension BarcodeGenerationEntryQueryFilter on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QFilterCondition> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeEndEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rangeEnd',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeEndGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rangeEnd',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeEndLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rangeEnd',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeEndBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rangeEnd',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeStartEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rangeStart',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeStartGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'rangeStart',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeStartLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'rangeStart',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> rangeStartBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rangeStart',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> sizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> sizeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> sizeBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'size',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> timestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> timestampLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> timestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'timestamp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension BarcodeGenerationEntryQueryLinks on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QFilterCondition> {}

extension BarcodeGenerationEntryQueryWhereSortBy
    on QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QSortBy> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByRangeEnd() {
    return addSortByInternal('rangeEnd', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByRangeEndDesc() {
    return addSortByInternal('rangeEnd', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByRangeStart() {
    return addSortByInternal('rangeStart', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByRangeStartDesc() {
    return addSortByInternal('rangeStart', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension BarcodeGenerationEntryQueryWhereSortThenBy on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QSortThenBy> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByRangeEnd() {
    return addSortByInternal('rangeEnd', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByRangeEndDesc() {
    return addSortByInternal('rangeEnd', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByRangeStart() {
    return addSortByInternal('rangeStart', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByRangeStartDesc() {
    return addSortByInternal('rangeStart', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterSortBy>
      thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension BarcodeGenerationEntryQueryWhereDistinct
    on QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QDistinct> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QDistinct>
      distinctByRangeEnd() {
    return addDistinctByInternal('rangeEnd');
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QDistinct>
      distinctByRangeStart() {
    return addDistinctByInternal('rangeStart');
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QDistinct>
      distinctBySize() {
    return addDistinctByInternal('size');
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QDistinct>
      distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension BarcodeGenerationEntryQueryProperty on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QQueryProperty> {
  QueryBuilder<BarcodeGenerationEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<BarcodeGenerationEntry, int, QQueryOperations>
      rangeEndProperty() {
    return addPropertyNameInternal('rangeEnd');
  }

  QueryBuilder<BarcodeGenerationEntry, int, QQueryOperations>
      rangeStartProperty() {
    return addPropertyNameInternal('rangeStart');
  }

  QueryBuilder<BarcodeGenerationEntry, double, QQueryOperations>
      sizeProperty() {
    return addPropertyNameInternal('size');
  }

  QueryBuilder<BarcodeGenerationEntry, int, QQueryOperations>
      timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}
