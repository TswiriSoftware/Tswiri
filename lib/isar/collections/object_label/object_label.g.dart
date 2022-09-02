// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'object_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetObjectLabelCollection on Isar {
  IsarCollection<ObjectLabel> get objectLabels => getCollection();
}

const ObjectLabelSchema = CollectionSchema(
  name: 'ObjectLabel',
  schema:
      '{"name":"ObjectLabel","idName":"id","properties":[{"name":"hashCode","type":"Long"},{"name":"objectID","type":"Long"},{"name":"tagTextID","type":"Long"}],"indexes":[{"name":"tagTextID","unique":false,"properties":[{"name":"tagTextID","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'hashCode': 0, 'objectID': 1, 'tagTextID': 2},
  listProperties: {},
  indexIds: {'tagTextID': 0},
  indexValueTypes: {
    'tagTextID': [
      IndexValueType.long,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _objectLabelGetId,
  setId: _objectLabelSetId,
  getLinks: _objectLabelGetLinks,
  attachLinks: _objectLabelAttachLinks,
  serializeNative: _objectLabelSerializeNative,
  deserializeNative: _objectLabelDeserializeNative,
  deserializePropNative: _objectLabelDeserializePropNative,
  serializeWeb: _objectLabelSerializeWeb,
  deserializeWeb: _objectLabelDeserializeWeb,
  deserializePropWeb: _objectLabelDeserializePropWeb,
  version: 3,
);

int? _objectLabelGetId(ObjectLabel object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _objectLabelSetId(ObjectLabel object, int id) {
  object.id = id;
}

List<IsarLinkBase> _objectLabelGetLinks(ObjectLabel object) {
  return [];
}

void _objectLabelSerializeNative(
    IsarCollection<ObjectLabel> collection,
    IsarRawObject rawObj,
    ObjectLabel object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.hashCode;
  final _hashCode = value0;
  final value1 = object.objectID;
  final _objectID = value1;
  final value2 = object.tagTextID;
  final _tagTextID = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _hashCode);
  writer.writeLong(offsets[1], _objectID);
  writer.writeLong(offsets[2], _tagTextID);
}

ObjectLabel _objectLabelDeserializeNative(
    IsarCollection<ObjectLabel> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ObjectLabel();
  object.id = id;
  object.objectID = reader.readLong(offsets[1]);
  object.tagTextID = reader.readLong(offsets[2]);
  return object;
}

P _objectLabelDeserializePropNative<P>(
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

dynamic _objectLabelSerializeWeb(
    IsarCollection<ObjectLabel> collection, ObjectLabel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'objectID', object.objectID);
  IsarNative.jsObjectSet(jsObj, 'tagTextID', object.tagTextID);
  return jsObj;
}

ObjectLabel _objectLabelDeserializeWeb(
    IsarCollection<ObjectLabel> collection, dynamic jsObj) {
  final object = ObjectLabel();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.objectID =
      IsarNative.jsObjectGet(jsObj, 'objectID') ?? double.negativeInfinity;
  object.tagTextID =
      IsarNative.jsObjectGet(jsObj, 'tagTextID') ?? double.negativeInfinity;
  return object;
}

P _objectLabelDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'objectID':
      return (IsarNative.jsObjectGet(jsObj, 'objectID') ??
          double.negativeInfinity) as P;
    case 'tagTextID':
      return (IsarNative.jsObjectGet(jsObj, 'tagTextID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _objectLabelAttachLinks(IsarCollection col, int id, ObjectLabel object) {}

extension ObjectLabelQueryWhereSort
    on QueryBuilder<ObjectLabel, ObjectLabel, QWhere> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhere> anyTagTextID() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'tagTextID'));
  }
}

extension ObjectLabelQueryWhere
    on QueryBuilder<ObjectLabel, ObjectLabel, QWhereClause> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDEqualTo(
      int tagTextID) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'tagTextID',
      value: [tagTextID],
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDNotEqualTo(
      int tagTextID) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tagTextID',
        upper: [tagTextID],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tagTextID',
        lower: [tagTextID],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tagTextID',
        lower: [tagTextID],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tagTextID',
        upper: [tagTextID],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause>
      tagTextIDGreaterThan(
    int tagTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'tagTextID',
      lower: [tagTextID],
      includeLower: include,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDLessThan(
    int tagTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'tagTextID',
      upper: [tagTextID],
      includeUpper: include,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDBetween(
    int lowerTagTextID,
    int upperTagTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'tagTextID',
      lower: [lowerTagTextID],
      includeLower: includeLower,
      upper: [upperTagTextID],
      includeUpper: includeUpper,
    ));
  }
}

extension ObjectLabelQueryFilter
    on QueryBuilder<ObjectLabel, ObjectLabel, QFilterCondition> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> objectIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'objectID',
      value: value,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
      objectIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'objectID',
      value: value,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
      objectIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'objectID',
      value: value,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> objectIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'objectID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
      tagTextIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

extension ObjectLabelQueryLinks
    on QueryBuilder<ObjectLabel, ObjectLabel, QFilterCondition> {}

extension ObjectLabelQueryWhereSortBy
    on QueryBuilder<ObjectLabel, ObjectLabel, QSortBy> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByObjectID() {
    return addSortByInternal('objectID', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByObjectIDDesc() {
    return addSortByInternal('objectID', Sort.desc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension ObjectLabelQueryWhereSortThenBy
    on QueryBuilder<ObjectLabel, ObjectLabel, QSortThenBy> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByObjectID() {
    return addSortByInternal('objectID', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByObjectIDDesc() {
    return addSortByInternal('objectID', Sort.desc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension ObjectLabelQueryWhereDistinct
    on QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> {
  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctByObjectID() {
    return addDistinctByInternal('objectID');
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctByTagTextID() {
    return addDistinctByInternal('tagTextID');
  }
}

extension ObjectLabelQueryProperty
    on QueryBuilder<ObjectLabel, ObjectLabel, QQueryProperty> {
  QueryBuilder<ObjectLabel, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<ObjectLabel, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ObjectLabel, int, QQueryOperations> objectIDProperty() {
    return addPropertyNameInternal('objectID');
  }

  QueryBuilder<ObjectLabel, int, QQueryOperations> tagTextIDProperty() {
    return addPropertyNameInternal('tagTextID');
  }
}
