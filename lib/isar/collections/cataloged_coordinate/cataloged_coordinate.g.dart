// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'cataloged_coordinate.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCatalogedCoordinateCollection on Isar {
  IsarCollection<CatalogedCoordinate> get catalogedCoordinates =>
      getCollection();
}

const CatalogedCoordinateSchema = CollectionSchema(
  name: 'CatalogedCoordinate',
  schema:
      '{"name":"CatalogedCoordinate","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"coordinate","type":"DoubleList"},{"name":"gridUID","type":"Long"},{"name":"rotation","type":"DoubleList"},{"name":"timestamp","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'barcodeUID': 0,
    'coordinate': 1,
    'gridUID': 2,
    'rotation': 3,
    'timestamp': 4
  },
  listProperties: {'coordinate', 'rotation'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _catalogedCoordinateGetId,
  setId: _catalogedCoordinateSetId,
  getLinks: _catalogedCoordinateGetLinks,
  attachLinks: _catalogedCoordinateAttachLinks,
  serializeNative: _catalogedCoordinateSerializeNative,
  deserializeNative: _catalogedCoordinateDeserializeNative,
  deserializePropNative: _catalogedCoordinateDeserializePropNative,
  serializeWeb: _catalogedCoordinateSerializeWeb,
  deserializeWeb: _catalogedCoordinateDeserializeWeb,
  deserializePropWeb: _catalogedCoordinateDeserializePropWeb,
  version: 3,
);

int? _catalogedCoordinateGetId(CatalogedCoordinate object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _catalogedCoordinateSetId(CatalogedCoordinate object, int id) {
  object.id = id;
}

List<IsarLinkBase> _catalogedCoordinateGetLinks(CatalogedCoordinate object) {
  return [];
}

const _catalogedCoordinateVector3Converter = Vector3Converter();

void _catalogedCoordinateSerializeNative(
    IsarCollection<CatalogedCoordinate> collection,
    IsarRawObject rawObj,
    CatalogedCoordinate object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUID;
  final _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_barcodeUID.length) as int;
  final value1 = _catalogedCoordinateVector3Converter.toIsar(object.coordinate);
  dynamicSize += (value1?.length ?? 0) * 8;
  final _coordinate = value1;
  final value2 = object.gridUID;
  final _gridUID = value2;
  final value3 = _catalogedCoordinateVector3Converter.toIsar(object.rotation);
  dynamicSize += (value3?.length ?? 0) * 8;
  final _rotation = value3;
  final value4 = object.timestamp;
  final _timestamp = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _barcodeUID);
  writer.writeDoubleList(offsets[1], _coordinate);
  writer.writeLong(offsets[2], _gridUID);
  writer.writeDoubleList(offsets[3], _rotation);
  writer.writeLong(offsets[4], _timestamp);
}

CatalogedCoordinate _catalogedCoordinateDeserializeNative(
    IsarCollection<CatalogedCoordinate> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CatalogedCoordinate();
  object.barcodeUID = reader.readString(offsets[0]);
  object.coordinate = _catalogedCoordinateVector3Converter
      .fromIsar(reader.readDoubleList(offsets[1]));
  object.gridUID = reader.readLong(offsets[2]);
  object.id = id;
  object.rotation = _catalogedCoordinateVector3Converter
      .fromIsar(reader.readDoubleList(offsets[3]));
  object.timestamp = reader.readLong(offsets[4]);
  return object;
}

P _catalogedCoordinateDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_catalogedCoordinateVector3Converter
          .fromIsar(reader.readDoubleList(offset))) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (_catalogedCoordinateVector3Converter
          .fromIsar(reader.readDoubleList(offset))) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _catalogedCoordinateSerializeWeb(
    IsarCollection<CatalogedCoordinate> collection,
    CatalogedCoordinate object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'coordinate',
      _catalogedCoordinateVector3Converter.toIsar(object.coordinate));
  IsarNative.jsObjectSet(jsObj, 'gridUID', object.gridUID);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'rotation',
      _catalogedCoordinateVector3Converter.toIsar(object.rotation));
  IsarNative.jsObjectSet(jsObj, 'timestamp', object.timestamp);
  return jsObj;
}

