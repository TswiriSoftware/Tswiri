// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'real_interbarcode_vector_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetRealInterBarcodeVectorEntryCollection on Isar {
  IsarCollection<RealInterBarcodeVectorEntry> get realInterBarcodeVectorEntrys {
    return getCollection('RealInterBarcodeVectorEntry');
  }
}

final RealInterBarcodeVectorEntrySchema = CollectionSchema(
  name: 'RealInterBarcodeVectorEntry',
  schema:
      '{"name":"RealInterBarcodeVectorEntry","idName":"id","properties":[{"name":"endBarcodeUID","type":"String"},{"name":"startBarcodeUID","type":"String"},{"name":"timestamp","type":"Long"},{"name":"x","type":"Double"},{"name":"y","type":"Double"},{"name":"z","type":"Double"}],"indexes":[],"links":[]}',
  nativeAdapter: const _RealInterBarcodeVectorEntryNativeAdapter(),
  webAdapter: const _RealInterBarcodeVectorEntryWebAdapter(),
  idName: 'id',
  propertyIds: {
    'endBarcodeUID': 0,
    'startBarcodeUID': 1,
    'timestamp': 2,
    'x': 3,
    'y': 4,
    'z': 5
  },
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

class _RealInterBarcodeVectorEntryWebAdapter
    extends IsarWebTypeAdapter<RealInterBarcodeVectorEntry> {
  const _RealInterBarcodeVectorEntryWebAdapter();

  @override
  Object serialize(IsarCollection<RealInterBarcodeVectorEntry> collection,
      RealInterBarcodeVectorEntry object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'endBarcodeUID', object.endBarcodeUID);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'startBarcodeUID', object.startBarcodeUID);
    IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
    IsarNative.jsObjectSet(jsObj, 'x', object.x);
    IsarNative.jsObjectSet(jsObj, 'y', object.y);
    IsarNative.jsObjectSet(jsObj, 'z', object.z);
    return jsObj;
  }

  @override
  RealInterBarcodeVectorEntry deserialize(
      IsarCollection<RealInterBarcodeVectorEntry> collection, dynamic jsObj) {
    final object = RealInterBarcodeVectorEntry();
    object.endBarcodeUID = IsarNative.jsObjectGet(jsObj, 'endBarcodeUID') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.startBarcodeUID =
        IsarNative.jsObjectGet(jsObj, 'startBarcodeUID') ?? '';
    object.timestamp =
        IsarNative.jsObjectGet(jsObj, 'timestamp') ?? double.negativeInfinity;
    object.x = IsarNative.jsObjectGet(jsObj, 'x') ?? double.negativeInfinity;
    object.y = IsarNative.jsObjectGet(jsObj, 'y') ?? double.negativeInfinity;
    object.z = IsarNative.jsObjectGet(jsObj, 'z') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'endBarcodeUID':
        return (IsarNative.jsObjectGet(jsObj, 'endBarcodeUID') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'startBarcodeUID':
        return (IsarNative.jsObjectGet(jsObj, 'startBarcodeUID') ?? '') as P;
      case 'timestamp':
        return (IsarNative.jsObjectGet(jsObj, 'timestamp') ??
            double.negativeInfinity) as P;
      case 'x':
        return (IsarNative.jsObjectGet(jsObj, 'x') ?? double.negativeInfinity)
            as P;
      case 'y':
        return (IsarNative.jsObjectGet(jsObj, 'y') ?? double.negativeInfinity)
            as P;
      case 'z':
        return (IsarNative.jsObjectGet(jsObj, 'z') ?? double.negativeInfinity)
            as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, RealInterBarcodeVectorEntry object) {}
}

