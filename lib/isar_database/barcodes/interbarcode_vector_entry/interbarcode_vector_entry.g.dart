// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interbarcode_vector_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetInterBarcodeVectorEntryCollection on Isar {
  IsarCollection<InterBarcodeVectorEntry> get interBarcodeVectorEntrys {
    return getCollection('InterBarcodeVectorEntry');
  }
}

final InterBarcodeVectorEntrySchema = CollectionSchema(
  name: 'InterBarcodeVectorEntry',
  schema:
      '{"name":"InterBarcodeVectorEntry","idName":"id","properties":[{"name":"creationTimestamp","type":"Long"},{"name":"endBarcodeUID","type":"String"},{"name":"hashCode","type":"Long"},{"name":"startBarcodeUID","type":"String"},{"name":"timestamp","type":"Long"},{"name":"uid","type":"String"},{"name":"x","type":"Double"},{"name":"y","type":"Double"},{"name":"z","type":"Double"}],"indexes":[],"links":[]}',
  nativeAdapter: const _InterBarcodeVectorEntryNativeAdapter(),
  webAdapter: const _InterBarcodeVectorEntryWebAdapter(),
  idName: 'id',
  propertyIds: {
    'creationTimestamp': 0,
    'endBarcodeUID': 1,
    'hashCode': 2,
    'startBarcodeUID': 3,
    'timestamp': 4,
    'uid': 5,
    'x': 6,
    'y': 7,
    'z': 8
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

class _InterBarcodeVectorEntryWebAdapter
    extends IsarWebTypeAdapter<InterBarcodeVectorEntry> {
  const _InterBarcodeVectorEntryWebAdapter();

  @override
  Object serialize(IsarCollection<InterBarcodeVectorEntry> collection,
      InterBarcodeVectorEntry object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(
        jsObj, 'creationTimestamp', object.creationTimestamp);
    IsarNative.jsObjectSet(jsObj, 'endBarcodeUID', object.endBarcodeUID);
    IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'startBarcodeUID', object.startBarcodeUID);
    IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
    IsarNative.jsObjectSet(jsObj, 'uid', object.uid);
    IsarNative.jsObjectSet(jsObj, 'x', object.x);
    IsarNative.jsObjectSet(jsObj, 'y', object.y);
    IsarNative.jsObjectSet(jsObj, 'z', object.z);
    return jsObj;
  }

  @override
  InterBarcodeVectorEntry deserialize(
      IsarCollection<InterBarcodeVectorEntry> collection, dynamic jsObj) {
    final object = InterBarcodeVectorEntry();
    object.creationTimestamp =
        IsarNative.jsObjectGet(jsObj, 'creationTimestamp') ??
            double.negativeInfinity;
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
      case 'creationTimestamp':
        return (IsarNative.jsObjectGet(jsObj, 'creationTimestamp') ??
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
  void attachLinks(Isar isar, int id, InterBarcodeVectorEntry object) {}
}

class _InterBarcodeVectorEntryNativeAdapter
    extends IsarNativeTypeAdapter<InterBarcodeVectorEntry> {
  const _InterBarcodeVectorEntryNativeAdapter();

  @override
  void serialize(
      IsarCollection<InterBarcodeVectorEntry> collection,
      IsarRawObject rawObj,
      InterBarcodeVectorEntry object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.creationTimestamp;
    final _creationTimestamp = value0;
    final value1 = object.endBarcodeUID;
    final _endBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_endBarcodeUID.length) as int;
    final value2 = object.hashCode;
    final _hashCode = value2;
    final value3 = object.startBarcodeUID;
    final _startBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_startBarcodeUID.length) as int;
    final value4 = object.timestamp;
    final _timestamp = value4;
    final value5 = object.uid;
    final _uid = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_uid.length) as int;
    final value6 = object.x;
    final _x = value6;
    final value7 = object.y;
    final _y = value7;
    final value8 = object.z;
    final _z = value8;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _creationTimestamp);
    writer.writeBytes(offsets[1], _endBarcodeUID);
    writer.writeLong(offsets[2], _hashCode);
    writer.writeBytes(offsets[3], _startBarcodeUID);
    writer.writeLong(offsets[4], _timestamp);
    writer.writeBytes(offsets[5], _uid);
    writer.writeDouble(offsets[6], _x);
    writer.writeDouble(offsets[7], _y);
    writer.writeDouble(offsets[8], _z);
  }

  @override
  InterBarcodeVectorEntry deserialize(
      IsarCollection<InterBarcodeVectorEntry> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = InterBarcodeVectorEntry();
    object.creationTimestamp = reader.readLong(offsets[0]);
    object.endBarcodeUID = reader.readString(offsets[1]);
    object.id = id;
    object.startBarcodeUID = reader.readString(offsets[3]);
    object.timestamp = reader.readLong(offsets[4]);
    object.x = reader.readDouble(offsets[6]);
    object.y = reader.readDouble(offsets[7]);
    object.z = reader.readDouble(offsets[8]);
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
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readLong(offset)) as P;
      case 3:
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readLong(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      case 6:
        return (reader.readDouble(offset)) as P;
      case 7:
        return (reader.readDouble(offset)) as P;
      case 8:
        return (reader.readDouble(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, InterBarcodeVectorEntry object) {}
}

extension InterBarcodeVectorEntryQueryWhereSort
    on QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QWhere> {
  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension InterBarcodeVectorEntryQueryWhere on QueryBuilder<
    InterBarcodeVectorEntry, InterBarcodeVectorEntry, QWhereClause> {
  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

extension InterBarcodeVectorEntryQueryFilter on QueryBuilder<
    InterBarcodeVectorEntry, InterBarcodeVectorEntry, QFilterCondition> {
  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> creationTimestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'creationTimestamp',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
          QAfterFilterCondition>
      endBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'endBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
          QAfterFilterCondition>
      endBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'endBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
          QAfterFilterCondition>
      startBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'startBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
          QAfterFilterCondition>
      startBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'startBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
          QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'uid',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
          QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'uid',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> xGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> xLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> xBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'x',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> yGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> yLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> yBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'y',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> zGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
      QAfterFilterCondition> zLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry,
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

extension InterBarcodeVectorEntryQueryLinks on QueryBuilder<
    InterBarcodeVectorEntry, InterBarcodeVectorEntry, QFilterCondition> {}

extension InterBarcodeVectorEntryQueryWhereSortBy
    on QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QSortBy> {
  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByCreationTimestamp() {
    return addSortByInternal('creationTimestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByCreationTimestampDesc() {
    return addSortByInternal('creationTimestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByEndBarcodeUID() {
    return addSortByInternal('endBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByEndBarcodeUIDDesc() {
    return addSortByInternal('endBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByStartBarcodeUID() {
    return addSortByInternal('startBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByStartBarcodeUIDDesc() {
    return addSortByInternal('startBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByUid() {
    return addSortByInternal('uid', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByUidDesc() {
    return addSortByInternal('uid', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      sortByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension InterBarcodeVectorEntryQueryWhereSortThenBy on QueryBuilder<
    InterBarcodeVectorEntry, InterBarcodeVectorEntry, QSortThenBy> {
  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByCreationTimestamp() {
    return addSortByInternal('creationTimestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByCreationTimestampDesc() {
    return addSortByInternal('creationTimestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByEndBarcodeUID() {
    return addSortByInternal('endBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByEndBarcodeUIDDesc() {
    return addSortByInternal('endBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByStartBarcodeUID() {
    return addSortByInternal('startBarcodeUID', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByStartBarcodeUIDDesc() {
    return addSortByInternal('startBarcodeUID', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByUid() {
    return addSortByInternal('uid', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByUidDesc() {
    return addSortByInternal('uid', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QAfterSortBy>
      thenByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension InterBarcodeVectorEntryQueryWhereDistinct on QueryBuilder<
    InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct> {
  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByCreationTimestamp() {
    return addDistinctByInternal('creationTimestamp');
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByEndBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('endBarcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByStartBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('startBarcodeUID',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByUid({bool caseSensitive = true}) {
    return addDistinctByInternal('uid', caseSensitive: caseSensitive);
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByX() {
    return addDistinctByInternal('x');
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByY() {
    return addDistinctByInternal('y');
  }

  QueryBuilder<InterBarcodeVectorEntry, InterBarcodeVectorEntry, QDistinct>
      distinctByZ() {
    return addDistinctByInternal('z');
  }
}

extension InterBarcodeVectorEntryQueryProperty on QueryBuilder<
    InterBarcodeVectorEntry, InterBarcodeVectorEntry, QQueryProperty> {
  QueryBuilder<InterBarcodeVectorEntry, int, QQueryOperations>
      creationTimestampProperty() {
    return addPropertyNameInternal('creationTimestamp');
  }

  QueryBuilder<InterBarcodeVectorEntry, String, QQueryOperations>
      endBarcodeUIDProperty() {
    return addPropertyNameInternal('endBarcodeUID');
  }

  QueryBuilder<InterBarcodeVectorEntry, int, QQueryOperations>
      hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<InterBarcodeVectorEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<InterBarcodeVectorEntry, String, QQueryOperations>
      startBarcodeUIDProperty() {
    return addPropertyNameInternal('startBarcodeUID');
  }

  QueryBuilder<InterBarcodeVectorEntry, int, QQueryOperations>
      timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }

  QueryBuilder<InterBarcodeVectorEntry, String, QQueryOperations>
      uidProperty() {
    return addPropertyNameInternal('uid');
  }

  QueryBuilder<InterBarcodeVectorEntry, double, QQueryOperations> xProperty() {
    return addPropertyNameInternal('x');
  }

  QueryBuilder<InterBarcodeVectorEntry, double, QQueryOperations> yProperty() {
    return addPropertyNameInternal('y');
  }

  QueryBuilder<InterBarcodeVectorEntry, double, QQueryOperations> zProperty() {
    return addPropertyNameInternal('z');
  }
}
