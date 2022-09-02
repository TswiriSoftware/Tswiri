// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_object.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLObjectCollection on Isar {
  IsarCollection<MLObject> get mLObjects => getCollection();
}

const MLObjectSchema = CollectionSchema(
  name: 'MLObject',
  schema:
      '{"name":"MLObject","idName":"id","properties":[{"name":"boundingBox","type":"DoubleList"},{"name":"hashCode","type":"Long"},{"name":"photoID","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'boundingBox': 0, 'hashCode': 1, 'photoID': 2},
  listProperties: {'boundingBox'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLObjectGetId,
  setId: _mLObjectSetId,
  getLinks: _mLObjectGetLinks,
  attachLinks: _mLObjectAttachLinks,
  serializeNative: _mLObjectSerializeNative,
  deserializeNative: _mLObjectDeserializeNative,
  deserializePropNative: _mLObjectDeserializePropNative,
  serializeWeb: _mLObjectSerializeWeb,
  deserializeWeb: _mLObjectDeserializeWeb,
  deserializePropWeb: _mLObjectDeserializePropWeb,
  version: 3,
);

int? _mLObjectGetId(MLObject object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLObjectSetId(MLObject object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLObjectGetLinks(MLObject object) {
  return [];
}

void _mLObjectSerializeNative(
    IsarCollection<MLObject> collection,
    IsarRawObject rawObj,
    MLObject object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.boundingBox;
  dynamicSize += (value0.length) * 8;
  final _boundingBox = value0;
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.photoID;
  final _photoID = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDoubleList(offsets[0], _boundingBox);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeLong(offsets[2], _photoID);
}

MLObject _mLObjectDeserializeNative(IsarCollection<MLObject> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = MLObject();
  object.boundingBox = reader.readDoubleList(offsets[0]) ?? [];
  object.id = id;
  object.photoID = reader.readLong(offsets[2]);
  return object;
}

P _mLObjectDeserializePropNative<P>(
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

dynamic _mLObjectSerializeWeb(
    IsarCollection<MLObject> collection, MLObject object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'boundingBox', object.boundingBox);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
  return jsObj;
}

MLObject _mLObjectDeserializeWeb(
    IsarCollection<MLObject> collection, dynamic jsObj) {
  final object = MLObject();
  object.boundingBox = (IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<double>() ??
      [];
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoID =
      IsarNative.jsObjectGet(jsObj, 'photoID') ?? double.negativeInfinity;
  return object;
}

P _mLObjectDeserializePropWeb<P>(Object jsObj, String propertyName) {
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
    case 'photoID':
      return (IsarNative.jsObjectGet(jsObj, 'photoID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLObjectAttachLinks(IsarCollection col, int id, MLObject object) {}

extension MLObjectQueryWhereSort on QueryBuilder<MLObject, MLObject, QWhere> {
  QueryBuilder<MLObject, MLObject, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension MLObjectQueryWhere on QueryBuilder<MLObject, MLObject, QWhereClause> {
  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idBetween(
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

extension MLObjectQueryFilter
    on QueryBuilder<MLObject, MLObject, QFilterCondition> {
  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxAnyGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxAnyLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> boundingBoxAnyBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'boundingBox',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'photoID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension MLObjectQueryLinks
    on QueryBuilder<MLObject, MLObject, QFilterCondition> {}

extension MLObjectQueryWhereSortBy
    on QueryBuilder<MLObject, MLObject, QSortBy> {
  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }
}

extension MLObjectQueryWhereSortThenBy
    on QueryBuilder<MLObject, MLObject, QSortThenBy> {
  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }
}

extension MLObjectQueryWhereDistinct
    on QueryBuilder<MLObject, MLObject, QDistinct> {
  QueryBuilder<MLObject, MLObject, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<MLObject, MLObject, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MLObject, MLObject, QDistinct> distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }
}

extension MLObjectQueryProperty
    on QueryBuilder<MLObject, MLObject, QQueryProperty> {
  QueryBuilder<MLObject, List<double>, QQueryOperations> boundingBoxProperty() {
    return addPropertyNameInternal('boundingBox');
  }

  QueryBuilder<MLObject, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<MLObject, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLObject, int, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }
}
