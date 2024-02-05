// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cataloged_barcode.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCatalogedBarcodeCollection on Isar {
  IsarCollection<CatalogedBarcode> get catalogedBarcodes => this.collection();
}

const CatalogedBarcodeSchema = CollectionSchema(
  name: r'CatalogedBarcode',
  id: -555717939732620677,
  properties: {
    r'barcodeUUID': PropertySchema(
      id: 0,
      name: r'barcodeUUID',
      type: IsarType.string,
    ),
    r'batchUUID': PropertySchema(
      id: 1,
      name: r'batchUUID',
      type: IsarType.string,
    ),
    r'diagonalSideLength': PropertySchema(
      id: 2,
      name: r'diagonalSideLength',
      type: IsarType.double,
    ),
    r'hashCode': PropertySchema(
      id: 3,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'height': PropertySchema(
      id: 4,
      name: r'height',
      type: IsarType.double,
    ),
    r'width': PropertySchema(
      id: 5,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _catalogedBarcodeEstimateSize,
  serialize: _catalogedBarcodeSerialize,
  deserialize: _catalogedBarcodeDeserialize,
  deserializeProp: _catalogedBarcodeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _catalogedBarcodeGetId,
  getLinks: _catalogedBarcodeGetLinks,
  attach: _catalogedBarcodeAttach,
  version: '3.1.0+1',
);

int _catalogedBarcodeEstimateSize(
  CatalogedBarcode object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.barcodeUUID.length * 3;
  bytesCount += 3 + object.batchUUID.length * 3;
  return bytesCount;
}

void _catalogedBarcodeSerialize(
  CatalogedBarcode object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcodeUUID);
  writer.writeString(offsets[1], object.batchUUID);
  writer.writeDouble(offsets[2], object.diagonalSideLength);
  writer.writeLong(offsets[3], object.hashCode);
  writer.writeDouble(offsets[4], object.height);
  writer.writeDouble(offsets[5], object.width);
}

CatalogedBarcode _catalogedBarcodeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatalogedBarcode();
  object.barcodeUUID = reader.readString(offsets[0]);
  object.batchUUID = reader.readString(offsets[1]);
  object.height = reader.readDouble(offsets[4]);
  object.id = id;
  object.width = reader.readDouble(offsets[5]);
  return object;
}

P _catalogedBarcodeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _catalogedBarcodeGetId(CatalogedBarcode object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _catalogedBarcodeGetLinks(CatalogedBarcode object) {
  return [];
}

void _catalogedBarcodeAttach(
    IsarCollection<dynamic> col, Id id, CatalogedBarcode object) {
  object.id = id;
}

extension CatalogedBarcodeQueryWhereSort
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QWhere> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CatalogedBarcodeQueryWhere
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QWhereClause> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterWhereClause> idBetween(
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

extension CatalogedBarcodeQueryFilter
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QFilterCondition> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcodeUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcodeUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      barcodeUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcodeUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batchUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'batchUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'batchUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'batchUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'batchUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'batchUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'batchUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'batchUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batchUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      batchUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'batchUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      diagonalSideLengthEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagonalSideLength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      diagonalSideLengthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagonalSideLength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      diagonalSideLengthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagonalSideLength',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      diagonalSideLengthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagonalSideLength',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      heightEqualTo(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      heightBetween(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      widthEqualTo(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      widthLessThan(
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

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterFilterCondition>
      widthBetween(
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

extension CatalogedBarcodeQueryObject
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QFilterCondition> {}

extension CatalogedBarcodeQueryLinks
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QFilterCondition> {}

extension CatalogedBarcodeQuerySortBy
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QSortBy> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByBarcodeUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByBarcodeUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByBatchUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByBatchUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByDiagonalSideLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSideLength', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByDiagonalSideLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSideLength', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> sortByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      sortByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension CatalogedBarcodeQuerySortThenBy
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QSortThenBy> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByBarcodeUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByBarcodeUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByBatchUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByBatchUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByDiagonalSideLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSideLength', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByDiagonalSideLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSideLength', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy> thenByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QAfterSortBy>
      thenByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension CatalogedBarcodeQueryWhereDistinct
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct> {
  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByBarcodeUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcodeUUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByBatchUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'batchUUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByDiagonalSideLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagonalSideLength');
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<CatalogedBarcode, CatalogedBarcode, QDistinct>
      distinctByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'width');
    });
  }
}

extension CatalogedBarcodeQueryProperty
    on QueryBuilder<CatalogedBarcode, CatalogedBarcode, QQueryProperty> {
  QueryBuilder<CatalogedBarcode, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatalogedBarcode, String, QQueryOperations>
      barcodeUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcodeUUID');
    });
  }

  QueryBuilder<CatalogedBarcode, String, QQueryOperations> batchUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'batchUUID');
    });
  }

  QueryBuilder<CatalogedBarcode, double, QQueryOperations>
      diagonalSideLengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagonalSideLength');
    });
  }

  QueryBuilder<CatalogedBarcode, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<CatalogedBarcode, double, QQueryOperations> heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<CatalogedBarcode, double, QQueryOperations> widthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'width');
    });
  }
}
