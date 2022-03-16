// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_relationship.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetContainerRelationshipCollection on Isar {
  IsarCollection<ContainerRelationship> get containerRelationships {
    return getCollection('ContainerRelationship');
  }
}

final ContainerRelationshipSchema = CollectionSchema(
  name: 'ContainerRelationship',
  schema:
      '{"name":"ContainerRelationship","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"parentUID","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ContainerRelationshipNativeAdapter(),
  webAdapter: const _ContainerRelationshipWebAdapter(),
  idName: 'id',
  propertyIds: {'containerUID': 0, 'parentUID': 1},
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

class _ContainerRelationshipWebAdapter
    extends IsarWebTypeAdapter<ContainerRelationship> {
  const _ContainerRelationshipWebAdapter();

  @override
  Object serialize(IsarCollection<ContainerRelationship> collection,
      ContainerRelationship object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'parentUID', object.parentUID);
    return jsObj;
  }

  @override
  ContainerRelationship deserialize(
      IsarCollection<ContainerRelationship> collection, dynamic jsObj) {
    final object = ContainerRelationship();
    object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.parentUID = IsarNative.jsObjectGet(jsObj, 'parentUID') ?? '';
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
      case 'parentUID':
        return (IsarNative.jsObjectGet(jsObj, 'parentUID') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerRelationship object) {}
}

class _ContainerRelationshipNativeAdapter
    extends IsarNativeTypeAdapter<ContainerRelationship> {
  const _ContainerRelationshipNativeAdapter();

  @override
  void serialize(
      IsarCollection<ContainerRelationship> collection,
      IsarRawObject rawObj,
      ContainerRelationship object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.containerUID;
    final _containerUID = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_containerUID.length) as int;
    final value1 = object.parentUID;
    final _parentUID = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_parentUID.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _containerUID);
    writer.writeBytes(offsets[1], _parentUID);
  }

  @override
  ContainerRelationship deserialize(
      IsarCollection<ContainerRelationship> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = ContainerRelationship();
    object.containerUID = reader.readString(offsets[0]);
    object.id = id;
    object.parentUID = reader.readString(offsets[1]);
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
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerRelationship object) {}
}

extension ContainerRelationshipQueryWhereSort
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QWhere> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ContainerRelationshipQueryWhere on QueryBuilder<ContainerRelationship,
    ContainerRelationship, QWhereClause> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idBetween(
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

extension ContainerRelationshipQueryFilter on QueryBuilder<
    ContainerRelationship, ContainerRelationship, QFilterCondition> {
  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDEqualTo(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDGreaterThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDLessThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDBetween(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDStartsWith(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDEndsWith(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'parentUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'parentUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'parentUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'parentUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'parentUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'parentUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      parentUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'parentUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      parentUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'parentUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ContainerRelationshipQueryLinks on QueryBuilder<ContainerRelationship,
    ContainerRelationship, QFilterCondition> {}

extension ContainerRelationshipQueryWhereSortBy
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QSortBy> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByParentUID() {
    return addSortByInternal('parentUID', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByParentUIDDesc() {
    return addSortByInternal('parentUID', Sort.desc);
  }
}

extension ContainerRelationshipQueryWhereSortThenBy
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QSortThenBy> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByParentUID() {
    return addSortByInternal('parentUID', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByParentUIDDesc() {
    return addSortByInternal('parentUID', Sort.desc);
  }
}

extension ContainerRelationshipQueryWhereDistinct
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByContainerUID({bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByParentUID({bool caseSensitive = true}) {
    return addDistinctByInternal('parentUID', caseSensitive: caseSensitive);
  }
}

extension ContainerRelationshipQueryProperty on QueryBuilder<
    ContainerRelationship, ContainerRelationship, QQueryProperty> {
  QueryBuilder<ContainerRelationship, String, QQueryOperations>
      containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<ContainerRelationship, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerRelationship, String, QQueryOperations>
      parentUIDProperty() {
    return addPropertyNameInternal('parentUID');
  }
}