class _RealInterBarcodeVectorEntryNativeAdapter
    extends IsarNativeTypeAdapter<RealInterBarcodeVectorEntry> {
  const _RealInterBarcodeVectorEntryNativeAdapter();

  @override
  void serialize(
      IsarCollection<RealInterBarcodeVectorEntry> collection,
      IsarRawObject rawObj,
      RealInterBarcodeVectorEntry object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.endBarcodeUID;
    final _endBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_endBarcodeUID.length) as int;
    final value1 = object.startBarcodeUID;
    final _startBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_startBarcodeUID.length) as int;
    final value2 = object.timestamp;
    final _timestamp = value2;
    final value3 = object.x;
    final _x = value3;
    final value4 = object.y;
    final _y = value4;
    final value5 = object.z;
    final _z = value5;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _endBarcodeUID);
    writer.writeBytes(offsets[1], _startBarcodeUID);
    writer.writeLong(offsets[2], _timestamp);
    writer.writeDouble(offsets[3], _x);
    writer.writeDouble(offsets[4], _y);
    writer.writeDouble(offsets[5], _z);
  }

  @override
  RealInterBarcodeVectorEntry deserialize(
      IsarCollection<RealInterBarcodeVectorEntry> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = RealInterBarcodeVectorEntry();
    object.endBarcodeUID = reader.readString(offsets[0]);
    object.id = id;
    object.startBarcodeUID = reader.readString(offsets[1]);
    object.timestamp = reader.readLong(offsets[2]);
    object.x = reader.readDouble(offsets[3]);
    object.y = reader.readDouble(offsets[4]);
    object.z = reader.readDouble(offsets[5]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readLong(offset)) as P;
      case 3:
        return (reader.readDouble(offset)) as P;
      case 4:
        return (reader.readDouble(offset)) as P;
      case 5:
        return (reader.readDouble(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, RealInterBarcodeVectorEntry object) {}
}

extension RealInterBarcodeVectorEntryQueryWhereSort on QueryBuilder<
    RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry, QWhere> {
  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension RealInterBarcodeVectorEntryQueryWhere on QueryBuilder<
    RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry, QWhereClause> {
  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

extension RealInterBarcodeVectorEntryQueryFilter on QueryBuilder<
    RealInterBarcodeVectorEntry,
    RealInterBarcodeVectorEntry,
    QFilterCondition> {
  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> endBarcodeUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> endBarcodeUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> endBarcodeUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> endBarcodeUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'endBarcodeUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> endBarcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> endBarcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
          QAfterFilterCondition>
      endBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
          QAfterFilterCondition>
      endBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'endBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> startBarcodeUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> startBarcodeUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> startBarcodeUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> startBarcodeUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'startBarcodeUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> startBarcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> startBarcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
          QAfterFilterCondition>
      startBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
          QAfterFilterCondition>
      startBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'startBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
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

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> xGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> xLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> xBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'x',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> yGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> yLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> yBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'y',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> zGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> zLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterFilterCondition> zBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'z',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension RealInterBarcodeVectorEntryQueryLinks on QueryBuilder<
    RealInterBarcodeVectorEntry,
    RealInterBarcodeVectorEntry,
    QFilterCondition> {}

extension RealInterBarcodeVectorEntryQueryWhereSortBy on QueryBuilder<
    RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry, QSortBy> {
  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByEndBarcodeUID() {
    return addSortByInternal('endBarcodeUID', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByEndBarcodeUIDDesc() {
    return addSortByInternal('endBarcodeUID', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByStartBarcodeUID() {
    return addSortByInternal('startBarcodeUID', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByStartBarcodeUIDDesc() {
    return addSortByInternal('startBarcodeUID', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> sortByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension RealInterBarcodeVectorEntryQueryWhereSortThenBy on QueryBuilder<
    RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry, QSortThenBy> {
  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByEndBarcodeUID() {
    return addSortByInternal('endBarcodeUID', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByEndBarcodeUIDDesc() {
    return addSortByInternal('endBarcodeUID', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByStartBarcodeUID() {
    return addSortByInternal('startBarcodeUID', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByStartBarcodeUIDDesc() {
    return addSortByInternal('startBarcodeUID', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QAfterSortBy> thenByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension RealInterBarcodeVectorEntryQueryWhereDistinct on QueryBuilder<
    RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry, QDistinct> {
  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctByEndBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('endBarcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctByStartBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('startBarcodeUID',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctByX() {
    return addDistinctByInternal('x');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctByY() {
    return addDistinctByInternal('y');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry,
      QDistinct> distinctByZ() {
    return addDistinctByInternal('z');
  }
}

extension RealInterBarcodeVectorEntryQueryProperty on QueryBuilder<
    RealInterBarcodeVectorEntry, RealInterBarcodeVectorEntry, QQueryProperty> {
  QueryBuilder<RealInterBarcodeVectorEntry, String, QQueryOperations>
      endBarcodeUIDProperty() {
    return addPropertyNameInternal('endBarcodeUID');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, int, QQueryOperations>
      idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, String, QQueryOperations>
      startBarcodeUIDProperty() {
    return addPropertyNameInternal('startBarcodeUID');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, int, QQueryOperations>
      timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, double, QQueryOperations>
      xProperty() {
    return addPropertyNameInternal('x');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, double, QQueryOperations>
      yProperty() {
    return addPropertyNameInternal('y');
  }

  QueryBuilder<RealInterBarcodeVectorEntry, double, QQueryOperations>
      zProperty() {
    return addPropertyNameInternal('z');
  }
}
