// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_text.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetTagTextCollection on Isar {
  IsarCollection<TagText> get tagTexts {
    return getCollection('TagText');
  }
}

final TagTextSchema = CollectionSchema(
  name: 'TagText',
  schema:
      '{"name":"TagText","idName":"id","properties":[{"name":"tag","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _TagTextNativeAdapter(),
  webAdapter: const _TagTextWebAdapter(),
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

class _TagTextWebAdapter extends IsarWebTypeAdapter<TagText> {
  const _TagTextWebAdapter();

  @override
  Object serialize(IsarCollection<TagText> collection, TagText object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'tag', object.tag);
    return jsObj;
  }

  @override
  TagText deserialize(IsarCollection<TagText> collection, dynamic jsObj) {
    final object = TagText();
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
  void attachLinks(Isar isar, int id, TagText object) {}
}

class _TagTextNativeAdapter extends IsarNativeTypeAdapter<TagText> {
  const _TagTextNativeAdapter();

  @override
  void serialize(IsarCollection<TagText> collection, IsarRawObject rawObj,
      TagText object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
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
  TagText deserialize(IsarCollection<TagText> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = TagText();
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
  void attachLinks(Isar isar, int id, TagText object) {}
}

extension TagTextQueryWhereSort on QueryBuilder<TagText, TagText, QWhere> {
  QueryBuilder<TagText, TagText, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension TagTextQueryWhere on QueryBuilder<TagText, TagText, QWhereClause> {
  QueryBuilder<TagText, TagText, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<TagText, TagText, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> idBetween(
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

extension TagTextQueryFilter
    on QueryBuilder<TagText, TagText, QFilterCondition> {
  QueryBuilder<TagText, TagText, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagEqualTo(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagGreaterThan(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagLessThan(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagBetween(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagStartsWith(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagEndsWith(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'tag',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> tagMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'tag',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension TagTextQueryLinks
    on QueryBuilder<TagText, TagText, QFilterCondition> {}

extension TagTextQueryWhereSortBy on QueryBuilder<TagText, TagText, QSortBy> {
  QueryBuilder<TagText, TagText, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByTag() {
    return addSortByInternal('tag', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByTagDesc() {
    return addSortByInternal('tag', Sort.desc);
  }
}

extension TagTextQueryWhereSortThenBy
    on QueryBuilder<TagText, TagText, QSortThenBy> {
  QueryBuilder<TagText, TagText, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByTag() {
    return addSortByInternal('tag', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByTagDesc() {
    return addSortByInternal('tag', Sort.desc);
  }
}

extension TagTextQueryWhereDistinct
    on QueryBuilder<TagText, TagText, QDistinct> {
  QueryBuilder<TagText, TagText, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<TagText, TagText, QDistinct> distinctByTag(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('tag', caseSensitive: caseSensitive);
  }
}

extension TagTextQueryProperty
    on QueryBuilder<TagText, TagText, QQueryProperty> {
  QueryBuilder<TagText, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<TagText, String, QQueryOperations> tagProperty() {
    return addPropertyNameInternal('tag');
  }
}
