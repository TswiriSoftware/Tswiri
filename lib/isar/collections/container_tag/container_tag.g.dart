// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'container_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetContainerTagCollection on Isar {
  IsarCollection<ContainerTag> get containerTags => getCollection();
}

const ContainerTagSchema = CollectionSchema(
  name: 'ContainerTag',
  schema:
      '{"name":"ContainerTag","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"hashCode","type":"Long"},{"name":"tagTextID","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'containerUID': 0, 'hashCode': 1, 'tagTextID': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _containerTagGetId,
  setId: _containerTagSetId,
  getLinks: _containerTagGetLinks,
  attachLinks: _containerTagAttachLinks,
  serializeNative: _containerTagSerializeNative,
  deserializeNative: _containerTagDeserializeNative,
  deserializePropNative: _containerTagDeserializePropNative,
  serializeWeb: _containerTagSerializeWeb,
  deserializeWeb: _containerTagDeserializeWeb,
  deserializePropWeb: _containerTagDeserializePropWeb,
  version: 3,
);

int? _containerTagGetId(ContainerTag object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _containerTagSetId(ContainerTag object, int id) {
  object.id = id;
}

List<IsarLinkBase> _containerTagGetLinks(ContainerTag object) {
  return [];
}

void _containerTagSerializeNative(
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
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.tagTextID;
  final _tagTextID = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _containerUID);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeLong(offsets[2], _tagTextID);
}

ContainerTag _containerTagDeserializeNative(
    IsarCollection<ContainerTag> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ContainerTag();
  object.containerUID = reader.readString(offsets[0]);
  object.id = id;
  object.tagTextID = reader.readLong(offsets[2]);
  return object;
}

P _containerTagDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _containerTagSerializeWeb(
    IsarCollection<ContainerTag> collection, ContainerTag object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'tagTextID', object.tagTextID);
  return jsObj;
}

ContainerTag _containerTagDeserializeWeb(
    IsarCollection<ContainerTag> collection, dynamic jsObj) {
  final object = ContainerTag();
  object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.tagTextID =
      IsarNative.jsObjectGet(jsObj, 'tagTextID') ?? double.negativeInfinity;
  return object;
}

P _containerTagDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'containerUID':
      return (IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '') as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'tagTextID':
      return (IsarNative.jsObjectGet(jsObj, 'tagTextID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _containerTagAttachLinks(
    IsarCollection col, int id, ContainerTag object) {}

extension ContainerTagQueryWhereSort
    on QueryBuilder<ContainerTag, ContainerTag, QWhere> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ContainerTagQueryWhere
    on QueryBuilder<ContainerTag, ContainerTag, QWhereClause> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idNotEqualTo(
      int id) {
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idBetween(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
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
      tagTextIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDGreaterThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDLessThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDBetween(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension ContainerTagQueryWhereDistinct
    on QueryBuilder<ContainerTag, ContainerTag, QDistinct> {
  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByContainerUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByTagTextID() {
    return addDistinctByInternal('tagTextID');
  }
}

extension ContainerTagQueryProperty
    on QueryBuilder<ContainerTag, ContainerTag, QQueryProperty> {
  QueryBuilder<ContainerTag, String, QQueryOperations> containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> tagTextIDProperty() {
    return addPropertyNameInternal('tagTextID');
  }
}
