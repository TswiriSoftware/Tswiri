// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interbarcode_time_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetInterBarcodeTimeEntryCollection on Isar {
  IsarCollection<InterBarcodeTimeEntry> get interBarcodeTimeEntrys {
    return getCollection('InterBarcodeTimeEntry');
  }
}

final InterBarcodeTimeEntrySchema = CollectionSchema(
  name: 'InterBarcodeTimeEntry',
  schema:
      '{"name":"InterBarcodeTimeEntry","idName":"id","properties":[{"name":"creationTimestamp","type":"Long"},{"name":"deltaT","type":"Double"},{"name":"endBarcodeUID","type":"String"},{"name":"hashCode","type":"Long"},{"name":"startBarcodeUID","type":"String"},{"name":"timestamp","type":"Long"},{"name":"uid","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _InterBarcodeTimeEntryNativeAdapter(),
  webAdapter: const _InterBarcodeTimeEntryWebAdapter(),
  idName: 'id',
  propertyIds: {
    'creationTimestamp': 0,
    'deltaT': 1,
    'endBarcodeUID': 2,
    'hashCode': 3,
    'startBarcodeUID': 4,
    'timestamp': 5,
    'uid': 6
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

class _InterBarcodeTimeEntryWebAdapter
    extends IsarWebTypeAdapter<InterBarcodeTimeEntry> {
  const _InterBarcodeTimeEntryWebAdapter();

  @override
  Object serialize(IsarCollection<InterBarcodeTimeEntry> collection,
      InterBarcodeTimeEntry object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(
        jsObj, 'creationTimestamp', object.creationTimestamp);
    IsarNative.jsObjectSet(jsObj, 'deltaT', object.deltaT);
    IsarNative.jsObjectSet(jsObj, 'endBarcodeUID', object.endBarcodeUID);
    IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'startBarcodeUID', object.startBarcodeUID);
    IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
    IsarNative.jsObjectSet(jsObj, 'uid', object.uid);
    return jsObj;
  }

  @override
  InterBarcodeTimeEntry deserialize(
      IsarCollection<InterBarcodeTimeEntry> collection, dynamic jsObj) {
    final object = InterBarcodeTimeEntry();
    object.creationTimestamp =
        IsarNative.jsObjectGet(jsObj, 'creationTimestamp') ??
            double.negativeInfinity;
    object.deltaT =
        IsarNative.jsObjectGet(jsObj, 'deltaT') ?? double.negativeInfinity;
    object.endBarcodeUID = IsarNative.jsObjectGet(jsObj, 'endBarcodeUID') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.startBarcodeUID =
        IsarNative.jsObjectGet(jsObj, 'startBarcodeUID') ?? '';
    object.timestamp =
        IsarNative.jsObjectGet(jsObj, 'timestamp') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'creationTimestamp':
        return (IsarNative.jsObjectGet(jsObj, 'creationTimestamp') ??
            double.negativeInfinity) as P;
      case 'deltaT':
        return (IsarNative.jsObjectGet(jsObj, 'deltaT') ??
            double.negativeInfinity) as P;
      case 'endBarcodeUID':
        return (IsarNative.jsObjectGet(jsObj, 'endBarcodeUID') ?? '') as P;
      case 'hashCode':
        return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'startBarcodeUID':
        return (IsarNative.jsObjectGet(jsObj, 'startBarcodeUID') ?? '') as P;
      case 'timestamp':
        return (IsarNative.jsObjectGet(jsObj, 'timestamp') ??
            double.negativeInfinity) as P;
      case 'uid':
        return (IsarNative.jsObjectGet(jsObj, 'uid') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, InterBarcodeTimeEntry object) {}
}

class _InterBarcodeTimeEntryNativeAdapter
    extends IsarNativeTypeAdapter<InterBarcodeTimeEntry> {
  const _InterBarcodeTimeEntryNativeAdapter();

  @override
  void serialize(
      IsarCollection<InterBarcodeTimeEntry> collection,
      IsarRawObject rawObj,
      InterBarcodeTimeEntry object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.creationTimestamp;
    final _creationTimestamp = value0;
    final value1 = object.deltaT;
    final _deltaT = value1;
    final value2 = object.endBarcodeUID;
    final _endBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_endBarcodeUID.length) as int;
    final value3 = object.hashCode;
    final _hashCode = value3;
    final value4 = object.startBarcodeUID;
    final _startBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_startBarcodeUID.length) as int;
    final value5 = object.timestamp;
    final _timestamp = value5;
    final value6 = object.uid;
    final _uid = IsarBinaryWriter.utf8Encoder.convert(value6);
    dynamicSize += (_uid.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _creationTimestamp);
    writer.writeDouble(offsets[1], _deltaT);
    writer.writeBytes(offsets[2], _endBarcodeUID);
    writer.writeLong(offsets[3], _hashCode);
    writer.writeBytes(offsets[4], _startBarcodeUID);
    writer.writeLong(offsets[5], _timestamp);
    writer.writeBytes(offsets[6], _uid);
  }

  @override
  InterBarcodeTimeEntry deserialize(
      IsarCollection<InterBarcodeTimeEntry> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = InterBarcodeTimeEntry();
    object.creationTimestamp = reader.readLong(offsets[0]);
    object.deltaT = reader.readDouble(offsets[1]);
    object.endBarcodeUID = reader.readString(offsets[2]);
    object.id = id;
    object.startBarcodeUID = reader.readString(offsets[4]);
    object.timestamp = reader.readLong(offsets[5]);
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
        return (reader.readDouble(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readLong(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
      case 5:
        return (reader.readLong(offset)) as P;
      case 6:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, InterBarcodeTimeEntry object) {}
}

extension InterBarcodeTimeEntryQueryWhereSort
    on QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QWhere> {
  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension InterBarcodeTimeEntryQueryWhere on QueryBuilder<InterBarcodeTimeEntry,
    InterBarcodeTimeEntry, QWhereClause> {
  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterWhereClause>
      idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterWhereClause>
      idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterWhereClause>
      idBetween(
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

extension InterBarcodeTimeEntryQueryFilter on QueryBuilder<
    InterBarcodeTimeEntry, InterBarcodeTimeEntry, QFilterCondition> {
  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> creationTimestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'creationTimestamp',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> creationTimestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'creationTimestamp',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> creationTimestampLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'creationTimestamp',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> creationTimestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'creationTimestamp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> deltaTGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'deltaT',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> deltaTLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'deltaT',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> deltaTBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'deltaT',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
          QAfterFilterCondition>
      endBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
          QAfterFilterCondition>
      endBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'endBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
          QAfterFilterCondition>
      startBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
          QAfterFilterCondition>
      startBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'startBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
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

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> uidGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> uidLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'uid',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
      QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
          QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry,
          QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'uid',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension InterBarcodeTimeEntryQueryLinks on QueryBuilder<InterBarcodeTimeEntry,
    InterBarcodeTimeEntry, QFilterCondition> {}

extension InterBarcodeTimeEntryQueryWhereSortBy
    on QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QSortBy> {
  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByCreationTimestamp() {
    return addSortByInternal('creationTimestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByCreationTimestampDesc() {
    return addSortByInternal('creationTimestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByDeltaT() {
    return addSortByInternal('deltaT', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByDeltaTDesc() {
    return addSortByInternal('deltaT', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByEndBarcodeUID() {
    return addSortByInternal('endBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByEndBarcodeUIDDesc() {
    return addSortByInternal('endBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByStartBarcodeUID() {
    return addSortByInternal('startBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByStartBarcodeUIDDesc() {
    return addSortByInternal('startBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByUid() {
    return addSortByInternal('uid', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      sortByUidDesc() {
    return addSortByInternal('uid', Sort.desc);
  }
}

extension InterBarcodeTimeEntryQueryWhereSortThenBy
    on QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QSortThenBy> {
  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByCreationTimestamp() {
    return addSortByInternal('creationTimestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByCreationTimestampDesc() {
    return addSortByInternal('creationTimestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByDeltaT() {
    return addSortByInternal('deltaT', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByDeltaTDesc() {
    return addSortByInternal('deltaT', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByEndBarcodeUID() {
    return addSortByInternal('endBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByEndBarcodeUIDDesc() {
    return addSortByInternal('endBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByStartBarcodeUID() {
    return addSortByInternal('startBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByStartBarcodeUIDDesc() {
    return addSortByInternal('startBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByUid() {
    return addSortByInternal('uid', Sort.asc);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QAfterSortBy>
      thenByUidDesc() {
    return addSortByInternal('uid', Sort.desc);
  }
}

extension InterBarcodeTimeEntryQueryWhereDistinct
    on QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct> {
  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByCreationTimestamp() {
    return addDistinctByInternal('creationTimestamp');
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByDeltaT() {
    return addDistinctByInternal('deltaT');
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByEndBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('endBarcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByStartBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('startBarcodeUID',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }

  QueryBuilder<InterBarcodeTimeEntry, InterBarcodeTimeEntry, QDistinct>
      distinctByUid({bool caseSensitive = true}) {
    return addDistinctByInternal('uid', caseSensitive: caseSensitive);
  }
}

extension InterBarcodeTimeEntryQueryProperty on QueryBuilder<
    InterBarcodeTimeEntry, InterBarcodeTimeEntry, QQueryProperty> {
  QueryBuilder<InterBarcodeTimeEntry, int, QQueryOperations>
      creationTimestampProperty() {
    return addPropertyNameInternal('creationTimestamp');
  }

  QueryBuilder<InterBarcodeTimeEntry, double, QQueryOperations>
      deltaTProperty() {
    return addPropertyNameInternal('deltaT');
  }

  QueryBuilder<InterBarcodeTimeEntry, String, QQueryOperations>
      endBarcodeUIDProperty() {
    return addPropertyNameInternal('endBarcodeUID');
  }

  QueryBuilder<InterBarcodeTimeEntry, int, QQueryOperations>
      hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<InterBarcodeTimeEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<InterBarcodeTimeEntry, String, QQueryOperations>
      startBarcodeUIDProperty() {
    return addPropertyNameInternal('startBarcodeUID');
  }

  QueryBuilder<InterBarcodeTimeEntry, int, QQueryOperations>
      timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }

  QueryBuilder<InterBarcodeTimeEntry, String, QQueryOperations> uidProperty() {
    return addPropertyNameInternal('uid');
  }
}
