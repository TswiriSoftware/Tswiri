// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'cataloged_grid.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCatalogedGridCollection on Isar {
  IsarCollection<CatalogedGrid> get catalogedGrids => getCollection();
}

const CatalogedGridSchema = CollectionSchema(
  name: 'CatalogedGrid',
  schema:
      '{"name":"CatalogedGrid","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"parentBarcodeUID","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'barcodeUID': 0, 'parentBarcodeUID': 1},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _catalogedGridGetId,
  setId: _catalogedGridSetId,
  getLinks: _catalogedGridGetLinks,
  attachLinks: _catalogedGridAttachLinks,
  serializeNative: _catalogedGridSerializeNative,
  deserializeNative: _catalogedGridDeserializeNative,
  deserializePropNative: _catalogedGridDeserializePropNative,
  serializeWeb: _catalogedGridSerializeWeb,
  deserializeWeb: _catalogedGridDeserializeWeb,
  deserializePropWeb: _catalogedGridDeserializePropWeb,
  version: 3,
);

int? _catalogedGridGetId(CatalogedGrid object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _catalogedGridSetId(CatalogedGrid object, int id) {
  object.id = id;
}

List<IsarLinkBase> _catalogedGridGetLinks(CatalogedGrid object) {
  return [];
}

void _catalogedGridSerializeNative(
    IsarCollection<CatalogedGrid> collection,
    IsarRawObject rawObj,
    CatalogedGrid object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUID;
  final _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_barcodeUID.length) as int;
  final value1 = object.parentBarcodeUID;
  IsarUint8List? _parentBarcodeUID;
  if (value1 != null) {
    _parentBarcodeUID = IsarBinaryWriter.utf8Encoder.convert(value1);
  }
  dynamicSize += (_parentBarcodeUID?.length ?? 0) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _barcodeUID);
  writer.writeBytes(offsets[1], _parentBarcodeUID);
}

CatalogedGrid _catalogedGridDeserializeNative(
    IsarCollection<CatalogedGrid> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CatalogedGrid();
  object.barcodeUID = reader.readString(offsets[0]);
  object.id = id;
  object.parentBarcodeUID = reader.readStringOrNull(offsets[1]);
  return object;
}

P _catalogedGridDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _catalogedGridSerializeWeb(
    IsarCollection<CatalogedGrid> collection, CatalogedGrid object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'parentBarcodeUID', object.parentBarcodeUID);
  return jsObj;
}

CatalogedGrid _catalogedGridDeserializeWeb(
    IsarCollection<CatalogedGrid> collection, dynamic jsObj) {
  final object = CatalogedGrid();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.parentBarcodeUID = IsarNative.jsObjectGet(jsObj, 'parentBarcodeUID');
  return object;
}

P _catalogedGridDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'parentBarcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'parentBarcodeUID')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _catalogedGridAttachLinks(
    IsarCollection col, int id, CatalogedGrid object) {}

extension CatalogedGridQueryWhereSort
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QWhere> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CatalogedGridQueryWhere
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QWhereClause> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idBetween(
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

extension CatalogedGridQueryFilter
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QFilterCondition> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentBarcodeUID',
      value: null,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'parentBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'parentBarcodeUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'parentBarcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'parentBarcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CatalogedGridQueryLinks
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QFilterCondition> {}

extension CatalogedGridQueryWhereSortBy
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QSortBy> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      sortByParentBarcodeUID() {
    return addSortByInternal('parentBarcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      sortByParentBarcodeUIDDesc() {
    return addSortByInternal('parentBarcodeUID', Sort.desc);
  }
}

extension CatalogedGridQueryWhereSortThenBy
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QSortThenBy> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      thenByParentBarcodeUID() {
    return addSortByInternal('parentBarcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      thenByParentBarcodeUIDDesc() {
    return addSortByInternal('parentBarcodeUID', Sort.desc);
  }
}

extension CatalogedGridQueryWhereDistinct
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct> distinctByBarcodeUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct>
      distinctByParentBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('parentBarcodeUID',
        caseSensitive: caseSensitive);
  }
}

extension CatalogedGridQueryProperty
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QQueryProperty> {
  QueryBuilder<CatalogedGrid, String, QQueryOperations> barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<CatalogedGrid, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CatalogedGrid, String?, QQueryOperations>
      parentBarcodeUIDProperty() {
    return addPropertyNameInternal('parentBarcodeUID');
  }
}
