// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_photo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetContainerPhotoCollection on Isar {
  IsarCollection<ContainerPhoto> get containerPhotos {
    return getCollection('ContainerPhoto');
  }
}

final ContainerPhotoSchema = CollectionSchema(
  name: 'ContainerPhoto',
  schema:
      '{"name":"ContainerPhoto","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"photoPath","type":"String"},{"name":"photoThumbnailPath","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ContainerPhotoNativeAdapter(),
  webAdapter: const _ContainerPhotoWebAdapter(),
  idName: 'id',
  propertyIds: {'containerUID': 0, 'photoPath': 1, 'photoThumbnailPath': 2},
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

class _ContainerPhotoWebAdapter extends IsarWebTypeAdapter<ContainerPhoto> {
  const _ContainerPhotoWebAdapter();

  @override
  Object serialize(
      IsarCollection<ContainerPhoto> collection, ContainerPhoto object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'photoPath', object.photoPath);
    IsarNative.jsObjectSet(
        jsObj, 'photoThumbnailPath', object.photoThumbnailPath);
    return jsObj;
  }

  @override
  ContainerPhoto deserialize(
      IsarCollection<ContainerPhoto> collection, dynamic jsObj) {
    final object = ContainerPhoto();
    object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.photoPath = IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '';
    object.photoThumbnailPath =
        IsarNative.jsObjectGet(jsObj, 'photoThumbnailPath') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'containerUID':
        return (IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'photoPath':
        return (IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '') as P;
      case 'photoThumbnailPath':
        return (IsarNative.jsObjectGet(jsObj, 'photoThumbnailPath') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerPhoto object) {}
}

class _ContainerPhotoNativeAdapter
    extends IsarNativeTypeAdapter<ContainerPhoto> {
  const _ContainerPhotoNativeAdapter();

  @override
  void serialize(
      IsarCollection<ContainerPhoto> collection,
      IsarRawObject rawObj,
      ContainerPhoto object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.containerUID;
    final _containerUID = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_containerUID.length) as int;
    final value1 = object.photoPath;
    final _photoPath = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_photoPath.length) as int;
    final value2 = object.photoThumbnailPath;
    final _photoThumbnailPath = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_photoThumbnailPath.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _containerUID);
    writer.writeBytes(offsets[1], _photoPath);
    writer.writeBytes(offsets[2], _photoThumbnailPath);
  }

  @override
  ContainerPhoto deserialize(IsarCollection<ContainerPhoto> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = ContainerPhoto();
    object.containerUID = reader.readString(offsets[0]);
    object.id = id;
    object.photoPath = reader.readString(offsets[1]);
    object.photoThumbnailPath = reader.readString(offsets[2]);
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
      case 2:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerPhoto object) {}
}

extension ContainerPhotoQueryWhereSort
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QWhere> {
  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ContainerPhotoQueryWhere
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QWhereClause> {
  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterWhereClause> idNotEqualTo(
      int id) {
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterWhereClause> idBetween(
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

extension ContainerPhotoQueryFilter
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QFilterCondition> {
  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathEqualTo(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathGreaterThan(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathLessThan(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathBetween(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathStartsWith(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathEndsWith(
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

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoPathMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'photoPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoThumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'photoThumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'photoThumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'photoThumbnailPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'photoThumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'photoThumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'photoThumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterFilterCondition>
      photoThumbnailPathMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'photoThumbnailPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ContainerPhotoQueryLinks
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QFilterCondition> {}

extension ContainerPhotoQueryWhereSortBy
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QSortBy> {
  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy> sortByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      sortByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      sortByPhotoThumbnailPath() {
    return addSortByInternal('photoThumbnailPath', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      sortByPhotoThumbnailPathDesc() {
    return addSortByInternal('photoThumbnailPath', Sort.desc);
  }
}

extension ContainerPhotoQueryWhereSortThenBy
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QSortThenBy> {
  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy> thenByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      thenByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      thenByPhotoThumbnailPath() {
    return addSortByInternal('photoThumbnailPath', Sort.asc);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QAfterSortBy>
      thenByPhotoThumbnailPathDesc() {
    return addSortByInternal('photoThumbnailPath', Sort.desc);
  }
}

extension ContainerPhotoQueryWhereDistinct
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QDistinct> {
  QueryBuilder<ContainerPhoto, ContainerPhoto, QDistinct>
      distinctByContainerUID({bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QDistinct> distinctByPhotoPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('photoPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerPhoto, ContainerPhoto, QDistinct>
      distinctByPhotoThumbnailPath({bool caseSensitive = true}) {
    return addDistinctByInternal('photoThumbnailPath',
        caseSensitive: caseSensitive);
  }
}

extension ContainerPhotoQueryProperty
    on QueryBuilder<ContainerPhoto, ContainerPhoto, QQueryProperty> {
  QueryBuilder<ContainerPhoto, String, QQueryOperations>
      containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<ContainerPhoto, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerPhoto, String, QQueryOperations> photoPathProperty() {
    return addPropertyNameInternal('photoPath');
  }

  QueryBuilder<ContainerPhoto, String, QQueryOperations>
      photoThumbnailPathProperty() {
    return addPropertyNameInternal('photoThumbnailPath');
  }
}
