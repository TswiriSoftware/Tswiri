// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'container_relationship.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetContainerRelationshipCollection on Isar {
  IsarCollection<ContainerRelationship> get containerRelationships =>
      getCollection();
}

const ContainerRelationshipSchema = CollectionSchema(
  name: 'ContainerRelationship',
  schema:
      '{"name":"ContainerRelationship","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"hashCode","type":"Long"},{"name":"parentUID","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'containerUID': 0, 'hashCode': 1, 'parentUID': 2},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _containerRelationshipGetId,
  setId: _containerRelationshipSetId,
  getLinks: _containerRelationshipGetLinks,
  attachLinks: _containerRelationshipAttachLinks,
  serializeNative: _containerRelationshipSerializeNative,
  deserializeNative: _containerRelationshipDeserializeNative,
  deserializePropNative: _containerRelationshipDeserializePropNative,
  serializeWeb: _containerRelationshipSerializeWeb,
  deserializeWeb: _containerRelationshipDeserializeWeb,
  deserializePropWeb: _containerRelationshipDeserializePropWeb,
  version: 3,
);

int? _containerRelationshipGetId(ContainerRelationship object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _containerRelationshipSetId(ContainerRelationship object, int id) {
  object.id = id;
}

List<IsarLinkBase> _containerRelationshipGetLinks(
    ContainerRelationship object) {
  return [];
}

void _containerRelationshipSerializeNative(
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
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.parentUID;
  IsarUint8List? _parentUID;
  if (value2 != null) {
    _parentUID = IsarBinaryWriter.utf8Encoder.convert(value2);
  }
  dynamicSize += (_parentUID?.length ?? 0) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _containerUID);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeBytes(offsets[2], _parentUID);
}

ContainerRelationship _containerRelationshipDeserializeNative(
    IsarCollection<ContainerRelationship> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ContainerRelationship();
  object.containerUID = reader.readString(offsets[0]);
  object.id = id;
  object.parentUID = reader.readStringOrNull(offsets[2]);
  return object;
}

P _containerRelationshipDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _containerRelationshipSerializeWeb(
    IsarCollection<ContainerRelationship> collection,
    ContainerRelationship object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'parentUID', object.parentUID);
  return jsObj;
}

ContainerRelationship _containerRelationshipDeserializeWeb(
    IsarCollection<ContainerRelationship> collection, dynamic jsObj) {
  final object = ContainerRelationship();
  object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.parentUID = IsarNative.jsObjectGet(jsObj, 'parentUID');
  return object;
}

P _containerRelationshipDeserializePropWeb<P>(
    Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'containerUID':
      return (IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '') as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'parentUID':
      return (IsarNative.jsObjectGet(jsObj, 'parentUID')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _containerRelationshipAttachLinks(
    IsarCollection col, int id, ContainerRelationship object) {}

extension ContainerRelationshipQueryWhereSort
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QWhere> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ContainerRelationshipQueryWhere on QueryBuilder<ContainerRelationship,
    ContainerRelationship, QWhereClause> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idBetween(
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
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeBetween(
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
      QAfterFilterCondition> parentUIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'parentUID',
      value: null,
    ));
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDEqualTo(
    String? value, {
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
    String? value, {
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
    String? value, {
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
    String? lower,
    String? upper, {
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
      sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
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
      thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
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
      distinctByHashCode() {
    return addDistinctByInternal('hashCode');
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

  QueryBuilder<ContainerRelationship, int, QQueryOperations>
      hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<ContainerRelationship, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerRelationship, String?, QQueryOperations>
      parentUIDProperty() {
    return addPropertyNameInternal('parentUID');
  }
}
