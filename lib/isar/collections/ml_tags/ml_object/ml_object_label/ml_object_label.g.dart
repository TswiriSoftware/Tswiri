// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_object_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLObjectLabelCollection on Isar {
  IsarCollection<MLObjectLabel> get mLObjectLabels => getCollection();
}

const MLObjectLabelSchema = CollectionSchema(
  name: 'MLObjectLabel',
  schema:
      '{"name":"MLObjectLabel","idName":"id","properties":[{"name":"confidence","type":"Double"},{"name":"detectedLabelTextID","type":"Long"},{"name":"hashCode","type":"Long"},{"name":"objectID","type":"Long"},{"name":"userFeedback","type":"Bool"}],"indexes":[{"name":"detectedLabelTextID","unique":false,"properties":[{"name":"detectedLabelTextID","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'confidence': 0,
    'detectedLabelTextID': 1,
    'hashCode': 2,
    'objectID': 3,
    'userFeedback': 4
  },
  listProperties: {},
  indexIds: {'detectedLabelTextID': 0},
  indexValueTypes: {
    'detectedLabelTextID': [
      IndexValueType.long,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLObjectLabelGetId,
  setId: _mLObjectLabelSetId,
  getLinks: _mLObjectLabelGetLinks,
  attachLinks: _mLObjectLabelAttachLinks,
  serializeNative: _mLObjectLabelSerializeNative,
  deserializeNative: _mLObjectLabelDeserializeNative,
  deserializePropNative: _mLObjectLabelDeserializePropNative,
  serializeWeb: _mLObjectLabelSerializeWeb,
  deserializeWeb: _mLObjectLabelDeserializeWeb,
  deserializePropWeb: _mLObjectLabelDeserializePropWeb,
  version: 3,
);

int? _mLObjectLabelGetId(MLObjectLabel object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLObjectLabelSetId(MLObjectLabel object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLObjectLabelGetLinks(MLObjectLabel object) {
  return [];
}

void _mLObjectLabelSerializeNative(
    IsarCollection<MLObjectLabel> collection,
    IsarRawObject rawObj,
    MLObjectLabel object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.confidence;
  final _confidence = value0;
  final value1 = object.detectedLabelTextID;
  final _detectedLabelTextID = value1;
  final value2 = object.hashCode;
  final _hashCode = value2;
  final value3 = object.objectID;
  final _objectID = value3;
  final value4 = object.userFeedback;
  final _userFeedback = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDouble(offsets[0], _confidence);
  writer.writeLong(offsets[1], _detectedLabelTextID);
  writer.writeLong(offsets[2], _hashCode);
  writer.writeLong(offsets[3], _objectID);
  writer.writeBool(offsets[4], _userFeedback);
}

MLObjectLabel _mLObjectLabelDeserializeNative(
    IsarCollection<MLObjectLabel> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = MLObjectLabel();
  object.confidence = reader.readDouble(offsets[0]);
  object.detectedLabelTextID = reader.readLong(offsets[1]);
  object.id = id;
  object.objectID = reader.readLong(offsets[3]);
  object.userFeedback = reader.readBoolOrNull(offsets[4]);
  return object;
}

P _mLObjectLabelDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLObjectLabelSerializeWeb(
    IsarCollection<MLObjectLabel> collection, MLObjectLabel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'confidence', object.confidence);
  IsarNative.jsObjectSet(
      jsObj, 'detectedLabelTextID', object.detectedLabelTextID);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'objectID', object.objectID);
  IsarNative.jsObjectSet(jsObj, 'userFeedback', object.userFeedback);
  return jsObj;
}

MLObjectLabel _mLObjectLabelDeserializeWeb(
    IsarCollection<MLObjectLabel> collection, dynamic jsObj) {
  final object = MLObjectLabel();
  object.confidence =
      IsarNative.jsObjectGet(jsObj, 'confidence') ?? double.negativeInfinity;
  object.detectedLabelTextID =
      IsarNative.jsObjectGet(jsObj, 'detectedLabelTextID') ??
          double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.objectID =
      IsarNative.jsObjectGet(jsObj, 'objectID') ?? double.negativeInfinity;
  object.userFeedback = IsarNative.jsObjectGet(jsObj, 'userFeedback');
  return object;
}

P _mLObjectLabelDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'confidence':
      return (IsarNative.jsObjectGet(jsObj, 'confidence') ??
          double.negativeInfinity) as P;
    case 'detectedLabelTextID':
      return (IsarNative.jsObjectGet(jsObj, 'detectedLabelTextID') ??
          double.negativeInfinity) as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'objectID':
      return (IsarNative.jsObjectGet(jsObj, 'objectID') ??
          double.negativeInfinity) as P;
    case 'userFeedback':
      return (IsarNative.jsObjectGet(jsObj, 'userFeedback')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLObjectLabelAttachLinks(
    IsarCollection col, int id, MLObjectLabel object) {}

extension MLObjectLabelQueryWhereSort
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QWhere> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhere>
      anyDetectedLabelTextID() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'detectedLabelTextID'));
  }
}

