// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetContainerTagCollection on Isar {
  IsarCollection<ContainerTag> get containerTags {
    return getCollection('ContainerTag');
  }
}

final ContainerTagSchema = CollectionSchema(
  name: 'ContainerTag',
  schema:
      '{"name":"ContainerTag","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"textTagID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ContainerTagNativeAdapter(),
  webAdapter: const _ContainerTagWebAdapter(),
  idName: 'id',
  propertyIds: {'containerUID': 0, 'textTagID': 1},
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

class _ContainerTagWebAdapter extends IsarWebTypeAdapter<ContainerTag> {
  const _ContainerTagWebAdapter();

  @override
  Object serialize(
      IsarCollection<ContainerTag> collection, ContainerTag object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'textTagID', object.textTagID);
    return jsObj;
  }

  @override
  ContainerTag deserialize(
      IsarCollection<ContainerTag> collection, dynamic jsObj) {
    final object = ContainerTag();
    object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.textTagID =
        IsarNative.jsObjectGet(jsObj, 'textTagID') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'containerUID':
        return (IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'textTagID':
        return (IsarNative.jsObjectGet(jsObj, 'textTagID') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerTag object) {}
}

class _ContainerTagNativeAdapter extends IsarNativeTypeAdapter<ContainerTag> {
  const _ContainerTagNativeAdapter();

  @override
  void serialize(
      IsarCollection<ContainerTag> collection,
      IsarRawObject rawObj,
      ContainerTag object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.containerUID;
    final _containerUID = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_containerUID.length) as int;
    final value1 = object.textTagID;
    final _textTagID = value1;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _containerUID);
    writer.writeLong(offsets[1], _textTagID);
  }

  @override
  ContainerTag deserialize(IsarCollection<ContainerTag> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = ContainerTag();
    object.containerUID = reader.readString(offsets[0]);
    object.id = id;
    object.textTagID = reader.readLong(offsets[1]);
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
      case 1:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerTag object) {}
}

extension ContainerTagQueryWhereSort
    on QueryBuilder<ContainerTag, ContainerTag, QWhere> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ContainerTagQueryWhere
    on QueryBuilder<ContainerTag, ContainerTag, QWhereClause> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idBetween(
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

extension ContainerTagQueryFilter
    on QueryBuilder<ContainerTag, ContainerTag, QFilterCondition> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      textTagIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'textTagID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      textTagIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'textTagID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      textTagIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'textTagID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      textTagIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'textTagID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ContainerTagQueryLinks
    on QueryBuilder<ContainerTag, ContainerTag, QFilterCondition> {}

extension ContainerTagQueryWhereSortBy
    on QueryBuilder<ContainerTag, ContainerTag, QSortBy> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy>
      sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTextTagID() {
    return addSortByInternal('textTagID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTextTagIDDesc() {
    return addSortByInternal('textTagID', Sort.desc);
  }
}

extension ContainerTagQueryWhereSortThenBy
    on QueryBuilder<ContainerTag, ContainerTag, QSortThenBy> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy>
      thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTextTagID() {
    return addSortByInternal('textTagID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTextTagIDDesc() {
    return addSortByInternal('textTagID', Sort.desc);
  }
}

extension ContainerTagQueryWhereDistinct
    on QueryBuilder<ContainerTag, ContainerTag, QDistinct> {
  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByContainerUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByTextTagID() {
    return addDistinctByInternal('textTagID');
  }
}

extension ContainerTagQueryProperty
    on QueryBuilder<ContainerTag, ContainerTag, QQueryProperty> {
  QueryBuilder<ContainerTag, String, QQueryOperations> containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> textTagIDProperty() {
    return addPropertyNameInternal('textTagID');
  }
}
