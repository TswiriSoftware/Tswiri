// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_photo_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLPhotoLabelCollection on Isar {
  IsarCollection<MLPhotoLabel> get mLPhotoLabels => getCollection();
}

const MLPhotoLabelSchema = CollectionSchema(
  name: 'MLPhotoLabel',
  schema:
      '{"name":"MLPhotoLabel","idName":"id","properties":[{"name":"confidence","type":"Double"},{"name":"detectedLabelTextID","type":"Long"},{"name":"hashCode","type":"Long"},{"name":"photoID","type":"Long"},{"name":"userFeedback","type":"Bool"}],"indexes":[{"name":"detectedLabelTextID_userFeedback","unique":false,"properties":[{"name":"detectedLabelTextID","type":"Value","caseSensitive":false},{"name":"userFeedback","type":"Value","caseSensitive":false}]},{"name":"userFeedback","unique":false,"properties":[{"name":"userFeedback","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'confidence': 0,
    'detectedLabelTextID': 1,
    'hashCode': 2,
    'photoID': 3,
    'userFeedback': 4
  },
  listProperties: {},
  indexIds: {'detectedLabelTextID_userFeedback': 0, 'userFeedback': 1},
  indexValueTypes: {
    'detectedLabelTextID_userFeedback': [
      IndexValueType.long,
      IndexValueType.bool,
    ],
    'userFeedback': [
      IndexValueType.bool,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLPhotoLabelGetId,
  setId: _mLPhotoLabelSetId,
  getLinks: _mLPhotoLabelGetLinks,
  attachLinks: _mLPhotoLabelAttachLinks,
  serializeNative: _mLPhotoLabelSerializeNative,
  deserializeNative: _mLPhotoLabelDeserializeNative,
  deserializePropNative: _mLPhotoLabelDeserializePropNative,
  serializeWeb: _mLPhotoLabelSerializeWeb,
  deserializeWeb: _mLPhotoLabelDeserializeWeb,
  deserializePropWeb: _mLPhotoLabelDeserializePropWeb,
  version: 3,
);

int? _mLPhotoLabelGetId(MLPhotoLabel object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLPhotoLabelSetId(MLPhotoLabel object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLPhotoLabelGetLinks(MLPhotoLabel object) {
  return [];
}

void _mLPhotoLabelSerializeNative(
    IsarCollection<MLPhotoLabel> collection,
    IsarRawObject rawObj,
    MLPhotoLabel object,
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
  final value3 = object.photoID;
  final _photoID = value3;
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
  writer.writeLong(offsets[3], _photoID);
  writer.writeBool(offsets[4], _userFeedback);
}

MLPhotoLabel _mLPhotoLabelDeserializeNative(
    IsarCollection<MLPhotoLabel> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = MLPhotoLabel();
  object.confidence = reader.readDouble(offsets[0]);
  object.detectedLabelTextID = reader.readLong(offsets[1]);
  object.id = id;
  object.photoID = reader.readLongOrNull(offsets[3]);
  object.userFeedback = reader.readBoolOrNull(offsets[4]);
  return object;
}

P _mLPhotoLabelDeserializePropNative<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLPhotoLabelSerializeWeb(
    IsarCollection<MLPhotoLabel> collection, MLPhotoLabel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'confidence', object.confidence);
  IsarNative.jsObjectSet(
      jsObj, 'detectedLabelTextID', object.detectedLabelTextID);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
  IsarNative.jsObjectSet(jsObj, 'userFeedback', object.userFeedback);
  return jsObj;
}

MLPhotoLabel _mLPhotoLabelDeserializeWeb(
    IsarCollection<MLPhotoLabel> collection, dynamic jsObj) {
  final object = MLPhotoLabel();
  object.confidence =
      IsarNative.jsObjectGet(jsObj, 'confidence') ?? double.negativeInfinity;
  object.detectedLabelTextID =
      IsarNative.jsObjectGet(jsObj, 'detectedLabelTextID') ??
          double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoID = IsarNative.jsObjectGet(jsObj, 'photoID');
  object.userFeedback = IsarNative.jsObjectGet(jsObj, 'userFeedback');
  return object;
}

P _mLPhotoLabelDeserializePropWeb<P>(Object jsObj, String propertyName) {
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
    case 'photoID':
      return (IsarNative.jsObjectGet(jsObj, 'photoID')) as P;
    case 'userFeedback':
      return (IsarNative.jsObjectGet(jsObj, 'userFeedback')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLPhotoLabelAttachLinks(
    IsarCollection col, int id, MLPhotoLabel object) {}

extension MLPhotoLabelQueryWhereSort
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QWhere> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhere>
      anyDetectedLabelTextIDUserFeedback() {
    return addWhereClauseInternal(const IndexWhereClause.any(
        indexName: 'detectedLabelTextID_userFeedback'));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhere> anyUserFeedback() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'userFeedback'));
  }
}

extension MLPhotoLabelQueryWhere
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QWhereClause> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDEqualTo(int detectedLabelTextID) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'detectedLabelTextID_userFeedback',
      value: [detectedLabelTextID],
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDNotEqualTo(int detectedLabelTextID) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelTextID_userFeedback',
        upper: [detectedLabelTextID],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelTextID_userFeedback',
        lower: [detectedLabelTextID],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelTextID_userFeedback',
        lower: [detectedLabelTextID],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelTextID_userFeedback',
        upper: [detectedLabelTextID],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDGreaterThan(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'detectedLabelTextID_userFeedback',
      lower: [detectedLabelTextID],
      includeLower: include,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDLessThan(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'detectedLabelTextID_userFeedback',
      upper: [detectedLabelTextID],
      includeUpper: include,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDBetween(
    int lowerDetectedLabelTextID,
    int upperDetectedLabelTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'detectedLabelTextID_userFeedback',
      lower: [lowerDetectedLabelTextID],
      includeLower: includeLower,
      upper: [upperDetectedLabelTextID],
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDUserFeedbackEqualTo(
          int detectedLabelTextID, bool? userFeedback) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'detectedLabelTextID_userFeedback',
      value: [detectedLabelTextID, userFeedback],
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDUserFeedbackNotEqualTo(
          int detectedLabelTextID, bool? userFeedback) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelTextID_userFeedback',
        upper: [detectedLabelTextID, userFeedback],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelTextID_userFeedback',
        lower: [detectedLabelTextID, userFeedback],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelTextID_userFeedback',
        lower: [detectedLabelTextID, userFeedback],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelTextID_userFeedback',
        upper: [detectedLabelTextID, userFeedback],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackEqualTo(bool? userFeedback) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'userFeedback',
      value: [userFeedback],
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackNotEqualTo(bool? userFeedback) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'userFeedback',
        upper: [userFeedback],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'userFeedback',
        lower: [userFeedback],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'userFeedback',
        lower: [userFeedback],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'userFeedback',
        upper: [userFeedback],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackIsNull() {
    return addWhereClauseInternal(const IndexWhereClause.equalTo(
      indexName: 'userFeedback',
      value: [null],
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackIsNotNull() {
    return addWhereClauseInternal(const IndexWhereClause.greaterThan(
      indexName: 'userFeedback',
      lower: [null],
      includeLower: false,
    ));
  }
}

extension MLPhotoLabelQueryFilter
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QFilterCondition> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      confidenceGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      confidenceLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      confidenceBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'confidence',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      detectedLabelTextIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'detectedLabelTextID',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'photoID',
      value: null,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      userFeedbackIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'userFeedback',
      value: null,
    ));
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      userFeedbackEqualTo(bool? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'userFeedback',
      value: value,
    ));
  }
}

extension MLPhotoLabelQueryLinks
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QFilterCondition> {}

extension MLPhotoLabelQueryWhereSortBy
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QSortBy> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByDetectedLabelTextID() {
    return addSortByInternal('detectedLabelTextID', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByDetectedLabelTextIDDesc() {
    return addSortByInternal('detectedLabelTextID', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByUserFeedback() {
    return addSortByInternal('userFeedback', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByUserFeedbackDesc() {
    return addSortByInternal('userFeedback', Sort.desc);
  }
}

extension MLPhotoLabelQueryWhereSortThenBy
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QSortThenBy> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByDetectedLabelTextID() {
    return addSortByInternal('detectedLabelTextID', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByDetectedLabelTextIDDesc() {
    return addSortByInternal('detectedLabelTextID', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByUserFeedback() {
    return addSortByInternal('userFeedback', Sort.asc);
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByUserFeedbackDesc() {
    return addSortByInternal('userFeedback', Sort.desc);
  }
}

extension MLPhotoLabelQueryWhereDistinct
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByConfidence() {
    return addDistinctByInternal('confidence');
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct>
      distinctByDetectedLabelTextID() {
    return addDistinctByInternal('detectedLabelTextID');
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByUserFeedback() {
    return addDistinctByInternal('userFeedback');
  }
}

extension MLPhotoLabelQueryProperty
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QQueryProperty> {
  QueryBuilder<MLPhotoLabel, double, QQueryOperations> confidenceProperty() {
    return addPropertyNameInternal('confidence');
  }

  QueryBuilder<MLPhotoLabel, int, QQueryOperations>
      detectedLabelTextIDProperty() {
    return addPropertyNameInternal('detectedLabelTextID');
  }

  QueryBuilder<MLPhotoLabel, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<MLPhotoLabel, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLPhotoLabel, int?, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }

  QueryBuilder<MLPhotoLabel, bool?, QQueryOperations> userFeedbackProperty() {
    return addPropertyNameInternal('userFeedback');
  }
}
