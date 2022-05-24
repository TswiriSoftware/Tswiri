// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_generation_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetBarcodeGenerationEntryCollection on Isar {
  IsarCollection<BarcodeGenerationEntry> get barcodeGenerationEntrys =>
      getCollection();
}

const BarcodeGenerationEntrySchema = CollectionSchema(
  name: 'BarcodeGenerationEntry',
  schema:
      '{"name":"BarcodeGenerationEntry","idName":"id","properties":[{"name":"barcodeUIDs","type":"StringList"},{"name":"rangeEnd","type":"Long"},{"name":"rangeStart","type":"Long"},{"name":"size","type":"Double"},{"name":"timestamp","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'barcodeUIDs': 0,
    'rangeEnd': 1,
    'rangeStart': 2,
    'size': 3,
    'timestamp': 4
  },
  listProperties: {'barcodeUIDs'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _barcodeGenerationEntryGetId,
  setId: _barcodeGenerationEntrySetId,
  getLinks: _barcodeGenerationEntryGetLinks,
  attachLinks: _barcodeGenerationEntryAttachLinks,
  serializeNative: _barcodeGenerationEntrySerializeNative,
  deserializeNative: _barcodeGenerationEntryDeserializeNative,
  deserializePropNative: _barcodeGenerationEntryDeserializePropNative,
  serializeWeb: _barcodeGenerationEntrySerializeWeb,
  deserializeWeb: _barcodeGenerationEntryDeserializeWeb,
  deserializePropWeb: _barcodeGenerationEntryDeserializePropWeb,
  version: 3,
);

int? _barcodeGenerationEntryGetId(BarcodeGenerationEntry object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _barcodeGenerationEntrySetId(BarcodeGenerationEntry object, int id) {
  object.id = id;
}

List<IsarLinkBase> _barcodeGenerationEntryGetLinks(
    BarcodeGenerationEntry object) {
  return [];
}

void _barcodeGenerationEntrySerializeNative(
    IsarCollection<BarcodeGenerationEntry> collection,
    IsarRawObject rawObj,
    BarcodeGenerationEntry object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUIDs;
  dynamicSize += (value0.length) * 8;
  final bytesList0 = <IsarUint8List>[];
  for (var str in value0) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList0.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _barcodeUIDs = bytesList0;
  final value1 = object.rangeEnd;
  final _rangeEnd = value1;
  final value2 = object.rangeStart;
  final _rangeStart = value2;
  final value3 = object.size;
  final _size = value3;
  final value4 = object.timestamp;
  final _timestamp = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeStringList(offsets[0], _barcodeUIDs);
  writer.writeLong(offsets[1], _rangeEnd);
  writer.writeLong(offsets[2], _rangeStart);
  writer.writeDouble(offsets[3], _size);
  writer.writeLong(offsets[4], _timestamp);
}

BarcodeGenerationEntry _barcodeGenerationEntryDeserializeNative(
    IsarCollection<BarcodeGenerationEntry> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = BarcodeGenerationEntry();
  object.barcodeUIDs = reader.readStringList(offsets[0]) ?? [];
  object.id = id;
  object.rangeEnd = reader.readLong(offsets[1]);
  object.rangeStart = reader.readLong(offsets[2]);
  object.size = reader.readDouble(offsets[3]);
  object.timestamp = reader.readLong(offsets[4]);
  return object;
}

P _barcodeGenerationEntryDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _barcodeGenerationEntrySerializeWeb(
    IsarCollection<BarcodeGenerationEntry> collection,
    BarcodeGenerationEntry object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUIDs', object.barcodeUIDs);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'rangeEnd', object.rangeEnd);
  IsarNative.jsObjectSet(jsObj, 'rangeStart', object.rangeStart);
  IsarNative.jsObjectSet(jsObj, 'size', object.size);
  IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
  return jsObj;
}

BarcodeGenerationEntry _barcodeGenerationEntryDeserializeWeb(
    IsarCollection<BarcodeGenerationEntry> collection, dynamic jsObj) {
  final object = BarcodeGenerationEntry();
  object.barcodeUIDs = (IsarNative.jsObjectGet(jsObj, 'barcodeUIDs') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>() ??
      [];
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

P _barcodeGenerationEntryDeserializePropWeb<P>(
    Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUIDs':
      return ((IsarNative.jsObjectGet(jsObj, 'barcodeUIDs') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
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
      return (IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity)
          as P;
    case 'timestamp':
      return (IsarNative.jsObjectGet(jsObj, 'timestamp') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _barcodeGenerationEntryAttachLinks(
    IsarCollection col, int id, BarcodeGenerationEntry object) {}

extension BarcodeGenerationEntryQueryWhereSort
    on QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QWhere> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension BarcodeGenerationEntryQueryWhere on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QWhereClause> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterWhereClause> idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterWhereClause> idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
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

extension BarcodeGenerationEntryQueryFilter on QueryBuilder<
    BarcodeGenerationEntry, BarcodeGenerationEntry, QFilterCondition> {
  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> barcodeUIDsAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> barcodeUIDsAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> barcodeUIDsAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> barcodeUIDsAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'barcodeUIDs',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> barcodeUIDsAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
      QAfterFilterCondition> barcodeUIDsAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
          QAfterFilterCondition>
      barcodeUIDsAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeGenerationEntry, BarcodeGenerationEntry,
          QAfterFilterCondition>
      barcodeUIDsAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUIDs',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

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
  QueryBuilder<BarcodeGenerationEntry, List<String>, QQueryOperations>
      barcodeUIDsProperty() {
    return addPropertyNameInternal('barcodeUIDs');
  }

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
