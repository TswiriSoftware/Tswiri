// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_text_element.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLTextElementCollection on Isar {
  IsarCollection<MLTextElement> get mLTextElements => getCollection();
}

const MLTextElementSchema = CollectionSchema(
  name: 'MLTextElement',
  schema:
      '{"name":"MLTextElement","idName":"id","properties":[{"name":"cornerPoints","type":"LongList"},{"name":"detectedElementTextID","type":"Long"},{"name":"lineID","type":"Long"},{"name":"lineIndex","type":"Long"},{"name":"photoID","type":"Long"},{"name":"userFeedback","type":"Bool"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'cornerPoints': 0,
    'detectedElementTextID': 1,
    'lineID': 2,
    'lineIndex': 3,
    'photoID': 4,
    'userFeedback': 5
  },
  listProperties: {'cornerPoints'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLTextElementGetId,
  setId: _mLTextElementSetId,
  getLinks: _mLTextElementGetLinks,
  attachLinks: _mLTextElementAttachLinks,
  serializeNative: _mLTextElementSerializeNative,
  deserializeNative: _mLTextElementDeserializeNative,
  deserializePropNative: _mLTextElementDeserializePropNative,
  serializeWeb: _mLTextElementSerializeWeb,
  deserializeWeb: _mLTextElementDeserializeWeb,
  deserializePropWeb: _mLTextElementDeserializePropWeb,
  version: 3,
);

int? _mLTextElementGetId(MLTextElement object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLTextElementSetId(MLTextElement object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLTextElementGetLinks(MLTextElement object) {
  return [];
}

const _mLTextElementCornerPointConverter = CornerPointConverter();

void _mLTextElementSerializeNative(
    IsarCollection<MLTextElement> collection,
    IsarRawObject rawObj,
    MLTextElement object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = _mLTextElementCornerPointConverter.toIsar(object.cornerPoints);
  dynamicSize += (value0.length) * 8;
  final _cornerPoints = value0;
  final value1 = object.detectedElementTextID;
  final _detectedElementTextID = value1;
  final value2 = object.lineID;
  final _lineID = value2;
  final value3 = object.lineIndex;
  final _lineIndex = value3;
  final value4 = object.photoID;
  final _photoID = value4;
  final value5 = object.userFeedback;
  final _userFeedback = value5;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLongList(offsets[0], _cornerPoints);
  writer.writeLong(offsets[1], _detectedElementTextID);
  writer.writeLong(offsets[2], _lineID);
  writer.writeLong(offsets[3], _lineIndex);
  writer.writeLong(offsets[4], _photoID);
  writer.writeBool(offsets[5], _userFeedback);
}

MLTextElement _mLTextElementDeserializeNative(
    IsarCollection<MLTextElement> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = MLTextElement();
  object.cornerPoints = _mLTextElementCornerPointConverter
      .fromIsar(reader.readLongList(offsets[0]) ?? []);
  object.detectedElementTextID = reader.readLong(offsets[1]);
  object.id = id;
  object.lineID = reader.readLong(offsets[2]);
  object.lineIndex = reader.readLong(offsets[3]);
  object.photoID = reader.readLong(offsets[4]);
  object.userFeedback = reader.readBoolOrNull(offsets[5]);
  return object;
}

P _mLTextElementDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (_mLTextElementCornerPointConverter
          .fromIsar(reader.readLongList(offset) ?? [])) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLTextElementSerializeWeb(
    IsarCollection<MLTextElement> collection, MLTextElement object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'cornerPoints',
      _mLTextElementCornerPointConverter.toIsar(object.cornerPoints));
  IsarNative.jsObjectSet(
      jsObj, 'detectedElementTextID', object.detectedElementTextID);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'lineID', object.lineID);
  IsarNative.jsObjectSet(jsObj, 'lineIndex', object.lineIndex);
  IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
  IsarNative.jsObjectSet(jsObj, 'userFeedback', object.userFeedback);
  return jsObj;
}

