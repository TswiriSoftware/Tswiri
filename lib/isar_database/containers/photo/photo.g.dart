// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'photo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetPhotoCollection on Isar {
  IsarCollection<Photo> get photos => getCollection();
}

const PhotoSchema = CollectionSchema(
  name: 'Photo',
  schema:
      '{"name":"Photo","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"hashCode","type":"Long"},{"name":"photoPath","type":"String"},{"name":"thumbnailPath","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'containerUID': 0,
    'hashCode': 1,
    'photoPath': 2,
    'thumbnailPath': 3
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _photoGetId,
  setId: _photoSetId,
  getLinks: _photoGetLinks,
  attachLinks: _photoAttachLinks,
  serializeNative: _photoSerializeNative,
  deserializeNative: _photoDeserializeNative,
  deserializePropNative: _photoDeserializePropNative,
  serializeWeb: _photoSerializeWeb,
  deserializeWeb: _photoDeserializeWeb,
  deserializePropWeb: _photoDeserializePropWeb,
  version: 3,
);

int? _photoGetId(Photo object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _photoSetId(Photo object, int id) {
  object.id = id;
}

List<IsarLinkBase> _photoGetLinks(Photo object) {
  return [];
}

void _photoSerializeNative(
    IsarCollection<Photo> collection,
    IsarRawObject rawObj,
    Photo object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.containerUID;
  final _containerUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_containerUID.length) as int;
  final value1 = object.hashCode;
  final _hashCode = value1;
  final value2 = object.photoPath;
  final _photoPath = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_photoPath.length) as int;
  final value3 = object.thumbnailPath;
  final _thumbnailPath = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_thumbnailPath.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _containerUID);
  writer.writeLong(offsets[1], _hashCode);
  writer.writeBytes(offsets[2], _photoPath);
  writer.writeBytes(offsets[3], _thumbnailPath);
}

Photo _photoDeserializeNative(IsarCollection<Photo> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Photo();
  object.containerUID = reader.readString(offsets[0]);
  object.id = id;
  object.photoPath = reader.readString(offsets[2]);
  object.thumbnailPath = reader.readString(offsets[3]);
  return object;
}

P _photoDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _photoSerializeWeb(IsarCollection<Photo> collection, Photo object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoPath', object.photoPath);
  IsarNative.jsObjectSet(jsObj, 'thumbnailPath', object.thumbnailPath);
  return jsObj;
}

Photo _photoDeserializeWeb(IsarCollection<Photo> collection, dynamic jsObj) {
  final object = Photo();
  object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoPath = IsarNative.jsObjectGet(jsObj, 'photoPath') ?? '';
  object.thumbnailPath = IsarNative.jsObjectGet(jsObj, 'thumbnailPath') ?? '';
  return object;
}

P _photoDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'containerUID':
      return (IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '') as P;
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
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

void _photoAttachLinks(IsarCollection col, int id, Photo object) {}

extension PhotoQueryWhereSort on QueryBuilder<Photo, Photo, QWhere> {
  QueryBuilder<Photo, Photo, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension PhotoQueryWhere on QueryBuilder<Photo, Photo, QWhereClause> {
  QueryBuilder<Photo, Photo, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Photo, Photo, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idBetween(
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

extension PhotoQueryFilter on QueryBuilder<Photo, Photo, QFilterCondition> {
  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDEqualTo(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDGreaterThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDLessThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDBetween(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDStartsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDEndsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> hashCodeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> hashCodeBetween(
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
  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
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
  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
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
  QueryBuilder<Photo, Photo, QDistinct> distinctByContainerUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
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
  QueryBuilder<Photo, String, QQueryOperations> containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<Photo, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
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
