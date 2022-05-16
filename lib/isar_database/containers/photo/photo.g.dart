// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetPhotoCollection on Isar {
  IsarCollection<Photo> get photos {
    return getCollection('Photo');
  }
}

final PhotoSchema = CollectionSchema(
  name: 'Photo',
  schema:
      '{"name":"Photo","idName":"id","properties":[{"name":"containerID","type":"Long"},{"name":"photoPath","type":"String"},{"name":"thumbnailPath","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _PhotoNativeAdapter(),
  webAdapter: const _PhotoWebAdapter(),
  idName: 'id',
  propertyIds: {'containerID': 0, 'photoPath': 1, 'thumbnailPath': 2},
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

class _PhotoWebAdapter extends IsarWebTypeAdapter<Photo> {
  const _PhotoWebAdapter();

  @override
  Object serialize(IsarCollection<Photo> collection, Photo object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'containerID', object.containerID);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'photoPath', object.photoPath);
    IsarNative.jsObjectSet(jsObj, 'thumbnailPath', object.thumbnailPath);
    return jsObj;
  }

  @override
  Photo deserialize(IsarCollection<Photo> collection, dynamic jsObj) {
    final object = Photo();
    object.containerID =
        IsarNative.jsObjectGet(jsObj, 'containerID') ?? double.negativeInfinity;
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.photoPath = IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '';
    object.thumbnailPath = IsarNative.jsObjectGet(jsObj, 'thumbnailPath') ?? '';
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'containerID':
        return (IsarNative.jsObjectGet(jsObj, 'containerID') ??
            double.negativeInfinity) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'photoPath':
        return (IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '') as P;
      case 'thumbnailPath':
        return (IsarNative.jsObjectGet(jsObj, 'thumbnailPath') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Photo object) {}
}

class _PhotoNativeAdapter extends IsarNativeTypeAdapter<Photo> {
  const _PhotoNativeAdapter();

  @override
  void serialize(IsarCollection<Photo> collection, IsarRawObject rawObj,
      Photo object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.containerID;
    final _containerID = value0;
    final value1 = object.photoPath;
    final _photoPath = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_photoPath.length) as int;
    final value2 = object.thumbnailPath;
    final _thumbnailPath = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_thumbnailPath.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeLong(offsets[0], _containerID);
    writer.writeBytes(offsets[1], _photoPath);
    writer.writeBytes(offsets[2], _thumbnailPath);
  }

  @override
  Photo deserialize(IsarCollection<Photo> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Photo();
    object.containerID = reader.readLong(offsets[0]);
    object.id = id;
    object.photoPath = reader.readString(offsets[1]);
    object.thumbnailPath = reader.readString(offsets[2]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readLong(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Photo object) {}
}

extension PhotoQueryWhereSort on QueryBuilder<Photo, Photo, QWhere> {
  QueryBuilder<Photo, Photo, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension PhotoQueryWhere on QueryBuilder<Photo, Photo, QWhereClause> {
  QueryBuilder<Photo, Photo, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Photo, Photo, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idBetween(
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

extension PhotoQueryFilter on QueryBuilder<Photo, Photo, QFilterCondition> {
  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerID',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerID',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerID',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathEqualTo(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathGreaterThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathLessThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathBetween(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathStartsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathEndsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'photoPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'photoPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'thumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'thumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'thumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'thumbnailPath',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'thumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'thumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'thumbnailPath',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'thumbnailPath',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension PhotoQueryLinks on QueryBuilder<Photo, Photo, QFilterCondition> {}

extension PhotoQueryWhereSortBy on QueryBuilder<Photo, Photo, QSortBy> {
  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerID() {
    return addSortByInternal('containerID', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerIDDesc() {
    return addSortByInternal('containerID', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailPath() {
    return addSortByInternal('thumbnailPath', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailPathDesc() {
    return addSortByInternal('thumbnailPath', Sort.desc);
  }
}

extension PhotoQueryWhereSortThenBy on QueryBuilder<Photo, Photo, QSortThenBy> {
  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerID() {
    return addSortByInternal('containerID', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerIDDesc() {
    return addSortByInternal('containerID', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByPhotoPath() {
    return addSortByInternal('photoPath', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByPhotoPathDesc() {
    return addSortByInternal('photoPath', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailPath() {
    return addSortByInternal('thumbnailPath', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailPathDesc() {
    return addSortByInternal('thumbnailPath', Sort.desc);
  }
}

extension PhotoQueryWhereDistinct on QueryBuilder<Photo, Photo, QDistinct> {
  QueryBuilder<Photo, Photo, QDistinct> distinctByContainerID() {
    return addDistinctByInternal('containerID');
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByPhotoPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('photoPath', caseSensitive: caseSensitive);
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByThumbnailPath(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('thumbnailPath', caseSensitive: caseSensitive);
  }
}

extension PhotoQueryProperty on QueryBuilder<Photo, Photo, QQueryProperty> {
  QueryBuilder<Photo, int, QQueryOperations> containerIDProperty() {
    return addPropertyNameInternal('containerID');
  }

  QueryBuilder<Photo, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Photo, String, QQueryOperations> photoPathProperty() {
    return addPropertyNameInternal('photoPath');
  }

  QueryBuilder<Photo, String, QQueryOperations> thumbnailPathProperty() {
    return addPropertyNameInternal('thumbnailPath');
  }
}
