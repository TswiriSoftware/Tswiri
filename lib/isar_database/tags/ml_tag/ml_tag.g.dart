// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetMlTagCollection on Isar {
  IsarCollection<MlTag> get mlTags {
    return getCollection('MlTag');
  }
}

final MlTagSchema = CollectionSchema(
  name: 'MlTag',
  schema:
      '{"name":"MlTag","idName":"id","properties":[{"name":"confidence","type":"Double"},{"name":"mlTagID","type":"Long"},{"name":"tagType","type":"Long"},{"name":"textTagID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _MlTagNativeAdapter(),
  webAdapter: const _MlTagWebAdapter(),
  idName: 'id',
  propertyIds: {'confidence': 0, 'mlTagID': 1, 'tagType': 2, 'textTagID': 3},
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

const _mlTagMlTagTypeConverter = MlTagTypeConverter();

class _MlTagWebAdapter extends IsarWebTypeAdapter<MlTag> {
  const _MlTagWebAdapter();

  @override
  Object serialize(IsarCollection<MlTag> collection, MlTag object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'confidence', object.confidence);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'mlTagID', object.mlTagID);
    IsarNative.jsObjectSet(
        jsObj, 'tagType', _mlTagMlTagTypeConverter.toIsar(object.tagType));
    IsarNative.jsObjectSet(jsObj, 'textTagID', object.textTagID);
    return jsObj;
  }

  @override
  MlTag deserialize(IsarCollection<MlTag> collection, dynamic jsObj) {
    final object = MlTag();
    object.confidence =
        IsarNative.jsObjectGet(jsObj, 'confidence') ?? double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.mlTagID =
        IsarNative.jsObjectGet(jsObj, 'mlTagID') ?? double.negativeInfinity;
    object.tagType = _mlTagMlTagTypeConverter.fromIsar(
        IsarNative.jsObjectGet(jsObj, 'tagType') ?? double.negativeInfinity);
    object.textTagID =
        IsarNative.jsObjectGet(jsObj, 'textTagID') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'confidence':
        return (IsarNative.jsObjectGet(jsObj, 'confidence') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'mlTagID':
        return (IsarNative.jsObjectGet(jsObj, 'mlTagID') ??
            double.negativeInfinity) as P;
      case 'tagType':
        return (_mlTagMlTagTypeConverter.fromIsar(
            IsarNative.jsObjectGet(jsObj, 'tagType') ??
                double.negativeInfinity)) as P;
      case 'textTagID':
        return (IsarNative.jsObjectGet(jsObj, 'textTagID') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, MlTag object) {}
}

class _MlTagNativeAdapter extends IsarNativeTypeAdapter<MlTag> {
  const _MlTagNativeAdapter();

  @override
  void serialize(IsarCollection<MlTag> collection, IsarRawObject rawObj,
      MlTag object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.confidence;
    final _confidence = value0;
    final value1 = object.mlTagID;
    final _mlTagID = value1;
    final value2 = _mlTagMlTagTypeConverter.toIsar(object.tagType);
    final _tagType = value2;
    final value3 = object.textTagID;
    final _textTagID = value3;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDouble(offsets[0], _confidence);
    writer.writeLong(offsets[1], _mlTagID);
    writer.writeLong(offsets[2], _tagType);
    writer.writeLong(offsets[3], _textTagID);
  }

  @override
  MlTag deserialize(IsarCollection<MlTag> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = MlTag();
    object.confidence = reader.readDouble(offsets[0]);
    object.id = id;
    object.mlTagID = reader.readLong(offsets[1]);
    object.tagType =
        _mlTagMlTagTypeConverter.fromIsar(reader.readLong(offsets[2]));
    object.textTagID = reader.readLong(offsets[3]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDouble(offset)) as P;
      case 1:
        return (reader.readLong(offset)) as P;
      case 2:
        return (_mlTagMlTagTypeConverter.fromIsar(reader.readLong(offset)))
            as P;
      case 3:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, MlTag object) {}
}

extension MlTagQueryWhereSort on QueryBuilder<MlTag, MlTag, QWhere> {
  QueryBuilder<MlTag, MlTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension MlTagQueryWhere on QueryBuilder<MlTag, MlTag, QWhereClause> {
  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterWhereClause> idBetween(
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

extension MlTagQueryFilter on QueryBuilder<MlTag, MlTag, QFilterCondition> {
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> mlTagIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> mlTagIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> mlTagIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'mlTagID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> mlTagIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'mlTagID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagTypeEqualTo(
      mlTagType value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagType',
      value: _mlTagMlTagTypeConverter.toIsar(value),
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> tagTypeGreaterThan(
    mlTagType value, {
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
    mlTagType value, {
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
    mlTagType lower,
    mlTagType upper, {
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

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textTagIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'textTagID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textTagIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'textTagID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textTagIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'textTagID',
      value: value,
    ));
  }

  QueryBuilder<MlTag, MlTag, QAfterFilterCondition> textTagIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'textTagID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension MlTagQueryLinks on QueryBuilder<MlTag, MlTag, QFilterCondition> {}

extension MlTagQueryWhereSortBy on QueryBuilder<MlTag, MlTag, QSortBy> {
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

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByMlTagID() {
    return addSortByInternal('mlTagID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByMlTagIDDesc() {
    return addSortByInternal('mlTagID', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTagType() {
    return addSortByInternal('tagType', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTagTypeDesc() {
    return addSortByInternal('tagType', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTextTagID() {
    return addSortByInternal('textTagID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> sortByTextTagIDDesc() {
    return addSortByInternal('textTagID', Sort.desc);
  }
}

extension MlTagQueryWhereSortThenBy on QueryBuilder<MlTag, MlTag, QSortThenBy> {
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

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByMlTagID() {
    return addSortByInternal('mlTagID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByMlTagIDDesc() {
    return addSortByInternal('mlTagID', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTagType() {
    return addSortByInternal('tagType', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTagTypeDesc() {
    return addSortByInternal('tagType', Sort.desc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTextTagID() {
    return addSortByInternal('textTagID', Sort.asc);
  }

  QueryBuilder<MlTag, MlTag, QAfterSortBy> thenByTextTagIDDesc() {
    return addSortByInternal('textTagID', Sort.desc);
  }
}

extension MlTagQueryWhereDistinct on QueryBuilder<MlTag, MlTag, QDistinct> {
  QueryBuilder<MlTag, MlTag, QDistinct> distinctByConfidence() {
    return addDistinctByInternal('confidence');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByMlTagID() {
    return addDistinctByInternal('mlTagID');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByTagType() {
    return addDistinctByInternal('tagType');
  }

  QueryBuilder<MlTag, MlTag, QDistinct> distinctByTextTagID() {
    return addDistinctByInternal('textTagID');
  }
}

extension MlTagQueryProperty on QueryBuilder<MlTag, MlTag, QQueryProperty> {
  QueryBuilder<MlTag, double, QQueryOperations> confidenceProperty() {
    return addPropertyNameInternal('confidence');
  }

  QueryBuilder<MlTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MlTag, int, QQueryOperations> mlTagIDProperty() {
    return addPropertyNameInternal('mlTagID');
  }

  QueryBuilder<MlTag, mlTagType, QQueryOperations> tagTypeProperty() {
    return addPropertyNameInternal('tagType');
  }

  QueryBuilder<MlTag, int, QQueryOperations> textTagIDProperty() {
    return addPropertyNameInternal('textTagID');
  }
}
