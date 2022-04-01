// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_photo_thumbnail.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetContainerPhotoThumbnailCollection on Isar {
  IsarCollection<ContainerPhotoThumbnail> get containerPhotoThumbnails {
    return getCollection('ContainerPhotoThumbnail');
  }
}

final ContainerPhotoThumbnailSchema = CollectionSchema(
  name: 'ContainerPhotoThumbnail',
  schema:
      '{"name":"ContainerPhotoThumbnail","idName":"id","properties":[{"name":"photoPath","type":"String"},{"name":"thumbnailPhotoPath","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ContainerPhotoThumbnailNativeAdapter(),
  webAdapter: const _ContainerPhotoThumbnailWebAdapter(),
  idName: 'id',
  propertyIds: {'photoPath': 0, 'thumbnailPhotoPath': 1},
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

class _ContainerPhotoThumbnailWebAdapter
    extends IsarWebTypeAdapter<ContainerPhotoThumbnail> {
  const _ContainerPhotoThumbnailWebAdapter();

  @override
  Object serialize(IsarCollection<ContainerPhotoThumbnail> collection,
      ContainerPhotoThumbnail object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'photoPath', object.photoPath);
    IsarNative.jsObjectSet(
        jsObj, 'thumbnailPhotoPath', object.thumbnailPhotoPath);
    return jsObj;
  }

  @override
  ContainerPhotoThumbnail deserialize(
      IsarCollection<ContainerPhotoThumbnail> collection, dynamic jsObj) {
    final object = ContainerPhotoThumbnail();
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.photoPath = IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '';
    object.thumbnailPhotoPath =
        IsarNative.jsObjectGet(jsObj, 'thumbnailPhotoPath') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'photoPath':
        return (IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '') as P;
      case 'thumbnailPhotoPath':
        return (IsarNative.jsObjectGet(jsObj, 'thumbnailPhotoPath') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerPhotoThumbnail object) {}
}

class _ContainerPhotoThumbnailNativeAdapter
    extends IsarNativeTypeAdapter<ContainerPhotoThumbnail> {
  const _ContainerPhotoThumbnailNativeAdapter();

  @override
  void serialize(
      IsarCollection<ContainerPhotoThumbnail> collection,
      IsarRawObject rawObj,
      ContainerPhotoThumbnail object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.photoPath;
    final _photoPath = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_photoPath.length) as int;
    final value1 = object.thumbnailPhotoPath;
    final _thumbnailPhotoPath = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_thumbnailPhotoPath.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _photoPath);
    writer.writeBytes(offsets[1], _thumbnailPhotoPath);
  }

  @override
  ContainerPhotoThumbnail deserialize(
      IsarCollection<ContainerPhotoThumbnail> collection,
      int id,
      IsarBinaryReader reader,
      List<int> offsets) {
    final object = ContainerPhotoThumbnail();
    object.id = id;
    object.photoPath = reader.readString(offsets[0]);
    object.thumbnailPhotoPath = reader.readString(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerPhotoThumbnail object) {}
}

extension ContainerPhotoThumbnailQueryWhereSort
    on QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QWhere> {
  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ContainerPhotoThumbnailQueryWhere on QueryBuilder<
    ContainerPhotoThumbnail, ContainerPhotoThumbnail, QWhereClause> {
  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterWhereClause> idBetween(
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

extension ContainerPhotoThumbnailQueryFilter on QueryBuilder<
    ContainerPhotoThumbnail, ContainerPhotoThumbnail, QFilterCondition> {
  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> photoPathEqualTo(
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> photoPathGreaterThan(
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> photoPathLessThan(
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> photoPathBetween(
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> photoPathStartsWith(
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> photoPathEndsWith(
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

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
          QAfterFilterCondition>
      photoPathContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
          QAfterFilterCondition>
      photoPathMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'photoPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> thumbnailPhotoPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'thumbnailPhotoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> thumbnailPhotoPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'thumbnailPhotoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> thumbnailPhotoPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'thumbnailPhotoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> thumbnailPhotoPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'thumbnailPhotoPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> thumbnailPhotoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'thumbnailPhotoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
      QAfterFilterCondition> thumbnailPhotoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'thumbnailPhotoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
          QAfterFilterCondition>
      thumbnailPhotoPathContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'thumbnailPhotoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail,
          QAfterFilterCondition>
      thumbnailPhotoPathMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'thumbnailPhotoPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ContainerPhotoThumbnailQueryLinks on QueryBuilder<
    ContainerPhotoThumbnail, ContainerPhotoThumbnail, QFilterCondition> {}

extension ContainerPhotoThumbnailQueryWhereSortBy
    on QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QSortBy> {
  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      sortByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      sortByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      sortByThumbnailPhotoPath() {
    return addSortByInternal('thumbnailPhotoPath', Sort.asc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      sortByThumbnailPhotoPathDesc() {
    return addSortByInternal('thumbnailPhotoPath', Sort.desc);
  }
}

extension ContainerPhotoThumbnailQueryWhereSortThenBy on QueryBuilder<
    ContainerPhotoThumbnail, ContainerPhotoThumbnail, QSortThenBy> {
  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      thenByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      thenByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      thenByThumbnailPhotoPath() {
    return addSortByInternal('thumbnailPhotoPath', Sort.asc);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QAfterSortBy>
      thenByThumbnailPhotoPathDesc() {
    return addSortByInternal('thumbnailPhotoPath', Sort.desc);
  }
}

extension ContainerPhotoThumbnailQueryWhereDistinct on QueryBuilder<
    ContainerPhotoThumbnail, ContainerPhotoThumbnail, QDistinct> {
  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QDistinct>
      distinctByPhotoPath({bool caseSensitive = true}) {
    return addDistinctByInternal('photoPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerPhotoThumbnail, ContainerPhotoThumbnail, QDistinct>
      distinctByThumbnailPhotoPath({bool caseSensitive = true}) {
    return addDistinctByInternal('thumbnailPhotoPath',
        caseSensitive: caseSensitive);
  }
}

extension ContainerPhotoThumbnailQueryProperty on QueryBuilder<
    ContainerPhotoThumbnail, ContainerPhotoThumbnail, QQueryProperty> {
  QueryBuilder<ContainerPhotoThumbnail, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerPhotoThumbnail, String, QQueryOperations>
      photoPathProperty() {
    return addPropertyNameInternal('photoPath');
  }

  QueryBuilder<ContainerPhotoThumbnail, String, QQueryOperations>
      thumbnailPhotoPathProperty() {
    return addPropertyNameInternal('thumbnailPhotoPath');
  }
}
