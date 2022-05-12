// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetUserTagCollection on Isar {
  IsarCollection<UserTag> get userTags {
    return getCollection('UserTag');
  }
}

final UserTagSchema = CollectionSchema(
  name: 'UserTag',
  schema:
      '{"name":"UserTag","idName":"id","properties":[{"name":"tagTextID","type":"Long"},{"name":"userTagID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _UserTagNativeAdapter(),
  webAdapter: const _UserTagWebAdapter(),
  idName: 'id',
  propertyIds: {'tagTextID': 0, 'userTagID': 1},
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

class _UserTagWebAdapter extends IsarWebTypeAdapter<UserTag> {
  const _UserTagWebAdapter();

  @override
  Object serialize(IsarCollection<UserTag> collection, UserTag object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'tagTextID', object.tagTextID);
    IsarNative.jsObjectSet(jsObj, 'userTagID', object.userTagID);
    return jsObj;
  }

  @override
  UserTag deserialize(IsarCollection<UserTag> collection, dynamic jsObj) {
    final object = UserTag();
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.tagTextID =
        IsarNative.jsObjectGet(jsObj, 'tagTextID') ?? double.negativeInfinity;
    object.userTagID =
        IsarNative.jsObjectGet(jsObj, 'userTagID') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'tagTextID':
        return (IsarNative.jsObjectGet(jsObj, 'tagTextID') ??
            double.negativeInfinity) as P;
      case 'userTagID':
        return (IsarNative.jsObjectGet(jsObj, 'userTagID') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, UserTag object) {}
}

class _UserTagNativeAdapter extends IsarNativeTypeAdapter<UserTag> {
  const _UserTagNativeAdapter();

  @override
  void serialize(IsarCollection<UserTag> collection, IsarRawObject rawObj,
      UserTag object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.tagTextID;
    final _tagTextID = value0;
    final value1 = object.userTagID;
    final _userTagID = value1;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _tagTextID);
    writer.writeLong(offsets[1], _userTagID);
  }

  @override
  UserTag deserialize(IsarCollection<UserTag> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = UserTag();
    object.id = id;
    object.tagTextID = reader.readLong(offsets[0]);
    object.userTagID = reader.readLong(offsets[1]);
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
  void attachLinks(Isar isar, int id, UserTag object) {}
}

extension UserTagQueryWhereSort on QueryBuilder<UserTag, UserTag, QWhere> {
  QueryBuilder<UserTag, UserTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension UserTagQueryWhere on QueryBuilder<UserTag, UserTag, QWhereClause> {
  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idBetween(
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

extension UserTagQueryFilter
    on QueryBuilder<UserTag, UserTag, QFilterCondition> {
  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> tagTextIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> tagTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> tagTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> tagTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tagTextID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> userTagIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'userTagID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> userTagIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'userTagID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> userTagIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'userTagID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> userTagIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'userTagID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension UserTagQueryLinks
    on QueryBuilder<UserTag, UserTag, QFilterCondition> {}

extension UserTagQueryWhereSortBy on QueryBuilder<UserTag, UserTag, QSortBy> {
  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByUserTagID() {
    return addSortByInternal('userTagID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByUserTagIDDesc() {
    return addSortByInternal('userTagID', Sort.desc);
  }
}

extension UserTagQueryWhereSortThenBy
    on QueryBuilder<UserTag, UserTag, QSortThenBy> {
  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByUserTagID() {
    return addSortByInternal('userTagID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByUserTagIDDesc() {
    return addSortByInternal('userTagID', Sort.desc);
  }
}

extension UserTagQueryWhereDistinct
    on QueryBuilder<UserTag, UserTag, QDistinct> {
  QueryBuilder<UserTag, UserTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<UserTag, UserTag, QDistinct> distinctByTagTextID() {
    return addDistinctByInternal('tagTextID');
  }

  QueryBuilder<UserTag, UserTag, QDistinct> distinctByUserTagID() {
    return addDistinctByInternal('userTagID');
  }
}

extension UserTagQueryProperty
    on QueryBuilder<UserTag, UserTag, QQueryProperty> {
  QueryBuilder<UserTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<UserTag, int, QQueryOperations> tagTextIDProperty() {
    return addPropertyNameInternal('tagTextID');
  }

  QueryBuilder<UserTag, int, QQueryOperations> userTagIDProperty() {
    return addPropertyNameInternal('userTagID');
  }
}
