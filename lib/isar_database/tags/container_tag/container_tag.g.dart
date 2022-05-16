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
      '{"name":"ContainerTag","idName":"id","properties":[{"name":"containerUID","type":"Long"},{"name":"textID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ContainerTagNativeAdapter(),
  webAdapter: const _ContainerTagWebAdapter(),
  idName: 'id',
  propertyIds: {'containerUID': 0, 'textID': 1},
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
    IsarNative.jsObjectSet(jsObj, 'textID', object.textID);
    return jsObj;
  }

  @override
  ContainerTag deserialize(
      IsarCollection<ContainerTag> collection, dynamic jsObj) {
    final object = ContainerTag();
    object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ??
        double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.textID =
        IsarNative.jsObjectGet(jsObj, 'textID') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'containerUID':
        return (IsarNative.jsObjectGet(jsObj, 'containerUID') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'textID':
        return (IsarNative.jsObjectGet(jsObj, 'textID') ??
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
    final _containerUID = value0;
    final value1 = object.textID;
    final _textID = value1;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _containerUID);
    writer.writeLong(offsets[1], _textID);
  }

  @override
  ContainerTag deserialize(IsarCollection<ContainerTag> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = ContainerTag();
    object.containerUID = reader.readLong(offsets[0]);
    object.id = id;
    object.textID = reader.readLong(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readLong(offset)) as P;
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
      containerUIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerUID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerUID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerUID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> textIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'textID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      textIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'textID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      textIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'textID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> textIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'textID',
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTextID() {
    return addSortByInternal('textID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTextIDDesc() {
    return addSortByInternal('textID', Sort.desc);
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTextID() {
    return addSortByInternal('textID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTextIDDesc() {
    return addSortByInternal('textID', Sort.desc);
  }
}

extension ContainerTagQueryWhereDistinct
    on QueryBuilder<ContainerTag, ContainerTag, QDistinct> {
  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByContainerUID() {
    return addDistinctByInternal('containerUID');
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByTextID() {
    return addDistinctByInternal('textID');
  }
}

extension ContainerTagQueryProperty
    on QueryBuilder<ContainerTag, ContainerTag, QQueryProperty> {
  QueryBuilder<ContainerTag, int, QQueryOperations> containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> textIDProperty() {
    return addPropertyNameInternal('textID');
  }
}
