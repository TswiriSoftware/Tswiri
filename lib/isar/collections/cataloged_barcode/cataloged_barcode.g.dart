// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cataloged_barcode.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCatalogedBarcodeCollection on Isar {
  IsarCollection<CatalogedBarcode> get catalogedBarcodes => getCollection();
}

const CatalogedBarcodeSchema = CollectionSchema(
  name: 'CatalogedBarcode',
  schema:
      '{"name":"CatalogedBarcode","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"hashCode","type":"Long"},{"name":"size","type":"Double"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'barcodeUID': 0, 'hashCode': 1, 'size': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _catalogedBarcodeGetId,
  setId: _catalogedBarcodeSetId,
  getLinks: _catalogedBarcodeGetLinks,
  attachLinks: _catalogedBarcodeAttachLinks,
  serializeNative: _catalogedBarcodeSerializeNative,
  deserializeNative: _catalogedBarcodeDeserializeNative,
  deserializePropNative: _catalogedBarcodeDeserializePropNative,
  serializeWeb: _catalogedBarcodeSerializeWeb,
  deserializeWeb: _catalogedBarcodeDeserializeWeb,
  deserializePropWeb: _catalogedBarcodeDeserializePropWeb,
  version: 3,
);

int? _catalogedBarcodeGetId(CatalogedBarcode object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _catalogedBarcodeSetId(CatalogedBarcode object, int id) {
  object.id = id;
}

List<IsarLinkBase> _catalogedBarcodeGetLinks(CatalogedBarcode object) {
  return [];
}

void _catalogedBarcodeSerializeNative(
    IsarCollection<CatalogedBarcode> collection,
    IsarRawObject rawObj,
    CatalogedBarcode object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUID;
  final _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_barcodeUID.length) as int;
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.size;
  final _size = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _barcodeUID);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeDouble(offsets[2], _size);
}

CatalogedBarcode _catalogedBarcodeDeserializeNative(
    IsarCollection<CatalogedBarcode> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CatalogedBarcode();
  object.barcodeUID = reader.readString(offsets[0]);
  object.id = id;
  object.size = reader.readDouble(offsets[2]);
  return object;
}

P _catalogedBarcodeDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _catalogedBarcodeSerializeWeb(
    IsarCollection<CatalogedBarcode> collection, CatalogedBarcode object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'size', object.size);
  return jsObj;
}

CatalogedBarcode _catalogedBarcodeDeserializeWeb(
    IsarCollection<CatalogedBarcode> collection, dynamic jsObj) {
  final object = CatalogedBarcode();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.size =
      IsarNative.jsObjectGet(jsObj, 'size') ?? double.negativeInfinity;
  return object;
}

P _catalogedBarcodeDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '') as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
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

void _catalogedBarcodeAttachLinks(
    IsarCollection col, int id, CatalogedBarcode object) {}

extension CatalogedBarcodeQueryWhereSort
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QWhere> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CatalogedBarcodeQueryWhere
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QWhereClause> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause> idBetween(
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

extension CatalogedBarcodeQueryFilter
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QFilterCondition> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeGreaterThan(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeLessThan(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeBetween(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      sizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      sizeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'size',
      value: value,
    ));
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

extension CatalogedBarcodeQueryLinks
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QFilterCondition> {}

extension CatalogedBarcodeQueryWhereSortBy
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QSortBy> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> sortBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }
}

extension CatalogedBarcodeQueryWhereSortThenBy
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QSortThenBy> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> thenBySize() {
    return addSortByInternal('size', Sort.asc);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenBySizeDesc() {
    return addSortByInternal('size', Sort.desc);
  }
}

extension CatalogedBarcodeQueryWhereDistinct
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct> distinctBySize() {
    return addDistinctByInternal('size');
  }
}

extension CatalogedBarcodeQueryProperty
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QQueryProperty> {
  QueryBuilder<CatalogedBarcode, String, QQueryOperations>
      barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<CatalogedBarcode, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<CatalogedBarcode, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CatalogedBarcode, double, QQueryOperations> sizeProperty() {
    return addPropertyNameInternal('size');
  }
}