CatalogedCoordinate _catalogedCoordinateDeserializeWeb(
    IsarCollection<CatalogedCoordinate> collection, dynamic jsObj) {
  final object = CatalogedCoordinate();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '';
  object.coordinate = _catalogedCoordinateVector3Converter.fromIsar(
      (IsarNative.jsObjectGet(jsObj, 'coordinate') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<double>());
  object.gridUID =
      IsarNative.jsObjectGet(jsObj, 'gridUID') ?? double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.rotation = _catalogedCoordinateVector3Converter.fromIsar(
      (IsarNative.jsObjectGet(jsObj, 'rotation') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<double>());
  object.timestamp =
      IsarNative.jsObjectGet(jsObj, 'timestamp') ?? double.negativeInfinity;
  return object;
}

P _catalogedCoordinateDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '') as P;
    case 'coordinate':
      return (_catalogedCoordinateVector3Converter.fromIsar(
          (IsarNative.jsObjectGet(jsObj, 'coordinate') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<double>())) as P;
    case 'gridUID':
      return (IsarNative.jsObjectGet(jsObj, 'gridUID') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'rotation':
      return (_catalogedCoordinateVector3Converter.fromIsar(
          (IsarNative.jsObjectGet(jsObj, 'rotation') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<double>())) as P;
    case 'timestamp':
      return (IsarNative.jsObjectGet(jsObj, 'timestamp') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _catalogedCoordinateAttachLinks(
    IsarCollection col, int id, CatalogedCoordinate object) {}

extension CatalogedCoordinateQueryWhereSort
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QWhere> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CatalogedCoordinateQueryWhere
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QWhereClause> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idBetween(
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

extension CatalogedCoordinateQueryFilter on QueryBuilder<CatalogedCoordinate,
    CatalogedCoordinate, QFilterCondition> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'coordinate',
      value: null,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'coordinate',
      value: null,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateAnyGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'coordinate',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateAnyLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'coordinate',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateAnyBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'coordinate',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'gridUID',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'gridUID',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'gridUID',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'gridUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'rotation',
      value: null,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'rotation',
      value: null,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationAnyGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'rotation',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationAnyLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'rotation',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationAnyBetween(double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'rotation',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
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

extension CatalogedCoordinateQueryLinks on QueryBuilder<CatalogedCoordinate,
    CatalogedCoordinate, QFilterCondition> {}

extension CatalogedCoordinateQueryWhereSortBy
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QSortBy> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByGridUID() {
    return addSortByInternal('gridUID', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByGridUIDDesc() {
    return addSortByInternal('gridUID', Sort.desc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension CatalogedCoordinateQueryWhereSortThenBy
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QSortThenBy> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByGridUID() {
    return addSortByInternal('gridUID', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByGridUIDDesc() {
    return addSortByInternal('gridUID', Sort.desc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension CatalogedCoordinateQueryWhereDistinct
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctByGridUID() {
    return addDistinctByInternal('gridUID');
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension CatalogedCoordinateQueryProperty
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QQueryProperty> {
  QueryBuilder<CatalogedCoordinate, String, QQueryOperations>
      barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<CatalogedCoordinate, vm.Vector3?, QQueryOperations>
      coordinateProperty() {
    return addPropertyNameInternal('coordinate');
  }

  QueryBuilder<CatalogedCoordinate, int, QQueryOperations> gridUIDProperty() {
    return addPropertyNameInternal('gridUID');
  }

  QueryBuilder<CatalogedCoordinate, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CatalogedCoordinate, vm.Vector3?, QQueryOperations>
      rotationProperty() {
    return addPropertyNameInternal('rotation');
  }

  QueryBuilder<CatalogedCoordinate, int, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}
