// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMlTagCollection on Isar {
  IsarCollection<MlTag> get mlTags => getCollection();
}

const MlTagSchema = CollectionSchema(
  name: 'MlTag',
  schema:
      '{"name":"MlTag","idName":"id","properties":[{"name":"blackListed","type":"Bool"},{"name":"confidence","type":"Double"},{"name":"photoID","type":"Long"},{"name":"tagType","type":"Long"},{"name":"textID","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'blackListed': 0,
    'confidence': 1,
    'photoID': 2,
    'tagType': 3,
    'textID': 4
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mlTagGetId,
  setId: _mlTagSetId,
  getLinks: _mlTagGetLinks,
  attachLinks: _mlTagAttachLinks,
  serializeNative: _mlTagSerializeNative,
  deserializeNative: _mlTagDeserializeNative,
  deserializePropNative: _mlTagDeserializePropNative,
  serializeWeb: _mlTagSerializeWeb,
  deserializeWeb: _mlTagDeserializeWeb,
  deserializePropWeb: _mlTagDeserializePropWeb,
  version: 3,
);

int? _mlTagGetId(MlTag object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mlTagSetId(MlTag object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mlTagGetLinks(MlTag object) {
  return [];
}

const _mlTagMlTagTypeConverter = MlTagTypeConverter();

void _mlTagSerializeNative(
    IsarCollection<MlTag> collection,
    IsarRawObject rawObj,
    MlTag object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.blackListed;
  final _blackListed = value0;
  final value1 = object.confidence;
  final _confidence = value1;
  final value2 = object.photoID;
  final _photoID = value2;
  final value3 = _mlTagMlTagTypeConverter.toIsar(object.tagType);
  final _tagType = value3;
  final value4 = object.textID;
  final _textID = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBool(offsets[0], _blackListed);
  writer.writeDouble(offsets[1], _confidence);
  writer.writeLong(offsets[2], _photoID);
  writer.writeLong(offsets[3], _tagType);
  writer.writeLong(offsets[4], _textID);
}

MlTag _mlTagDeserializeNative(IsarCollection<MlTag> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = MlTag();
  object.blackListed = reader.readBool(offsets[0]);
  object.confidence = reader.readDouble(offsets[1]);
  object.id = id;
  object.photoID = reader.readLong(offsets[2]);
  object.tagType =
      _mlTagMlTagTypeConverter.fromIsar(reader.readLong(offsets[3]));
  object.textID = reader.readLong(offsets[4]);
  return object;
}

P _mlTagDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (_mlTagMlTagTypeConverter.fromIsar(reader.readLong(offset))) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mlTagSerializeWeb(IsarCollection<MlTag> collection, MlTag object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'blackListed', object.blackListed);
  IsarNative.jsObjectSet(jsObj, 'confidence', object.confidence);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
  IsarNative.jsObjectSet(
      jsObj, 'tagType', _mlTagMlTagTypeConverter.toIsar(object.tagType));
  IsarNative.jsObjectSet(jsObj, 'textID', object.textID);
  return jsObj;
}

MlTag _mlTagDeserializeWeb(IsarCollection<MlTag> collection, dynamic jsObj) {
  final object = MlTag();
  object.blackListed = IsarNative.jsObjectGet(jsObj, 'blackListed') ?? false;
  object.confidence =
      IsarNative.jsObjectGet(jsObj, 'confidence') ?? double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoID =
      IsarNative.jsObjectGet(jsObj, 'photoID') ?? double.negativeInfinity;
  object.tagType = _mlTagMlTagTypeConverter.fromIsar(
      IsarNative.jsObjectGet(jsObj, 'tagType') ?? double.negativeInfinity);
  object.textID =
      IsarNative.jsObjectGet(jsObj, 'textID') ?? double.negativeInfinity;
  return object;
}

P _mlTagDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'blackListed':
      return (IsarNative.jsObjectGet(jsObj, 'blackListed') ?? false) as P;
    case 'confidence':
      return (IsarNative.jsObjectGet(jsObj, 'confidence') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'photoID':
      return (IsarNative.jsObjectGet(jsObj, 'photoID') ??
          double.negativeInfinity) as P;
    case 'tagType':
      return (_mlTagMlTagTypeConverter.fromIsar(
          IsarNative.jsObjectGet(jsObj, 'tagType') ??
              double.negativeInfinity)) as P;
    case 'textID':
      return (IsarNative.jsObjectGet(jsObj, 'textID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mlTagAttachLinks(IsarCollection col, int id, MlTag object) {}

extension MlTagQueryWhereSort on QueryBuilder<MlTag, MlTag, QWhere> {
  QueryBuilder<MlTag, MlTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension MlTagQueryWhere on QueryBuilder<MlTag, MlTag, QWhereClause> {
  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idBetween(
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

extension MlTagQueryFilter on QueryBuilder<MlTag, MlTag, QFilterCondition> {
  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> blackListedEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'blackListed',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> confidenceGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> confidenceLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> confidenceBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'confidence',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> photoIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> photoIDGreaterThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> photoIDLessThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> photoIDBetween(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagTypeEqualTo(
      MlTagType value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagType',
      value: _mlTagMlTagTypeConverter.toIsar(value),
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagTypeGreaterThan(
    MlTagType value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tagType',
      value: _mlTagMlTagTypeConverter.toIsar(value),
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagTypeLessThan(
    MlTagType value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tagType',
      value: _mlTagMlTagTypeConverter.toIsar(value),
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagTypeBetween(
    MlTagType lower,
    MlTagType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tagType',
      lower: _mlTagMlTagTypeConverter.toIsar(lower),
      includeLower: includeLower,
      upper: _mlTagMlTagTypeConverter.toIsar(upper),
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'textID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textIDGreaterThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textIDLessThan(
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textIDBetween(
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

extension MlTagQueryLinks on QueryBuilder<MlTag, MlTag, QFilterCondition> {}

extension MlTagQueryWhereSortBy on QueryBuilder<MlTag, MlTag, QSortBy> {
  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByBlackListed() {
    return addSortByInternal('blackListed', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByBlackListedDesc() {
    return addSortByInternal('blackListed', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTagType() {
    return addSortByInternal('tagType', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTagTypeDesc() {
    return addSortByInternal('tagType', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTextID() {
    return addSortByInternal('textID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTextIDDesc() {
    return addSortByInternal('textID', Sort.desc);
  }
}

extension MlTagQueryWhereSortThenBy on QueryBuilder<MlTag, MlTag, QSortThenBy> {
  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByBlackListed() {
    return addSortByInternal('blackListed', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByBlackListedDesc() {
    return addSortByInternal('blackListed', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTagType() {
    return addSortByInternal('tagType', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTagTypeDesc() {
    return addSortByInternal('tagType', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTextID() {
    return addSortByInternal('textID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTextIDDesc() {
    return addSortByInternal('textID', Sort.desc);
  }
}

extension MlTagQueryWhereDistinct on QueryBuilder<MlTag, MlTag, QDistinct> {
  QueryBuilder<MlTag, MlTag, QDistinct> distinctByBlackListed() {
    return addDistinctByInternal('blackListed');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByConfidence() {
    return addDistinctByInternal('confidence');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByTagType() {
    return addDistinctByInternal('tagType');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByTextID() {
    return addDistinctByInternal('textID');
  }
}

extension MlTagQueryProperty on QueryBuilder<MlTag, MlTag, QQueryProperty> {
  QueryBuilder<MlTag, bool, QQueryOperations> blackListedProperty() {
    return addPropertyNameInternal('blackListed');
  }

  QueryBuilder<MlTag, double, QQueryOperations> confidenceProperty() {
    return addPropertyNameInternal('confidence');
  }

  QueryBuilder<MlTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MlTag, int, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }

  QueryBuilder<MlTag, MlTagType, QQueryOperations> tagTypeProperty() {
    return addPropertyNameInternal('tagType');
  }

  QueryBuilder<MlTag, int, QQueryOperations> textIDProperty() {
    return addPropertyNameInternal('textID');
  }
}
