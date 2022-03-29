// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetMlTagCollection on Isar {
  IsarCollection<MlTag> get mlTags {
    return getCollection('MlTag');
  }
}

final MlTagSchema = CollectionSchema(
  name: 'MlTag',
  schema:
      '{"name":"MlTag","idName":"id","properties":[{"name":"tag","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _MlTagNativeAdapter(),
  webAdapter: const _MlTagWebAdapter(),
  idName: 'id',
  propertyIds: {'tag': 0},
  listProperties: {},
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

class _MlTagWebAdapter extends IsarWebTypeAdapter<MlTag> {
  const _MlTagWebAdapter();

  @override
  Object serialize(IsarCollection<MlTag> collection, MlTag object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'tag', object.tag);
    return jsObj;
  }

  @override
  MlTag deserialize(IsarCollection<MlTag> collection, dynamic jsObj) {
    final object = MlTag();
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.tag = IsarNative.jsObjectGet(jsObj, 'tag') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'tag':
        return (IsarNative.jsObjectGet(jsObj, 'tag') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, MlTag object) {}
}

class _MlTagNativeAdapter extends IsarNativeTypeAdapter<MlTag> {
  const _MlTagNativeAdapter();

  @override
  void serialize(IsarCollection<MlTag> collection, IsarRawObject rawObj,
      MlTag object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.tag;
    final _tag = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_tag.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _tag);
  }

  @override
  MlTag deserialize(IsarCollection<MlTag> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = MlTag();
    object.id = id;
    object.tag = reader.readString(offsets[0]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, MlTag object) {}
}

extension MlTagQueryWhereSort on QueryBuilder<MlTag, MlTag, QWhere> {
  QueryBuilder<MlTag, MlTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension MlTagQueryWhere on QueryBuilder<MlTag, MlTag, QWhereClause> {
  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idBetween(
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

extension MlTagQueryFilter on QueryBuilder<MlTag, MlTag, QFilterCondition> {
  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tag',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'tag',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension MlTagQueryLinks on QueryBuilder<MlTag, MlTag, QFilterCondition> {}

extension MlTagQueryWhereSortBy on QueryBuilder<MlTag, MlTag, QSortBy> {
  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTag() {
    return addSortByInternal('tag', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTagDesc() {
    return addSortByInternal('tag', Sort.desc);
  }
}

extension MlTagQueryWhereSortThenBy on QueryBuilder<MlTag, MlTag, QSortThenBy> {
  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTag() {
    return addSortByInternal('tag', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTagDesc() {
    return addSortByInternal('tag', Sort.desc);
  }
}

extension MlTagQueryWhereDistinct on QueryBuilder<MlTag, MlTag, QDistinct> {
  QueryBuilder<MlTag, MlTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByTag(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tag', caseSensitive: caseSensitive);
  }
}

extension MlTagQueryProperty on QueryBuilder<MlTag, MlTag, QQueryProperty> {
  QueryBuilder<MlTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MlTag, String, QQueryOperations> tagProperty() {
    return addPropertyNameInternal('tag');
  }
}
