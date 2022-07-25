// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_batch.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetBarcodeBatchCollection on Isar {
  IsarCollection<BarcodeBatch> get barcodeBatchs => getCollection();
}

const BarcodeBatchSchema = CollectionSchema(
  name: 'BarcodeBatch',
  schema:
      '{"name":"BarcodeBatch","idName":"id","properties":[{"name":"barcodeUIDs","type":"StringList"},{"name":"endUID","type":"Long"},{"name":"size","type":"Double"},{"name":"startUID","type":"Long"},{"name":"timestamp","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'barcodeUIDs': 0,
    'endUID': 1,
    'size': 2,
    'startUID': 3,
    'timestamp': 4
  },
  listProperties: {'barcodeUIDs'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _barcodeBatchGetId,
  setId: _barcodeBatchSetId,
  getLinks: _barcodeBatchGetLinks,
  attachLinks: _barcodeBatchAttachLinks,
  serializeNative: _barcodeBatchSerializeNative,
  deserializeNative: _barcodeBatchDeserializeNative,
  deserializePropNative: _barcodeBatchDeserializePropNative,
  serializeWeb: _barcodeBatchSerializeWeb,
  deserializeWeb: _barcodeBatchDeserializeWeb,
  deserializePropWeb: _barcodeBatchDeserializePropWeb,
  version: 3,
);

int? _barcodeBatchGetId(BarcodeBatch object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _barcodeBatchSetId(BarcodeBatch object, int id) {
  object.id = id;
}

List<IsarLinkBase> _barcodeBatchGetLinks(BarcodeBatch object) {
  return [];
}

void _barcodeBatchSerializeNative(
    IsarCollection<BarcodeBatch> collection,
    IsarRawObject rawObj,
    BarcodeBatch object,
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
  final value1 = object.endUID;
  final _endUID = value1;
  final value2 = object.size;
  final _size = value2;
  final value3 = object.startUID;
  final _startUID = value3;
  final value4 = object.timestamp;
  final _timestamp = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeStringList(offsets[0], _barcodeUIDs);
  writer.writeLong(offsets[1], _endUID);
  writer.writeDouble(offsets[2], _size);
  writer.writeLong(offsets[3], _startUID);
  writer.writeLong(offsets[4], _timestamp);
}

BarcodeBatch _barcodeBatchDeserializeNative(
    IsarCollection<BarcodeBatch> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = BarcodeBatch();
  object.barcodeUIDs = reader.readStringList(offsets[0]) ?? [];
  object.endUID = reader.readLong(offsets[1]);
  object.id = id;
  object.size = reader.readDouble(offsets[2]);
  object.startUID = reader.readLong(offsets[3]);
  object.timestamp = reader.readLong(offsets[4]);
  return object;
}

P _barcodeBatchDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _barcodeBatchSerializeWeb(
    IsarCollection<BarcodeBatch> collection, BarcodeBatch object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUIDs', object.barcodeUIDs);
  IsarNative.jsObjectSet(jsObj, 'endUID', object.endUID);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'size', object.size);
  IsarNative.jsObjectSet(jsObj, 'startUID', object.startUID);
  IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
  return jsObj;
}

BarcodeBatch _barcodeBatchDeserializeWeb(
    IsarCollection<BarcodeBatch> collection, dynamic jsObj) {
  final object = BarcodeBatch();
  object.barcodeUIDs = (IsarNative.jsObjectGet(jsObj, 'barcodeUIDs') as List?)
          ?.map((e) => e ?? '')
          .toList()
          .cast<String>() ??
      [];
  object.endUID =
      IsarNative.jsObjectGet(jsObj, 'endUID') ?? double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.size =
      IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity;
  object.startUID =
      IsarNative.jsObjectGet(jsObj, 'startUID') ?? double.negativeInfinity;
  object.timestamp =
      IsarNative.jsObjectGet(jsObj, 'timestamp') ?? double.negativeInfinity;
  return object;
}

P _barcodeBatchDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUIDs':
      return ((IsarNative.jsObjectGet(jsObj, 'barcodeUIDs') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    case 'endUID':
      return (IsarNative.jsObjectGet(jsObj, 'endUID') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'size':
      return (IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity)
          as P;
    case 'startUID':
      return (IsarNative.jsObjectGet(jsObj, 'startUID') ??
          double.negativeInfinity) as P;
    case 'timestamp':
      return (IsarNative.jsObjectGet(jsObj, 'timestamp') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _barcodeBatchAttachLinks(
    IsarCollection col, int id, BarcodeBatch object) {}

extension BarcodeBatchQueryWhereSort
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QWhere> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension BarcodeBatchQueryWhere
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QWhereClause> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idNotEqualTo(
      int id) {
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idBetween(
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

extension BarcodeBatchQueryFilter
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QFilterCondition> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyEqualTo(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyGreaterThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyLessThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyBetween(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyStartsWith(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyEndsWith(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUIDs',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      barcodeUIDsAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUIDs',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> endUIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'endUID',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      endUIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'endUID',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      endUIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'endUID',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> endUIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'endUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      sizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> sizeLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> sizeBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'size',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      startUIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'startUID',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      startUIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'startUID',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      startUIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'startUID',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      startUIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'startUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      timestampGreaterThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      timestampLessThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      timestampBetween(
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

extension BarcodeBatchQueryLinks
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QFilterCondition> {}

extension BarcodeBatchQueryWhereSortBy
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QSortBy> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByEndUID() {
    return addSortByInternal('endUID', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByEndUIDDesc() {
    return addSortByInternal('endUID', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByStartUID() {
    return addSortByInternal('startUID', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByStartUIDDesc() {
    return addSortByInternal('startUID', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension BarcodeBatchQueryWhereSortThenBy
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QSortThenBy> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByEndUID() {
    return addSortByInternal('endUID', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByEndUIDDesc() {
    return addSortByInternal('endUID', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByStartUID() {
    return addSortByInternal('startUID', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByStartUIDDesc() {
    return addSortByInternal('startUID', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension BarcodeBatchQueryWhereDistinct
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByEndUID() {
    return addDistinctByInternal('endUID');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctBySize() {
    return addDistinctByInternal('size');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByStartUID() {
    return addDistinctByInternal('startUID');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension BarcodeBatchQueryProperty
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QQueryProperty> {
  QueryBuilder<BarcodeBatch, List<String>, QQueryOperations>
      barcodeUIDsProperty() {
    return addPropertyNameInternal('barcodeUIDs');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> endUIDProperty() {
    return addPropertyNameInternal('endUID');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<BarcodeBatch, double, QQueryOperations> sizeProperty() {
    return addPropertyNameInternal('size');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> startUIDProperty() {
    return addPropertyNameInternal('startUID');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}
