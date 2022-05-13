// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_bounding_box.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetObjectBoundingBoxCollection on Isar {
  IsarCollection<ObjectBoundingBox> get objectBoundingBoxs {
    return getCollection('ObjectBoundingBox');
  }
}

final ObjectBoundingBoxSchema = CollectionSchema(
  name: 'ObjectBoundingBox',
  schema:
      '{"name":"ObjectBoundingBox","idName":"id","properties":[{"name":"boundingBox","type":"DoubleList"},{"name":"photoID","type":"Long"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ObjectBoundingBoxNativeAdapter(),
  webAdapter: const _ObjectBoundingBoxWebAdapter(),
  idName: 'id',
  propertyIds: {'boundingBox': 0, 'photoID': 1},
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

class _ObjectBoundingBoxWebAdapter
    extends IsarWebTypeAdapter<ObjectBoundingBox> {
  const _ObjectBoundingBoxWebAdapter();

  @override
  Object serialize(
      IsarCollection<ObjectBoundingBox> collection, ObjectBoundingBox object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'boundingBox', object.boundingBox);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
    return jsObj;
  }

  @override
  ObjectBoundingBox deserialize(
      IsarCollection<ObjectBoundingBox> collection, dynamic jsObj) {
    final object = ObjectBoundingBox();
    object.boundingBox = (IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
            ?.map((e) => e ?? double.negativeInfinity)
            .toList()
            .cast<double>() ??
        [];
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.photoID =
        IsarNative.jsObjectGet(jsObj, 'photoID') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'boundingBox':
        return ((IsarNative.jsObjectGet(jsObj, 'boundingBox') as List?)
                ?.map((e) => e ?? double.negativeInfinity)
                .toList()
                .cast<double>() ??
            []) as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'photoID':
        return (IsarNative.jsObjectGet(jsObj, 'photoID') ??
            double.negativeInfinity) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ObjectBoundingBox object) {}
}

class _ObjectBoundingBoxNativeAdapter
    extends IsarNativeTypeAdapter<ObjectBoundingBox> {
  const _ObjectBoundingBoxNativeAdapter();

  @override
  void serialize(
      IsarCollection<ObjectBoundingBox> collection,
      IsarRawObject rawObj,
      ObjectBoundingBox object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.boundingBox;
    dynamicSize += (value0.length) * 8;
    final _boundingBox = value0;
    final value1 = object.photoID;
    final _photoID = value1;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeDoubleList(offsets[0], _boundingBox);
    writer.writeLong(offsets[1], _photoID);
  }

  @override
  ObjectBoundingBox deserialize(IsarCollection<ObjectBoundingBox> collection,
      int id, IsarBinaryReader reader, List<int> offsets) {
    final object = ObjectBoundingBox();
    object.boundingBox = reader.readDoubleList(offsets[0]) ?? [];
    object.id = id;
    object.photoID = reader.readLong(offsets[1]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readDoubleList(offset) ?? []) as P;
      case 1:
        return (reader.readLong(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ObjectBoundingBox object) {}
}

extension ObjectBoundingBoxQueryWhereSort
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QWhere> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ObjectBoundingBoxQueryWhere
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QWhereClause> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idNotEqualTo(int id) {
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterWhereClause>
      idBetween(
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

extension ObjectBoundingBoxQueryFilter
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QFilterCondition> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      boundingBoxAnyGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      boundingBoxAnyLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'boundingBox',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      boundingBoxAnyBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'boundingBox',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
      photoIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterFilterCondition>
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
}

extension ObjectBoundingBoxQueryLinks
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QFilterCondition> {}

extension ObjectBoundingBoxQueryWhereSortBy
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QSortBy> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }
}

extension ObjectBoundingBoxQueryWhereSortThenBy
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QSortThenBy> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QAfterSortBy>
      thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }
}

extension ObjectBoundingBoxQueryWhereDistinct
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct> {
  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QDistinct>
      distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }
}

extension ObjectBoundingBoxQueryProperty
    on QueryBuilder<ObjectBoundingBox, ObjectBoundingBox, QQueryProperty> {
  QueryBuilder<ObjectBoundingBox, List<double>, QQueryOperations>
      boundingBoxProperty() {
    return addPropertyNameInternal('boundingBox');
  }

  QueryBuilder<ObjectBoundingBox, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ObjectBoundingBox, int, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }
}
