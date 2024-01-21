// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cataloged_grid.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCatalogedGridCollection on Isar {
  IsarCollection<CatalogedGrid> get catalogedGrids => this.collection();
}

const CatalogedGridSchema = CollectionSchema(
  name: r'CatalogedGrid',
  id: -756167892298026989,
  properties: {
    r'barcodeUID': PropertySchema(
      id: 0,
      name: r'barcodeUID',
      type: IsarType.string,
    ),
    r'parentBarcodeUID': PropertySchema(
      id: 1,
      name: r'parentBarcodeUID',
      type: IsarType.string,
    )
  },
  estimateSize: _catalogedGridEstimateSize,
  serialize: _catalogedGridSerialize,
  deserialize: _catalogedGridDeserialize,
  deserializeProp: _catalogedGridDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _catalogedGridGetId,
  getLinks: _catalogedGridGetLinks,
  attach: _catalogedGridAttach,
  version: '3.1.0+1',
);

int _catalogedGridEstimateSize(
  CatalogedGrid object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.barcodeUID.length * 3;
  {
    final value = object.parentBarcodeUID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _catalogedGridSerialize(
  CatalogedGrid object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcodeUID);
  writer.writeString(offsets[1], object.parentBarcodeUID);
}

CatalogedGrid _catalogedGridDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatalogedGrid();
  object.barcodeUID = reader.readString(offsets[0]);
  object.id = id;
  object.parentBarcodeUID = reader.readStringOrNull(offsets[1]);
  return object;
}

P _catalogedGridDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _catalogedGridGetId(CatalogedGrid object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _catalogedGridGetLinks(CatalogedGrid object) {
  return [];
}

void _catalogedGridAttach(
    IsarCollection<dynamic> col, Id id, CatalogedGrid object) {
  object.id = id;
}

extension CatalogedGridQueryWhereSort
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QWhere> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CatalogedGridQueryWhere
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QWhereClause> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterWhereClause> idBetween(
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

extension CatalogedGridQueryFilter
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QFilterCondition> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcodeUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      barcodeUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      barcodeUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentBarcodeUID',
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentBarcodeUID',
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentBarcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentBarcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentBarcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentBarcodeUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentBarcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentBarcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentBarcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentBarcodeUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentBarcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterFilterCondition>
      parentBarcodeUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentBarcodeUID',
        value: '',
      ));
    });
  }
}

extension CatalogedGridQueryObject
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QFilterCondition> {}

extension CatalogedGridQueryLinks
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QFilterCondition> {}

extension CatalogedGridQuerySortBy
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QSortBy> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> sortByBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      sortByParentBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentBarcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      sortByParentBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentBarcodeUID', Sort.desc);
    });
  }
}

extension CatalogedGridQuerySortThenBy
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QSortThenBy> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> thenByBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      thenByParentBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentBarcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QAfterSortBy>
      thenByParentBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentBarcodeUID', Sort.desc);
    });
  }
}

extension CatalogedGridQueryWhereDistinct
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct> {
  QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct> distinctByBarcodeUID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcodeUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedGrid, CatalogedGrid, QDistinct>
      distinctByParentBarcodeUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentBarcodeUID',
          caseSensitive: caseSensitive);
    });
  }
}

extension CatalogedGridQueryProperty
    on QueryBuilder<CatalogedGrid, CatalogedGrid, QQueryProperty> {
  QueryBuilder<CatalogedGrid, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatalogedGrid, String, QQueryOperations> barcodeUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcodeUID');
    });
  }

  QueryBuilder<CatalogedGrid, String?, QQueryOperations>
      parentBarcodeUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentBarcodeUID');
    });
  }
}
