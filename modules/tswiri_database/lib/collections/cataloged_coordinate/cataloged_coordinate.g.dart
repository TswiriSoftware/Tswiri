// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cataloged_coordinate.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCatalogedCoordinateCollection on Isar {
  IsarCollection<CatalogedCoordinate> get catalogedCoordinates =>
      this.collection();
}

const CatalogedCoordinateSchema = CollectionSchema(
  name: r'CatalogedCoordinate',
  id: -3206886641433459108,
  properties: {
    r'barcodeUID': PropertySchema(
      id: 0,
      name: r'barcodeUID',
      type: IsarType.string,
    ),
    r'coordinate': PropertySchema(
      id: 1,
      name: r'coordinate',
      type: IsarType.object,
      target: r'IsarVector3',
    ),
    r'gridUID': PropertySchema(
      id: 2,
      name: r'gridUID',
      type: IsarType.long,
    ),
    r'rotation': PropertySchema(
      id: 3,
      name: r'rotation',
      type: IsarType.object,
      target: r'IsarVector3',
    ),
    r'timestamp': PropertySchema(
      id: 4,
      name: r'timestamp',
      type: IsarType.long,
    )
  },
  estimateSize: _catalogedCoordinateEstimateSize,
  serialize: _catalogedCoordinateSerialize,
  deserialize: _catalogedCoordinateDeserialize,
  deserializeProp: _catalogedCoordinateDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'IsarVector3': IsarVector3Schema},
  getId: _catalogedCoordinateGetId,
  getLinks: _catalogedCoordinateGetLinks,
  attach: _catalogedCoordinateAttach,
  version: '3.1.0+1',
);

int _catalogedCoordinateEstimateSize(
  CatalogedCoordinate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.barcodeUID.length * 3;
  {
    final value = object.coordinate;
    if (value != null) {
      bytesCount += 3 +
          IsarVector3Schema.estimateSize(
              value, allOffsets[IsarVector3]!, allOffsets);
    }
  }
  {
    final value = object.rotation;
    if (value != null) {
      bytesCount += 3 +
          IsarVector3Schema.estimateSize(
              value, allOffsets[IsarVector3]!, allOffsets);
    }
  }
  return bytesCount;
}

void _catalogedCoordinateSerialize(
  CatalogedCoordinate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcodeUID);
  writer.writeObject<IsarVector3>(
    offsets[1],
    allOffsets,
    IsarVector3Schema.serialize,
    object.coordinate,
  );
  writer.writeLong(offsets[2], object.gridUID);
  writer.writeObject<IsarVector3>(
    offsets[3],
    allOffsets,
    IsarVector3Schema.serialize,
    object.rotation,
  );
  writer.writeLong(offsets[4], object.timestamp);
}

CatalogedCoordinate _catalogedCoordinateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatalogedCoordinate();
  object.barcodeUID = reader.readString(offsets[0]);
  object.coordinate = reader.readObjectOrNull<IsarVector3>(
    offsets[1],
    IsarVector3Schema.deserialize,
    allOffsets,
  );
  object.gridUID = reader.readLong(offsets[2]);
  object.id = id;
  object.rotation = reader.readObjectOrNull<IsarVector3>(
    offsets[3],
    IsarVector3Schema.deserialize,
    allOffsets,
  );
  object.timestamp = reader.readLong(offsets[4]);
  return object;
}

P _catalogedCoordinateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<IsarVector3>(
        offset,
        IsarVector3Schema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<IsarVector3>(
        offset,
        IsarVector3Schema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _catalogedCoordinateGetId(CatalogedCoordinate object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _catalogedCoordinateGetLinks(
    CatalogedCoordinate object) {
  return [];
}

void _catalogedCoordinateAttach(
    IsarCollection<dynamic> col, Id id, CatalogedCoordinate object) {
  object.id = id;
}

extension CatalogedCoordinateQueryWhereSort
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QWhere> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CatalogedCoordinateQueryWhere
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QWhereClause> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CatalogedCoordinateQueryFilter on QueryBuilder<CatalogedCoordinate,
    CatalogedCoordinate, QFilterCondition> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcodeUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcodeUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      barcodeUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'coordinate',
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'coordinate',
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gridUID',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gridUID',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gridUID',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      gridUIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gridUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rotation',
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rotation',
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      timestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      timestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      timestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CatalogedCoordinateQueryObject on QueryBuilder<CatalogedCoordinate,
    CatalogedCoordinate, QFilterCondition> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      coordinate(FilterQuery<IsarVector3> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'coordinate');
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterFilterCondition>
      rotation(FilterQuery<IsarVector3> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rotation');
    });
  }
}

extension CatalogedCoordinateQueryLinks on QueryBuilder<CatalogedCoordinate,
    CatalogedCoordinate, QFilterCondition> {}

extension CatalogedCoordinateQuerySortBy
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QSortBy> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByGridUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByGridUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension CatalogedCoordinateQuerySortThenBy
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QSortThenBy> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByGridUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByGridUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gridUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension CatalogedCoordinateQueryWhereDistinct
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct> {
  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcodeUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctByGridUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gridUID');
    });
  }

  QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension CatalogedCoordinateQueryProperty
    on QueryBuilder<CatalogedCoordinate, CatalogedCoordinate, QQueryProperty> {
  QueryBuilder<CatalogedCoordinate, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatalogedCoordinate, String, QQueryOperations>
      barcodeUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcodeUID');
    });
  }

  QueryBuilder<CatalogedCoordinate, IsarVector3?, QQueryOperations>
      coordinateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'coordinate');
    });
  }

  QueryBuilder<CatalogedCoordinate, int, QQueryOperations> gridUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gridUID');
    });
  }

  QueryBuilder<CatalogedCoordinate, IsarVector3?, QQueryOperations>
      rotationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rotation');
    });
  }

  QueryBuilder<CatalogedCoordinate, int, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarVector3Schema = Schema(
  name: r'IsarVector3',
  id: 8176198168186521457,
  properties: {
    r'x': PropertySchema(
      id: 0,
      name: r'x',
      type: IsarType.double,
    ),
    r'y': PropertySchema(
      id: 1,
      name: r'y',
      type: IsarType.double,
    ),
    r'z': PropertySchema(
      id: 2,
      name: r'z',
      type: IsarType.double,
    )
  },
  estimateSize: _isarVector3EstimateSize,
  serialize: _isarVector3Serialize,
  deserialize: _isarVector3Deserialize,
  deserializeProp: _isarVector3DeserializeProp,
);

int _isarVector3EstimateSize(
  IsarVector3 object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarVector3Serialize(
  IsarVector3 object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.x);
  writer.writeDouble(offsets[1], object.y);
  writer.writeDouble(offsets[2], object.z);
}

IsarVector3 _isarVector3Deserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarVector3(
    x: reader.readDoubleOrNull(offsets[0]),
    y: reader.readDoubleOrNull(offsets[1]),
    z: reader.readDoubleOrNull(offsets[2]),
  );
  return object;
}

P _isarVector3DeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarVector3QueryFilter
    on QueryBuilder<IsarVector3, IsarVector3, QFilterCondition> {
  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> xIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'x',
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> xIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'x',
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> xEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> xGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> xLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'x',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> xBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'x',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> yIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> yIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'y',
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> yEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> yGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> yLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'y',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> yBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'y',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> zIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'z',
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> zIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'z',
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> zEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'z',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> zGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'z',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> zLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'z',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarVector3, IsarVector3, QAfterFilterCondition> zBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'z',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension IsarVector3QueryObject
    on QueryBuilder<IsarVector3, IsarVector3, QFilterCondition> {}