MLTextElement _mLTextElementDeserializeWeb(
    IsarCollection<MLTextElement> collection, dynamic jsObj) {
  final object = MLTextElement();
  object.cornerPoints = _mLTextElementCornerPointConverter.fromIsar(
      (IsarNative.jsObjectGet(jsObj, 'cornerPoints') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<int>() ??
          []);
  object.detectedElementTextID =
      IsarNative.jsObjectGet(jsObj, 'detectedElementTextID') ??
          double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.lineID =
      IsarNative.jsObjectGet(jsObj, 'lineID') ?? double.negativeInfinity;
  object.lineIndex =
      IsarNative.jsObjectGet(jsObj, 'lineIndex') ?? double.negativeInfinity;
  object.photoID =
      IsarNative.jsObjectGet(jsObj, 'photoID') ?? double.negativeInfinity;
  object.userFeedback = IsarNative.jsObjectGet(jsObj, 'userFeedback');
  return object;
}

P _mLTextElementDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'cornerPoints':
      return (_mLTextElementCornerPointConverter.fromIsar(
          (IsarNative.jsObjectGet(jsObj, 'cornerPoints') as List?)
                  ?.map((e) => e ?? double.negativeInfinity)
                  .toList()
                  .cast<int>() ??
              [])) as P;
    case 'detectedElementTextID':
      return (IsarNative.jsObjectGet(jsObj, 'detectedElementTextID') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'lineID':
      return (IsarNative.jsObjectGet(jsObj, 'lineID') ??
          double.negativeInfinity) as P;
    case 'lineIndex':
      return (IsarNative.jsObjectGet(jsObj, 'lineIndex') ??
          double.negativeInfinity) as P;
    case 'photoID':
      return (IsarNative.jsObjectGet(jsObj, 'photoID') ??
          double.negativeInfinity) as P;
    case 'userFeedback':
      return (IsarNative.jsObjectGet(jsObj, 'userFeedback')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLTextElementAttachLinks(
    IsarCollection col, int id, MLTextElement object) {}

extension MLTextElementQueryWhereSort
    on QueryBuilder<MLTextElement, MLTextElement, QWhere> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension MLTextElementQueryWhere
    on QueryBuilder<MLTextElement, MLTextElement, QWhereClause> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idBetween(
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

extension MLTextElementQueryFilter
    on QueryBuilder<MLTextElement, MLTextElement, QFilterCondition> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      cornerPointsAnyEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      cornerPointsAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      cornerPointsAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      cornerPointsAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'cornerPoints',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'detectedElementTextID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'detectedElementTextID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'detectedElementTextID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'detectedElementTextID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'lineID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'lineID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'lineID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'lineID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'lineIndex',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'lineIndex',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'lineIndex',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'lineIndex',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDGreaterThan(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDLessThan(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDBetween(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      userFeedbackIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'userFeedback',
      value: null,
    ));
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      userFeedbackEqualTo(bool? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'userFeedback',
      value: value,
    ));
  }
}

extension MLTextElementQueryLinks
    on QueryBuilder<MLTextElement, MLTextElement, QFilterCondition> {}

extension MLTextElementQueryWhereSortBy
    on QueryBuilder<MLTextElement, MLTextElement, QSortBy> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByDetectedElementTextID() {
    return addSortByInternal('detectedElementTextID', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByDetectedElementTextIDDesc() {
    return addSortByInternal('detectedElementTextID', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByLineID() {
    return addSortByInternal('lineID', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByLineIDDesc() {
    return addSortByInternal('lineID', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByLineIndex() {
    return addSortByInternal('lineIndex', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByLineIndexDesc() {
    return addSortByInternal('lineIndex', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByUserFeedback() {
    return addSortByInternal('userFeedback', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByUserFeedbackDesc() {
    return addSortByInternal('userFeedback', Sort.desc);
  }
}

extension MLTextElementQueryWhereSortThenBy
    on QueryBuilder<MLTextElement, MLTextElement, QSortThenBy> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByDetectedElementTextID() {
    return addSortByInternal('detectedElementTextID', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByDetectedElementTextIDDesc() {
    return addSortByInternal('detectedElementTextID', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByLineID() {
    return addSortByInternal('lineID', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByLineIDDesc() {
    return addSortByInternal('lineID', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByLineIndex() {
    return addSortByInternal('lineIndex', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByLineIndexDesc() {
    return addSortByInternal('lineIndex', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByUserFeedback() {
    return addSortByInternal('userFeedback', Sort.asc);
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByUserFeedbackDesc() {
    return addSortByInternal('userFeedback', Sort.desc);
  }
}

extension MLTextElementQueryWhereDistinct
    on QueryBuilder<MLTextElement, MLTextElement, QDistinct> {
  QueryBuilder<MLTextElement, MLTextElement, QDistinct>
      distinctByDetectedElementTextID() {
    return addDistinctByInternal('detectedElementTextID');
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctByLineID() {
    return addDistinctByInternal('lineID');
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctByLineIndex() {
    return addDistinctByInternal('lineIndex');
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct>
      distinctByUserFeedback() {
    return addDistinctByInternal('userFeedback');
  }
}

extension MLTextElementQueryProperty
    on QueryBuilder<MLTextElement, MLTextElement, QQueryProperty> {
  QueryBuilder<MLTextElement, List<Point<int>>, QQueryOperations>
      cornerPointsProperty() {
    return addPropertyNameInternal('cornerPoints');
  }

  QueryBuilder<MLTextElement, int, QQueryOperations>
      detectedElementTextIDProperty() {
    return addPropertyNameInternal('detectedElementTextID');
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> lineIDProperty() {
    return addPropertyNameInternal('lineID');
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> lineIndexProperty() {
    return addPropertyNameInternal('lineIndex');
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }

  QueryBuilder<MLTextElement, bool?, QQueryOperations> userFeedbackProperty() {
    return addPropertyNameInternal('userFeedback');
  }
}
