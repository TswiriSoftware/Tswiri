// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

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
      '{"name":"BarcodeBatch","idName":"id","properties":[{"name":"imported","type":"Bool"},{"name":"rangeEnd","type":"Long"},{"name":"rangeStart","type":"Long"},{"name":"size","type":"Double"},{"name":"timestamp","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'imported': 0,
    'rangeEnd': 1,
    'rangeStart': 2,
    'size': 3,
    'timestamp': 4
  },
  listProperties: {},
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
  final value0 = object.imported;
  final _imported = value0;
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
  writer.writeBool(offsets[0], _imported);
  writer.writeLong(offsets[1], _rangeEnd);
  writer.writeLong(offsets[2], _rangeStart);
  writer.writeDouble(offsets[3], _size);
  writer.writeLong(offsets[4], _timestamp);
}

BarcodeBatch _barcodeBatchDeserializeNative(
    IsarCollection<BarcodeBatch> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = BarcodeBatch();
  object.id = id;
  object.imported = reader.readBool(offsets[0]);
  object.rangeEnd = reader.readLong(offsets[1]);
  object.rangeStart = reader.readLong(offsets[2]);
  object.size = reader.readDouble(offsets[3]);
  object.timestamp = reader.readLong(offsets[4]);
  return object;
}

P _barcodeBatchDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readBool(offset)) as P;
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

dynamic _barcodeBatchSerializeWeb(
    IsarCollection<BarcodeBatch> collection, BarcodeBatch object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'imported', object.imported);
  IsarNative.jsObjectSet(jsObj, 'rangeEnd', object.rangeEnd);
  IsarNative.jsObjectSet(jsObj, 'rangeStart', object.rangeStart);
  IsarNative.jsObjectSet(jsObj, 'size', object.size);
  IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
  return jsObj;
}

BarcodeBatch _barcodeBatchDeserializeWeb(
    IsarCollection<BarcodeBatch> collection, dynamic jsObj) {
  final object = BarcodeBatch();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.imported = IsarNative.jsObjectGet(jsObj, 'imported') ?? false;
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

P _barcodeBatchDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'imported':
      return (IsarNative.jsObjectGet(jsObj, 'imported') ?? false) as P;
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
      importedEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'imported',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rangeEnd',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndGreaterThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndLessThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndBetween(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rangeStart',
      value: value,
    ));
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartGreaterThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartLessThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartBetween(
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
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByImported() {
    return addSortByInternal('imported', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByImportedDesc() {
    return addSortByInternal('imported', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByRangeEnd() {
    return addSortByInternal('rangeEnd', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByRangeEndDesc() {
    return addSortByInternal('rangeEnd', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByRangeStart() {
    return addSortByInternal('rangeStart', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy>
      sortByRangeStartDesc() {
    return addSortByInternal('rangeStart', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
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
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByImported() {
    return addSortByInternal('imported', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByImportedDesc() {
    return addSortByInternal('imported', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByRangeEnd() {
    return addSortByInternal('rangeEnd', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByRangeEndDesc() {
    return addSortByInternal('rangeEnd', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByRangeStart() {
    return addSortByInternal('rangeStart', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy>
      thenByRangeStartDesc() {
    return addSortByInternal('rangeStart', Sort.desc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
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
  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByImported() {
    return addDistinctByInternal('imported');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByRangeEnd() {
    return addDistinctByInternal('rangeEnd');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByRangeStart() {
    return addDistinctByInternal('rangeStart');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctBySize() {
    return addDistinctByInternal('size');
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension BarcodeBatchQueryProperty
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QQueryProperty> {
  QueryBuilder<BarcodeBatch, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<BarcodeBatch, bool, QQueryOperations> importedProperty() {
    return addPropertyNameInternal('imported');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> rangeEndProperty() {
    return addPropertyNameInternal('rangeEnd');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> rangeStartProperty() {
    return addPropertyNameInternal('rangeStart');
  }

  QueryBuilder<BarcodeBatch, double, QQueryOperations> sizeProperty() {
    return addPropertyNameInternal('size');
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}