extension MLObjectLabelQueryWhere
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QWhereClause> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDEqualTo(int detectedLabelTextID) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'detectedLabelTextID',
      value: [detectedLabelTextID],
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDNotEqualTo(int detectedLabelTextID) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelTextID',
        upper: [detectedLabelTextID],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelTextID',
        lower: [detectedLabelTextID],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelTextID',
        lower: [detectedLabelTextID],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelTextID',
        upper: [detectedLabelTextID],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDGreaterThan(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'detectedLabelTextID',
      lower: [detectedLabelTextID],
      includeLower: include,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDLessThan(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'detectedLabelTextID',
      upper: [detectedLabelTextID],
      includeUpper: include,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDBetween(
    int lowerDetectedLabelTextID,
    int upperDetectedLabelTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'detectedLabelTextID',
      lower: [lowerDetectedLabelTextID],
      includeLower: includeLower,
      upper: [upperDetectedLabelTextID],
      includeUpper: includeUpper,
    ));
  }
}

extension MLObjectLabelQueryFilter
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QFilterCondition> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'confidence',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'detectedLabelTextID',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'detectedLabelTextID',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'detectedLabelTextID',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'detectedLabelTextID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      objectIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'objectID',
      value: value,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      objectIDBetween(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      userFeedbackIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'userFeedback',
      value: null,
    ));
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      userFeedbackEqualTo(bool? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'userFeedback',
      value: value,
    ));
  }
}

extension MLObjectLabelQueryLinks
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QFilterCondition> {}

extension MLObjectLabelQueryWhereSortBy
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QSortBy> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByDetectedLabelTextID() {
    return addSortByInternal('detectedLabelTextID', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByDetectedLabelTextIDDesc() {
    return addSortByInternal('detectedLabelTextID', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByObjectID() {
    return addSortByInternal('objectID', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByObjectIDDesc() {
    return addSortByInternal('objectID', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByUserFeedback() {
    return addSortByInternal('userFeedback', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByUserFeedbackDesc() {
    return addSortByInternal('userFeedback', Sort.desc);
  }
}

extension MLObjectLabelQueryWhereSortThenBy
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QSortThenBy> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByDetectedLabelTextID() {
    return addSortByInternal('detectedLabelTextID', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByDetectedLabelTextIDDesc() {
    return addSortByInternal('detectedLabelTextID', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByObjectID() {
    return addSortByInternal('objectID', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByObjectIDDesc() {
    return addSortByInternal('objectID', Sort.desc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByUserFeedback() {
    return addSortByInternal('userFeedback', Sort.asc);
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByUserFeedbackDesc() {
    return addSortByInternal('userFeedback', Sort.desc);
  }
}

extension MLObjectLabelQueryWhereDistinct
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctByConfidence() {
    return addDistinctByInternal('confidence');
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct>
      distinctByDetectedLabelTextID() {
    return addDistinctByInternal('detectedLabelTextID');
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctByObjectID() {
    return addDistinctByInternal('objectID');
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct>
      distinctByUserFeedback() {
    return addDistinctByInternal('userFeedback');
  }
}

extension MLObjectLabelQueryProperty
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QQueryProperty> {
  QueryBuilder<MLObjectLabel, double, QQueryOperations> confidenceProperty() {
    return addPropertyNameInternal('confidence');
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations>
      detectedLabelTextIDProperty() {
    return addPropertyNameInternal('detectedLabelTextID');
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations> objectIDProperty() {
    return addPropertyNameInternal('objectID');
  }

  QueryBuilder<MLObjectLabel, bool?, QQueryOperations> userFeedbackProperty() {
    return addPropertyNameInternal('userFeedback');
  }
}
