// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetPhotoTagCollection on Isar {
  IsarCollection<PhotoTag> get photoTags {
    return getCollection('PhotoTag');
  }
}

final PhotoTagSchema = CollectionSchema(
  name: 'PhotoTag',
  schema:
      '{"name":"PhotoTag","idName":"id","properties":[{"name":"boundingBox","type":"DoubleList"},{"name":"confidence","type":"Double"},{"name":"photoPath","type":"String"},{"name":"tagUID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _PhotoTagNativeAdapter(),
  webAdapter: const _PhotoTagWebAdapter(),
  idName: 'id',
  propertyIds: {'boundingBox': 0, 'confidence': 1, 'photoPath': 2, 'tagUID': 3},
  listProperties: {'boundingBox'},
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

class _PhotoTagWebAdapter extends IsarWebTypeAdapter<PhotoTag> {
  const _PhotoTagWebAdapter();

  @override
  Object serialize(IsarCollection<PhotoTag> collection, PhotoTag object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'boundingBox', object.boundingBox);
    IsarNative.jsObjectSet(jsObj, 'confidence', object.confidence);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'photoPath', object.photoPath);
    IsarNative.jsObjectSet(jsObj, 'tagUID', object.tagUID);
    return jsObj;
  }

  @override
  PhotoTag deserialize(IsarCollection<PhotoTag> collection, dynamic jsObj) {
    final object = PhotoTag();
    object.boundingBox = (IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
        ?.map((e) => e ?? double.negativeInfinity)
        .toList()
        .cast<double>();
    object.confidence =
        IsarNative.jsObjectGet(jsObj, 'confidence') ?? double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.photoPath = IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '';
    object.tagUID =
        IsarNative.jsObjectGet(jsObj, 'tagUID') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'boundingBox':
        return ((IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
            ?.map((e) => e ?? double.negativeInfinity)
            .toList()
            .cast<double>()) as P;
      case 'confidence':
        return (IsarNative.jsObjectGet(jsObj, 'confidence') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'photoPath':
        return (IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '') as P;
      case 'tagUID':
        return (IsarNative.jsObjectGet(jsObj, 'tagUID') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, PhotoTag object) {}
}

class _PhotoTagNativeAdapter extends IsarNativeTypeAdapter<PhotoTag> {
  const _PhotoTagNativeAdapter();

  @override
  void serialize(IsarCollection<PhotoTag> collection, IsarRawObject rawObj,
      PhotoTag object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.boundingBox;
    dynamicSize += (value0?.length ?? 0) * 8;
    final _boundingBox = value0;
    final value1 = object.confidence;
    final _confidence = value1;
    final value2 = object.photoPath;
    final _photoPath = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_photoPath.length) as int;
    final value3 = object.tagUID;
    final _tagUID = value3;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDoubleList(offsets[0], _boundingBox);
    writer.writeDouble(offsets[1], _confidence);
    writer.writeBytes(offsets[2], _photoPath);
    writer.writeLong(offsets[3], _tagUID);
  }

  @override
  PhotoTag deserialize(IsarCollection<PhotoTag> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = PhotoTag();
    object.boundingBox = reader.readDoubleList(offsets[0]);
    object.confidence = reader.readDouble(offsets[1]);
    object.id = id;
    object.photoPath = reader.readString(offsets[2]);
    object.tagUID = reader.readLong(offsets[3]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDoubleList(offset)) as P;
      case 1:
        return (reader.readDouble(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, PhotoTag object) {}
}

extension PhotoTagQueryWhereSort on QueryBuilder<PhotoTag, PhotoTag, QWhere> {
  QueryBuilder<PhotoTag, PhotoTag, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension PhotoTagQueryWhere on QueryBuilder<PhotoTag, PhotoTag, QWhereClause> {
  QueryBuilder<PhotoTag, PhotoTag, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<PhotoTag, PhotoTag, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterWhereClause> idBetween(
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

extension PhotoTagQueryFilter
    on QueryBuilder<PhotoTag, PhotoTag, QFilterCondition> {
  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> boundingBoxIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'boundingBox',
      value: null,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition>
      boundingBoxAnyIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'boundingBox',
      value: null,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition>
      boundingBoxAnyGreaterThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition>
      boundingBoxAnyLessThan(double? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> boundingBoxAnyBetween(
      double? lower, double? upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'boundingBox',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> confidenceGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> confidenceLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'confidence',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> confidenceBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'confidence',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'photoPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> photoPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'photoPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> tagUIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagUID',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> tagUIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tagUID',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> tagUIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tagUID',
      value: value,
    ));
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterFilterCondition> tagUIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tagUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension PhotoTagQueryLinks
    on QueryBuilder<PhotoTag, PhotoTag, QFilterCondition> {}

extension PhotoTagQueryWhereSortBy
    on QueryBuilder<PhotoTag, PhotoTag, QSortBy> {
  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByTagUID() {
    return addSortByInternal('tagUID', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> sortByTagUIDDesc() {
    return addSortByInternal('tagUID', Sort.desc);
  }
}

extension PhotoTagQueryWhereSortThenBy
    on QueryBuilder<PhotoTag, PhotoTag, QSortThenBy> {
  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByConfidence() {
    return addSortByInternal('confidence', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByConfidenceDesc() {
    return addSortByInternal('confidence', Sort.desc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByTagUID() {
    return addSortByInternal('tagUID', Sort.asc);
  }

  QueryBuilder<PhotoTag, PhotoTag, QAfterSortBy> thenByTagUIDDesc() {
    return addSortByInternal('tagUID', Sort.desc);
  }
}

extension PhotoTagQueryWhereDistinct
    on QueryBuilder<PhotoTag, PhotoTag, QDistinct> {
  QueryBuilder<PhotoTag, PhotoTag, QDistinct> distinctByConfidence() {
    return addDistinctByInternal('confidence');
  }

  QueryBuilder<PhotoTag, PhotoTag, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<PhotoTag, PhotoTag, QDistinct> distinctByPhotoPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('photoPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<PhotoTag, PhotoTag, QDistinct> distinctByTagUID() {
    return addDistinctByInternal('tagUID');
  }
}

extension PhotoTagQueryProperty
    on QueryBuilder<PhotoTag, PhotoTag, QQueryProperty> {
  QueryBuilder<PhotoTag, List<double>?, QQueryOperations>
      boundingBoxProperty() {
    return addPropertyNameInternal('boundingBox');
  }

  QueryBuilder<PhotoTag, double, QQueryOperations> confidenceProperty() {
    return addPropertyNameInternal('confidence');
  }

  QueryBuilder<PhotoTag, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<PhotoTag, String, QQueryOperations> photoPathProperty() {
    return addPropertyNameInternal('photoPath');
  }

  QueryBuilder<PhotoTag, int, QQueryOperations> tagUIDProperty() {
    return addPropertyNameInternal('tagUID');
  }
}
