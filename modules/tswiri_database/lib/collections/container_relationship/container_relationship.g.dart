// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_relationship.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContainerRelationshipCollection on Isar {
  IsarCollection<ContainerRelationship> get containerRelationships =>
      this.collection();
}

const ContainerRelationshipSchema = CollectionSchema(
  name: r'ContainerRelationship',
  id: -9067618888235341338,
  properties: {
    r'containerUID': PropertySchema(
      id: 0,
      name: r'containerUID',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'parentUID': PropertySchema(
      id: 2,
      name: r'parentUID',
      type: IsarType.string,
    )
  },
  estimateSize: _containerRelationshipEstimateSize,
  serialize: _containerRelationshipSerialize,
  deserialize: _containerRelationshipDeserialize,
  deserializeProp: _containerRelationshipDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _containerRelationshipGetId,
  getLinks: _containerRelationshipGetLinks,
  attach: _containerRelationshipAttach,
  version: '3.1.0+1',
);

int _containerRelationshipEstimateSize(
  ContainerRelationship object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.containerUID.length * 3;
  {
    final value = object.parentUID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _containerRelationshipSerialize(
  ContainerRelationship object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.containerUID);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.parentUID);
}

ContainerRelationship _containerRelationshipDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContainerRelationship();
  object.containerUID = reader.readString(offsets[0]);
  object.id = id;
  object.parentUID = reader.readStringOrNull(offsets[2]);
  return object;
}

P _containerRelationshipDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _containerRelationshipGetId(ContainerRelationship object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _containerRelationshipGetLinks(
    ContainerRelationship object) {
  return [];
}

void _containerRelationshipAttach(
    IsarCollection<dynamic> col, Id id, ContainerRelationship object) {
  object.id = id;
}

extension ContainerRelationshipQueryWhereSort
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QWhere> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContainerRelationshipQueryWhere on QueryBuilder<ContainerRelationship,
    ContainerRelationship, QWhereClause> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
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

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterWhereClause>
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

extension ContainerRelationshipQueryFilter on QueryBuilder<
    ContainerRelationship, ContainerRelationship, QFilterCondition> {
  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'containerUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'parentUID',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'parentUID',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      parentUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      parentUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentUID',
        value: '',
      ));
    });
  }
}

extension ContainerRelationshipQueryObject on QueryBuilder<
    ContainerRelationship, ContainerRelationship, QFilterCondition> {}

extension ContainerRelationshipQueryLinks on QueryBuilder<ContainerRelationship,
    ContainerRelationship, QFilterCondition> {}

extension ContainerRelationshipQuerySortBy
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QSortBy> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByParentUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByParentUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentUID', Sort.desc);
    });
  }
}

extension ContainerRelationshipQuerySortThenBy
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QSortThenBy> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByParentUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByParentUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentUID', Sort.desc);
    });
  }
}

extension ContainerRelationshipQueryWhereDistinct
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByContainerUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByParentUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentUID', caseSensitive: caseSensitive);
    });
  }
}

extension ContainerRelationshipQueryProperty on QueryBuilder<
    ContainerRelationship, ContainerRelationship, QQueryProperty> {
  QueryBuilder<ContainerRelationship, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ContainerRelationship, String, QQueryOperations>
      containerUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerUID');
    });
  }

  QueryBuilder<ContainerRelationship, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<ContainerRelationship, String?, QQueryOperations>
      parentUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentUID');
    });
  }
}
