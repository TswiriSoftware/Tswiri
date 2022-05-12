// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_bounding_box.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetTagBoundingBoxCollection on Isar {
  IsarCollection<TagBoundingBox> get tagBoundingBoxs {
    return getCollection('TagBoundingBox');
  }
}

final TagBoundingBoxSchema = CollectionSchema(
  name: 'TagBoundingBox',
  schema:
      '{"name":"TagBoundingBox","idName":"id","properties":[{"name":"boundingBox","type":"DoubleList"},{"name":"mlTagID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _TagBoundingBoxNativeAdapter(),
  webAdapter: const _TagBoundingBoxWebAdapter(),
  idName: 'id',
  propertyIds: {'boundingBox': 0, 'mlTagID': 1},
  listProperties: {'boundingBox'},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _TagBoundingBoxWebAdapter extends IsarWebTypeAdapter<TagBoundingBox> {
  const _TagBoundingBoxWebAdapter();

  @override
  Object serialize(
      IsarCollection<TagBoundingBox> collection, TagBoundingBox object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'boundingBox', object.boundingBox);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'mlTagID', object.mlTagID);
    return jsObj;
  }

  @override
  TagBoundingBox deserialize(
      IsarCollection<TagBoundingBox> collection, dynamic jsObj) {
    final object = TagBoundingBox();
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

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'boundingBox':
        return ((IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
                ?.map((e) => e ?? double.negativeInfinity)
                .toList()
                .cast<double>() ??
            []) as P;
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

  @override
  void attachLinks(Isar isar, int id, TagBoundingBox object) {}
}

class _TagBoundingBoxNativeAdapter
    extends IsarNativeTypeAdapter<TagBoundingBox> {
  const _TagBoundingBoxNativeAdapter();

  @override
  void serialize(
      IsarCollection<TagBoundingBox> collection,
      IsarRawObject rawObj,
      TagBoundingBox object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.boundingBox;
    dynamicSize += (value0.length) * 8;
    final _boundingBox = value0;
    final value1 = object.mlTagID;
    final _mlTagID = value1;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDoubleList(offsets[0], _boundingBox);
    writer.writeLong(offsets[1], _mlTagID);
  }

  @override
  TagBoundingBox deserialize(IsarCollection<TagBoundingBox> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = TagBoundingBox();
    object.boundingBox = reader.readDoubleList(offsets[0]) ?? [];
    object.id = id;
    object.mlTagID = reader.readLong(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDoubleList(offset) ?? []) as P;
      case 1:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, TagBoundingBox object) {}
}

extension TagBoundingBoxQueryWhereSort
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QWhere> {
  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension TagBoundingBoxQueryWhere
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QWhereClause> {
  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }
}

extension TagBoundingBoxQueryFilter
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QFilterCondition> {
  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
      boundingBoxAnyGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
      boundingBoxAnyLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
      boundingBoxAnyBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'boundingBox',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
      mlTagIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterFilterCondition>
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

extension TagBoundingBoxQueryLinks
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QFilterCondition> {}

extension TagBoundingBoxQueryWhereSortBy
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QSortBy> {
  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy> sortByMlTagID() {
    return addSortByInternal('mlTagID', Sort.asc);
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy>
      sortByMlTagIDDesc() {
    return addSortByInternal('mlTagID', Sort.desc);
  }
}

extension TagBoundingBoxQueryWhereSortThenBy
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QSortThenBy> {
  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy> thenByMlTagID() {
    return addSortByInternal('mlTagID', Sort.asc);
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QAfterSortBy>
      thenByMlTagIDDesc() {
    return addSortByInternal('mlTagID', Sort.desc);
  }
}

extension TagBoundingBoxQueryWhereDistinct
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QDistinct> {
  QueryBuilder<TagBoundingBox, TagBoundingBox, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<TagBoundingBox, TagBoundingBox, QDistinct> distinctByMlTagID() {
    return addDistinctByInternal('mlTagID');
  }
}

extension TagBoundingBoxQueryProperty
    on QueryBuilder<TagBoundingBox, TagBoundingBox, QQueryProperty> {
  QueryBuilder<TagBoundingBox, List<double>, QQueryOperations>
      boundingBoxProperty() {
    return addPropertyNameInternal('boundingBox');
  }

  QueryBuilder<TagBoundingBox, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<TagBoundingBox, int, QQueryOperations> mlTagIDProperty() {
    return addPropertyNameInternal('mlTagID');
  }
}
