// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'object_bounding_box.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetObjectBoundingBoxCollection on Isar {
  IsarCollection<ObjectBoundingBox> get objectBoundingBoxs => getCollection();
}

const ObjectBoundingBoxSchema = CollectionSchema(
  name: 'ObjectBoundingBox',
  schema:
      '{"name":"ObjectBoundingBox","idName":"id","properties":[{"name":"boundingBox","type":"DoubleList"},{"name":"hashCode","type":"Long"},{"name":"mlTagID","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'boundingBox': 0, 'hashCode': 1, 'mlTagID': 2},
  listProperties: {'boundingBox'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _objectBoundingBoxGetId,
  setId: _objectBoundingBoxSetId,
  getLinks: _objectBoundingBoxGetLinks,
  attachLinks: _objectBoundingBoxAttachLinks,
  serializeNative: _objectBoundingBoxSerializeNative,
  deserializeNative: _objectBoundingBoxDeserializeNative,
  deserializePropNative: _objectBoundingBoxDeserializePropNative,
  serializeWeb: _objectBoundingBoxSerializeWeb,
  deserializeWeb: _objectBoundingBoxDeserializeWeb,
  deserializePropWeb: _objectBoundingBoxDeserializePropWeb,
  version: 3,
);

int? _objectBoundingBoxGetId(ObjectBoundingBox object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _objectBoundingBoxSetId(ObjectBoundingBox object, int id) {
  object.id = id;
}

List<IsarLinkBase> _objectBoundingBoxGetLinks(ObjectBoundingBox object) {
  return [];
}

void _objectBoundingBoxSerializeNative(
    IsarCollection<ObjectBoundingBox> collection,
    IsarRawObject rawObj,
    ObjectBoundingBox object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.boundingBox;
  dynamicSize += (value0.length) * 8;
  final _boundingBox = value0;
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.mlTagID;
  final _mlTagID = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDoubleList(offsets[0], _boundingBox);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeLong(offsets[2], _mlTagID);
}

ObjectBoundingBox _objectBoundingBoxDeserializeNative(
    IsarCollection<ObjectBoundingBox> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ObjectBoundingBox();
  object.boundingBox = reader.readDoubleList(offsets[0]) ?? [];
  object.id = id;
  object.mlTagID = reader.readLong(offsets[2]);
  return object;
}

P _objectBoundingBoxDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _objectBoundingBoxSerializeWeb(
    IsarCollection<ObjectBoundingBox> collection, ObjectBoundingBox object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'boundingBox', object.boundingBox);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'mlTagID', object.mlTagID);
  return jsObj;
}

ObjectBoundingBox _objectBoundingBoxDeserializeWeb(
    IsarCollection<ObjectBoundingBox> collection, dynamic jsObj) {
  final object = ObjectBoundingBox();
  object.boundingBox = (IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<double>() ??
      [];
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.mlTagID =
      IsarNative.jsObjectGet(jsObj, 'mlTagID') ?? double.negativeInfinity;
  return object;
}

P _objectBoundingBoxDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'boundingBox':
      return ((IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<double>() ??
          []) as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'mlTagID':
      return (IsarNative.jsObjectGet(jsObj, 'mlTagID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _objectBoundingBoxAttachLinks(
    IsarCollection col, int id, ObjectBoundingBox object) {}

extension ObjectBoundingBoxQueryWhereSort
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QWhere> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ObjectBoundingBoxQueryWhere
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QWhereClause> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
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

extension ObjectBoundingBoxQueryFilter
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QFilterCondition> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      boundingBoxAnyGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      boundingBoxAnyLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      boundingBoxAnyBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'boundingBox',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      mlTagIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      mlTagIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      mlTagIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      mlTagIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'mlTagID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ObjectBoundingBoxQueryLinks
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QFilterCondition> {}

extension ObjectBoundingBoxQueryWhereSortBy
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QSortBy> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByMlTagID() {
    return addSortByInternal('mlTagID', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByMlTagIDDesc() {
    return addSortByInternal('mlTagID', Sort.desc);
  }
}

extension ObjectBoundingBoxQueryWhereSortThenBy
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QSortThenBy> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByMlTagID() {
    return addSortByInternal('mlTagID', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByMlTagIDDesc() {
    return addSortByInternal('mlTagID', Sort.desc);
  }
}

extension ObjectBoundingBoxQueryWhereDistinct
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct>
      distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct>
      distinctByMlTagID() {
    return addDistinctByInternal('mlTagID');
  }
}

extension ObjectBoundingBoxQueryProperty
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QQueryProperty> {
  QueryBuilder<ObjectBoundingBox, List<double>, QQueryOperations>
      boundingBoxProperty() {
    return addPropertyNameInternal('boundingBox');
  }

  QueryBuilder<ObjectBoundingBox, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<ObjectBoundingBox, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ObjectBoundingBox, int, QQueryOperations> mlTagIDProperty() {
    return addPropertyNameInternal('mlTagID');
  }
}
