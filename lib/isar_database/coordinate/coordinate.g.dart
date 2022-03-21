// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinate.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetCoordinateCollection on Isar {
  IsarCollection<Coordinate> get coordinates {
    return getCollection('Coordinate');
  }
}

final CoordinateSchema = CollectionSchema(
  name: 'Coordinate',
  schema:
      '{"name":"Coordinate","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"x","type":"Double"},{"name":"y","type":"Double"},{"name":"z","type":"Double"}],"indexes":[],"links":[]}',
  nativeAdapter: const _CoordinateNativeAdapter(),
  webAdapter: const _CoordinateWebAdapter(),
  idName: 'id',
  propertyIds: {'barcodeUID': 0, 'x': 1, 'y': 2, 'z': 3},
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

class _CoordinateWebAdapter extends IsarWebTypeAdapter<Coordinate> {
  const _CoordinateWebAdapter();

  @override
  Object serialize(IsarCollection<Coordinate> collection, Coordinate object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'x', object.x);
    IsarNative.jsObjectSet(jsObj, 'y', object.y);
    IsarNative.jsObjectSet(jsObj, 'z', object.z);
    return jsObj;
  }

  @override
  Coordinate deserialize(IsarCollection<Coordinate> collection, dynamic jsObj) {
    final object = Coordinate();
    object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.x = IsarNative.jsObjectGet(jsObj, 'x') ?? double.negativeInfinity;
    object.y = IsarNative.jsObjectGet(jsObj, 'y') ?? double.negativeInfinity;
    object.z = IsarNative.jsObjectGet(jsObj, 'z') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'barcodeUID':
        return (IsarNative.jsObjectGet(jsObj, 'barcodeUID') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'x':
        return (IsarNative.jsObjectGet(jsObj, 'x') ?? double.negativeInfinity)
            as P;
      case 'y':
        return (IsarNative.jsObjectGet(jsObj, 'y') ?? double.negativeInfinity)
            as P;
      case 'z':
        return (IsarNative.jsObjectGet(jsObj, 'z') ?? double.negativeInfinity)
            as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Coordinate object) {}
}

class _CoordinateNativeAdapter extends IsarNativeTypeAdapter<Coordinate> {
  const _CoordinateNativeAdapter();

  @override
  void serialize(
      IsarCollection<Coordinate> collection,
      IsarRawObject rawObj,
      Coordinate object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.barcodeUID;
    final _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_barcodeUID.length) as int;
    final value1 = object.x;
    final _x = value1;
    final value2 = object.y;
    final _y = value2;
    final value3 = object.z;
    final _z = value3;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _barcodeUID);
    writer.writeDouble(offsets[1], _x);
    writer.writeDouble(offsets[2], _y);
    writer.writeDouble(offsets[3], _z);
  }

  @override
  Coordinate deserialize(IsarCollection<Coordinate> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Coordinate();
    object.barcodeUID = reader.readString(offsets[0]);
    object.id = id;
    object.x = reader.readDouble(offsets[1]);
    object.y = reader.readDouble(offsets[2]);
    object.z = reader.readDouble(offsets[3]);
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
        return (reader.readDouble(offset)) as P;
      case 2:
        return (reader.readDouble(offset)) as P;
      case 3:
        return (reader.readDouble(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, Coordinate object) {}
}

extension CoordinateQueryWhereSort
    on QueryBuilder<Coordinate, Coordinate, QWhere> {
  QueryBuilder<Coordinate, Coordinate, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension CoordinateQueryWhere
    on QueryBuilder<Coordinate, Coordinate, QWhereClause> {
  QueryBuilder<Coordinate, Coordinate, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Coordinate, Coordinate, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterWhereClause> idBetween(
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

extension CoordinateQueryFilter
    on QueryBuilder<Coordinate, Coordinate, QFilterCondition> {
  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> barcodeUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition>
      barcodeUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition>
      barcodeUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> barcodeUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'barcodeUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition>
      barcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition>
      barcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> barcodeUIDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> xGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> xLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'x',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> xBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'x',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> yGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> yLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'y',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> yBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'y',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> zGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> zLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'z',
      value: value,
    ));
  }

  QueryBuilder<Coordinate, Coordinate, QAfterFilterCondition> zBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'z',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension CoordinateQueryLinks
    on QueryBuilder<Coordinate, Coordinate, QFilterCondition> {}

extension CoordinateQueryWhereSortBy
    on QueryBuilder<Coordinate, Coordinate, QSortBy> {
  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> sortByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension CoordinateQueryWhereSortThenBy
    on QueryBuilder<Coordinate, Coordinate, QSortThenBy> {
  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByX() {
    return addSortByInternal('x', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByXDesc() {
    return addSortByInternal('x', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByY() {
    return addSortByInternal('y', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByYDesc() {
    return addSortByInternal('y', Sort.desc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByZ() {
    return addSortByInternal('z', Sort.asc);
  }

  QueryBuilder<Coordinate, Coordinate, QAfterSortBy> thenByZDesc() {
    return addSortByInternal('z', Sort.desc);
  }
}

extension CoordinateQueryWhereDistinct
    on QueryBuilder<Coordinate, Coordinate, QDistinct> {
  QueryBuilder<Coordinate, Coordinate, QDistinct> distinctByBarcodeUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<Coordinate, Coordinate, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Coordinate, Coordinate, QDistinct> distinctByX() {
    return addDistinctByInternal('x');
  }

  QueryBuilder<Coordinate, Coordinate, QDistinct> distinctByY() {
    return addDistinctByInternal('y');
  }

  QueryBuilder<Coordinate, Coordinate, QDistinct> distinctByZ() {
    return addDistinctByInternal('z');
  }
}

extension CoordinateQueryProperty
    on QueryBuilder<Coordinate, Coordinate, QQueryProperty> {
  QueryBuilder<Coordinate, String, QQueryOperations> barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<Coordinate, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Coordinate, double, QQueryOperations> xProperty() {
    return addPropertyNameInternal('x');
  }

  QueryBuilder<Coordinate, double, QQueryOperations> yProperty() {
    return addPropertyNameInternal('y');
  }

  QueryBuilder<Coordinate, double, QQueryOperations> zProperty() {
    return addPropertyNameInternal('z');
  }
}
