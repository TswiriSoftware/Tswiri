// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_property.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetBarcodePropertyCollection on Isar {
  IsarCollection<BarcodeProperty> get barcodePropertys => getCollection();
}

const BarcodePropertySchema = CollectionSchema(
  name: 'BarcodeProperty',
  schema:
      '{"name":"BarcodeProperty","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"size","type":"Double"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'barcodeUID': 0, 'size': 1},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _barcodePropertyGetId,
  setId: _barcodePropertySetId,
  getLinks: _barcodePropertyGetLinks,
  attachLinks: _barcodePropertyAttachLinks,
  serializeNative: _barcodePropertySerializeNative,
  deserializeNative: _barcodePropertyDeserializeNative,
  deserializePropNative: _barcodePropertyDeserializePropNative,
  serializeWeb: _barcodePropertySerializeWeb,
  deserializeWeb: _barcodePropertyDeserializeWeb,
  deserializePropWeb: _barcodePropertyDeserializePropWeb,
  version: 3,
);

int? _barcodePropertyGetId(BarcodeProperty object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _barcodePropertySetId(BarcodeProperty object, int id) {
  object.id = id;
}

List<IsarLinkBase> _barcodePropertyGetLinks(BarcodeProperty object) {
  return [];
}

void _barcodePropertySerializeNative(
    IsarCollection<BarcodeProperty> collection,
    IsarRawObject rawObj,
    BarcodeProperty object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUID;
  final _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_barcodeUID.length) as int;
  final value1 = object.size;
  final _size = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _barcodeUID);
  writer.writeDouble(offsets[1], _size);
}

BarcodeProperty _barcodePropertyDeserializeNative(
    IsarCollection<BarcodeProperty> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = BarcodeProperty();
  object.barcodeUID = reader.readString(offsets[0]);
  object.id = id;
  object.size = reader.readDouble(offsets[1]);
  return object;
}

P _barcodePropertyDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _barcodePropertySerializeWeb(
    IsarCollection<BarcodeProperty> collection, BarcodeProperty object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'size', object.size);
  return jsObj;
}

BarcodeProperty _barcodePropertyDeserializeWeb(
    IsarCollection<BarcodeProperty> collection, dynamic jsObj) {
  final object = BarcodeProperty();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.size =
      IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity;
  return object;
}

P _barcodePropertyDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'size':
      return (IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity)
          as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _barcodePropertyAttachLinks(
    IsarCollection col, int id, BarcodeProperty object) {}

extension BarcodePropertyQueryWhereSort
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QWhere> {
  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension BarcodePropertyQueryWhere
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QWhereClause> {
  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterWhereClause>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterWhereClause> idBetween(
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

extension BarcodePropertyQueryFilter
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QFilterCondition> {
  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
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

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
      sizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
      sizeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterFilterCondition>
      sizeBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'size',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension BarcodePropertyQueryLinks
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QFilterCondition> {}

extension BarcodePropertyQueryWhereSortBy
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QSortBy> {
  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy>
      sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy> sortBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy>
      sortBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }
}

extension BarcodePropertyQueryWhereSortThenBy
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QSortThenBy> {
  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy>
      thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy> thenBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QAfterSortBy>
      thenBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }
}

extension BarcodePropertyQueryWhereDistinct
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QDistinct> {
  QueryBuilder<BarcodeProperty, BarcodeProperty, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<BarcodeProperty, BarcodeProperty, QDistinct> distinctBySize() {
    return addDistinctByInternal('size');
  }
}

extension BarcodePropertyQueryProperty
    on QueryBuilder<BarcodeProperty, BarcodeProperty, QQueryProperty> {
  QueryBuilder<BarcodeProperty, String, QQueryOperations> barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<BarcodeProperty, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<BarcodeProperty, double, QQueryOperations> sizeProperty() {
    return addPropertyNameInternal('size');
  }
}
