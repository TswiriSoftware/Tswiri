// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_batch.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBarcodeBatchCollection on Isar {
  IsarCollection<BarcodeBatch> get barcodeBatchs => this.collection();
}

const BarcodeBatchSchema = CollectionSchema(
  name: r'BarcodeBatch',
  id: 3512858331771163168,
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'imported': PropertySchema(
      id: 1,
      name: r'imported',
      type: IsarType.bool,
    ),
    r'rangeEnd': PropertySchema(
      id: 2,
      name: r'rangeEnd',
      type: IsarType.long,
    ),
    r'rangeStart': PropertySchema(
      id: 3,
      name: r'rangeStart',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 4,
      name: r'timestamp',
      type: IsarType.long,
    ),
    r'width': PropertySchema(
      id: 5,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _barcodeBatchEstimateSize,
  serialize: _barcodeBatchSerialize,
  deserialize: _barcodeBatchDeserialize,
  deserializeProp: _barcodeBatchDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _barcodeBatchGetId,
  getLinks: _barcodeBatchGetLinks,
  attach: _barcodeBatchAttach,
  version: '3.1.0+1',
);

int _barcodeBatchEstimateSize(
  BarcodeBatch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _barcodeBatchSerialize(
  BarcodeBatch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeBool(offsets[1], object.imported);
  writer.writeLong(offsets[2], object.rangeEnd);
  writer.writeLong(offsets[3], object.rangeStart);
  writer.writeLong(offsets[4], object.timestamp);
  writer.writeDouble(offsets[5], object.width);
}

BarcodeBatch _barcodeBatchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BarcodeBatch();
  object.height = reader.readDouble(offsets[0]);
  object.id = id;
  object.imported = reader.readBool(offsets[1]);
  object.rangeEnd = reader.readLong(offsets[2]);
  object.rangeStart = reader.readLong(offsets[3]);
  object.timestamp = reader.readLong(offsets[4]);
  object.width = reader.readDouble(offsets[5]);
  return object;
}

P _barcodeBatchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _barcodeBatchGetId(BarcodeBatch object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _barcodeBatchGetLinks(BarcodeBatch object) {
  return [];
}

void _barcodeBatchAttach(
    IsarCollection<dynamic> col, Id id, BarcodeBatch object) {
  object.id = id;
}

extension BarcodeBatchQueryWhereSort
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QWhere> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BarcodeBatchQueryWhere
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QWhereClause> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterWhereClause> idBetween(
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

extension BarcodeBatchQueryFilter
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QFilterCondition> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> heightEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      heightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      heightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> heightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      importedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imported',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangeEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rangeEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rangeEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeEndBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rangeEnd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rangeStart',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rangeStart',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rangeStart',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      rangeStartBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rangeStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
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

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> widthEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition>
      widthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> widthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterFilterCondition> widthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension BarcodeBatchQueryObject
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QFilterCondition> {}

extension BarcodeBatchQueryLinks
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QFilterCondition> {}

extension BarcodeBatchQuerySortBy
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QSortBy> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByImportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByRangeEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeEnd', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByRangeEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeEnd', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByRangeStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeStart', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy>
      sortByRangeStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeStart', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> sortByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension BarcodeBatchQuerySortThenBy
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QSortThenBy> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByImportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imported', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByRangeEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeEnd', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByRangeEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeEnd', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByRangeStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeStart', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy>
      thenByRangeStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rangeStart', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QAfterSortBy> thenByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension BarcodeBatchQueryWhereDistinct
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> {
  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByImported() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imported');
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByRangeEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rangeEnd');
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByRangeStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rangeStart');
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<BarcodeBatch, BarcodeBatch, QDistinct> distinctByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'width');
    });
  }
}

extension BarcodeBatchQueryProperty
    on QueryBuilder<BarcodeBatch, BarcodeBatch, QQueryProperty> {
  QueryBuilder<BarcodeBatch, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BarcodeBatch, double, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<BarcodeBatch, bool, QQueryOperations> importedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imported');
    });
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> rangeEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rangeEnd');
    });
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> rangeStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rangeStart');
    });
  }

  QueryBuilder<BarcodeBatch, int, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<BarcodeBatch, double, QQueryOperations> widthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'width');
    });
  }
}
