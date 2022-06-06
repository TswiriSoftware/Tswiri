// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'user_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetUserTagCollection on Isar {
  IsarCollection<UserTag> get userTags => getCollection();
}

const UserTagSchema = CollectionSchema(
  name: 'UserTag',
  schema:
      '{"name":"UserTag","idName":"id","properties":[{"name":"hashCode","type":"Long"},{"name":"photoID","type":"Long"},{"name":"textID","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'hashCode': 0, 'photoID': 1, 'textID': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _userTagGetId,
  setId: _userTagSetId,
  getLinks: _userTagGetLinks,
  attachLinks: _userTagAttachLinks,
  serializeNative: _userTagSerializeNative,
  deserializeNative: _userTagDeserializeNative,
  deserializePropNative: _userTagDeserializePropNative,
  serializeWeb: _userTagSerializeWeb,
  deserializeWeb: _userTagDeserializeWeb,
  deserializePropWeb: _userTagDeserializePropWeb,
  version: 3,
);

int? _userTagGetId(UserTag object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _userTagSetId(UserTag object, int id) {
  object.id = id;
}

List<IsarLinkBase> _userTagGetLinks(UserTag object) {
  return [];
}

void _userTagSerializeNative(
    IsarCollection<UserTag> collection,
    IsarRawObject rawObj,
    UserTag object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.hashCode;
  final _hashCode = value0;
  final value1 = object.photoID;
  final _photoID = value1;
  final value2 = object.textID;
  final _textID = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _hashCode);
  writer.writeLong(offsets[1], _photoID);
  writer.writeLong(offsets[2], _textID);
}

UserTag _userTagDeserializeNative(IsarCollection<UserTag> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = UserTag();
  object.id = id;
  object.photoID = reader.readLong(offsets[1]);
  object.textID = reader.readLong(offsets[2]);
  return object;
}

P _userTagDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _userTagSerializeWeb(
    IsarCollection<UserTag> collection, UserTag object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
  IsarNative.jsObjectSet(jsObj, 'textID', object.textID);
  return jsObj;
}

UserTag _userTagDeserializeWeb(
    IsarCollection<UserTag> collection, dynamic jsObj) {
  final object = UserTag();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoID =
      IsarNative.jsObjectGet(jsObj, 'photoID') ?? double.negativeInfinity;
  object.textID =
      IsarNative.jsObjectGet(jsObj, 'textID') ?? double.negativeInfinity;
  return object;
}

P _userTagDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'photoID':
      return (IsarNative.jsObjectGet(jsObj, 'photoID') ??
          double.negativeInfinity) as P;
    case 'textID':
      return (IsarNative.jsObjectGet(jsObj, 'textID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _userTagAttachLinks(IsarCollection col, int id, UserTag object) {}

extension UserTagQueryWhereSort on QueryBuilder<UserTag, UserTag, QWhere> {
  QueryBuilder<UserTag, UserTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension UserTagQueryWhere on QueryBuilder<UserTag, UserTag, QWhereClause> {
  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<UserTag, UserTag, QAfterWhereClause> idBetween(
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

extension UserTagQueryFilter
    on QueryBuilder<UserTag, UserTag, QFilterCondition> {
  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> photoIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> photoIDGreaterThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> photoIDLessThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> photoIDBetween(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> textIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'textID',
      value: value,
    ));
  }

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> textIDGreaterThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> textIDLessThan(
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

  QueryBuilder<UserTag, UserTag, QAfterFilterCondition> textIDBetween(
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

extension UserTagQueryLinks
    on QueryBuilder<UserTag, UserTag, QFilterCondition> {}

extension UserTagQueryWhereSortBy on QueryBuilder<UserTag, UserTag, QSortBy> {
  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByTextID() {
    return addSortByInternal('textID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> sortByTextIDDesc() {
    return addSortByInternal('textID', Sort.desc);
  }
}

extension UserTagQueryWhereSortThenBy
    on QueryBuilder<UserTag, UserTag, QSortThenBy> {
  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByTextID() {
    return addSortByInternal('textID', Sort.asc);
  }

  QueryBuilder<UserTag, UserTag, QAfterSortBy> thenByTextIDDesc() {
    return addSortByInternal('textID', Sort.desc);
  }
}

extension UserTagQueryWhereDistinct
    on QueryBuilder<UserTag, UserTag, QDistinct> {
  QueryBuilder<UserTag, UserTag, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<UserTag, UserTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<UserTag, UserTag, QDistinct> distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }

  QueryBuilder<UserTag, UserTag, QDistinct> distinctByTextID() {
    return addDistinctByInternal('textID');
  }
}

extension UserTagQueryProperty
    on QueryBuilder<UserTag, UserTag, QQueryProperty> {
  QueryBuilder<UserTag, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<UserTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<UserTag, int, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }

  QueryBuilder<UserTag, int, QQueryOperations> textIDProperty() {
    return addPropertyNameInternal('textID');
  }
}
