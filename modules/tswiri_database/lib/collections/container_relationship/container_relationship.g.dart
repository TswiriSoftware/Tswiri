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
    r'containerUUID': PropertySchema(
      id: 0,
      name: r'containerUUID',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'parentContainerUUID': PropertySchema(
      id: 2,
      name: r'parentContainerUUID',
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
  bytesCount += 3 + object.containerUUID.length * 3;
  bytesCount += 3 + object.parentContainerUUID.length * 3;
  return bytesCount;
}

void _containerRelationshipSerialize(
  ContainerRelationship object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.containerUUID);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeString(offsets[2], object.parentContainerUUID);
}

ContainerRelationship _containerRelationshipDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContainerRelationship();
  object.containerUUID = reader.readString(offsets[0]);
  object.id = id;
  object.parentContainerUUID = reader.readString(offsets[2]);
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
      return (reader.readString(offset)) as P;
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
      QAfterFilterCondition> containerUUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'containerUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      containerUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      containerUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> containerUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerUUID',
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
      QAfterFilterCondition> parentContainerUUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentContainerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentContainerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentContainerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentContainerUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentContainerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentContainerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      parentContainerUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentContainerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
          QAfterFilterCondition>
      parentContainerUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentContainerUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentContainerUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship,
      QAfterFilterCondition> parentContainerUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentContainerUUID',
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
      sortByContainerUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByContainerUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.desc);
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
      sortByParentContainerUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentContainerUUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      sortByParentContainerUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentContainerUUID', Sort.desc);
    });
  }
}

extension ContainerRelationshipQuerySortThenBy
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QSortThenBy> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByContainerUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByContainerUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.desc);
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
      thenByParentContainerUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentContainerUUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QAfterSortBy>
      thenByParentContainerUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentContainerUUID', Sort.desc);
    });
  }
}

extension ContainerRelationshipQueryWhereDistinct
    on QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct> {
  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByContainerUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerUUID',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<ContainerRelationship, ContainerRelationship, QDistinct>
      distinctByParentContainerUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentContainerUUID',
          caseSensitive: caseSensitive);
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
      containerUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerUUID');
    });
  }

  QueryBuilder<ContainerRelationship, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<ContainerRelationship, String, QQueryOperations>
      parentContainerUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentContainerUUID');
    });
  }
}
