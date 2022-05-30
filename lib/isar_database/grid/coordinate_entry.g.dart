// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinate_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCoordinateEntryCollection on Isar {
  IsarCollection<CoordinateEntry> get coordinateEntrys => getCollection();
}

const CoordinateEntrySchema = CollectionSchema(
  name: 'CoordinateEntry',
  schema:
      '{"name":"CoordinateEntry","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"gridUID","type":"String"},{"name":"timestamp","type":"Long"},{"name":"x","type":"Double"},{"name":"y","type":"Double"},{"name":"z","type":"Double"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'barcodeUID': 0,
    'gridUID': 1,
    'timestamp': 2,
    'x': 3,
    'y': 4,
    'z': 5
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _coordinateEntryGetId,
  setId: _coordinateEntrySetId,
  getLinks: _coordinateEntryGetLinks,
  attachLinks: _coordinateEntryAttachLinks,
  serializeNative: _coordinateEntrySerializeNative,
  deserializeNative: _coordinateEntryDeserializeNative,
  deserializePropNative: _coordinateEntryDeserializePropNative,
  serializeWeb: _coordinateEntrySerializeWeb,
  deserializeWeb: _coordinateEntryDeserializeWeb,
  deserializePropWeb: _coordinateEntryDeserializePropWeb,
  version: 3,
);

int? _coordinateEntryGetId(CoordinateEntry object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _coordinateEntrySetId(CoordinateEntry object, int id) {
  object.id = id;
}

List<IsarLinkBase> _coordinateEntryGetLinks(CoordinateEntry object) {
  return [];
}

void _coordinateEntrySerializeNative(
    IsarCollection<CoordinateEntry> collection,
    IsarRawObject rawObj,
    CoordinateEntry object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUID;
  final _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_barcodeUID.length) as int;
  final value1 = object.gridUID;
  final _gridUID = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_gridUID.length) as int;
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
  writer.writeBytes(offsets[0], _barcodeUID);
  writer.writeBytes(offsets[1], _gridUID);
  writer.writeLong(offsets[2], _timestamp);
  writer.writeDouble(offsets[3], _x);
  writer.writeDouble(offsets[4], _y);
  writer.writeDouble(offsets[5], _z);
}

CoordinateEntry _coordinateEntryDeserializeNative(
    IsarCollection<CoordinateEntry> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CoordinateEntry();
  object.barcodeUID = reader.readString(offsets[0]);
  object.gridUID = reader.readString(offsets[1]);
  object.id = id;
  object.timestamp = reader.readLong(offsets[2]);
  object.x = reader.readDouble(offsets[3]);
  object.y = reader.readDouble(offsets[4]);
  object.z = reader.readDouble(offsets[5]);
  return object;
}

P _coordinateEntryDeserializePropNative<P>(
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

dynamic _coordinateEntrySerializeWeb(
    IsarCollection<CoordinateEntry> collection, CoordinateEntry object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'gridUID', object.gridUID);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
  IsarNative.jsObjectSet(jsObj, 'x', object.x);
  IsarNative.jsObjectSet(jsObj, 'y', object.y);
  IsarNative.jsObjectSet(jsObj, 'z', object.z);
  return jsObj;
}

CoordinateEntry _coordinateEntryDeserializeWeb(
    IsarCollection<CoordinateEntry> collection, dynamic jsObj) {
  final object = CoordinateEntry();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '';
  object.gridUID = IsarNative.jsObjectGet(jsObj, 'gridUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.timestamp =
      IsarNative.jsObjectGet(jsObj, 'timestamp') ?? double.negativeInfinity;
  object.x = IsarNative.jsObjectGet(jsObj, 'x') ?? double.negativeInfinity;
  object.y = IsarNative.jsObjectGet(jsObj, 'y') ?? double.negativeInfinity;
  object.z = IsarNative.jsObjectGet(jsObj, 'z') ?? double.negativeInfinity;
  return object;
}

P _coordinateEntryDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '') as P;
    case 'gridUID':
      return (IsarNative.jsObjectGet(jsObj, 'gridUID') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
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

void _coordinateEntryAttachLinks(
    IsarCollection col, int id, CoordinateEntry object) {}

extension CoordinateEntryQueryWhereSort
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QWhere> {
  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CoordinateEntryQueryWhere
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QWhereClause> {
  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterWhereClause> idBetween(
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

extension CoordinateEntryQueryFilter
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QFilterCondition> {
  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'barcodeUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'gridUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'gridUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'gridUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'gridUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'gridUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'gridUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'gridUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      gridUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'gridUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
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

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      xGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      xLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      xBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'x',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      yGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      yLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      yBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'y',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      zGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      zLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterFilterCondition>
      zBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'z',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension CoordinateEntryQueryLinks
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QFilterCondition> {}

extension CoordinateEntryQueryWhereSortBy
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QSortBy> {
  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByGridUID() {
    return addSortByInternal('gridUID', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      sortByGridUIDDesc() {
    return addSortByInternal('gridUID', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> sortByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension CoordinateEntryQueryWhereSortThenBy
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QSortThenBy> {
  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByGridUID() {
    return addSortByInternal('gridUID', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      thenByGridUIDDesc() {
    return addSortByInternal('gridUID', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy>
      thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QAfterSortBy> thenByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension CoordinateEntryQueryWhereDistinct
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct> {
  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct> distinctByGridUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('gridUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct>
      distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct> distinctByX() {
    return addDistinctByInternal('x');
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct> distinctByY() {
    return addDistinctByInternal('y');
  }

  QueryBuilder<CoordinateEntry, CoordinateEntry, QDistinct> distinctByZ() {
    return addDistinctByInternal('z');
  }
}

extension CoordinateEntryQueryProperty
    on QueryBuilder<CoordinateEntry, CoordinateEntry, QQueryProperty> {
  QueryBuilder<CoordinateEntry, String, QQueryOperations> barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<CoordinateEntry, String, QQueryOperations> gridUIDProperty() {
    return addPropertyNameInternal('gridUID');
  }

  QueryBuilder<CoordinateEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CoordinateEntry, int, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }

  QueryBuilder<CoordinateEntry, double, QQueryOperations> xProperty() {
    return addPropertyNameInternal('x');
  }

  QueryBuilder<CoordinateEntry, double, QQueryOperations> yProperty() {
    return addPropertyNameInternal('y');
  }

  QueryBuilder<CoordinateEntry, double, QQueryOperations> zProperty() {
    return addPropertyNameInternal('z');
  }
}
