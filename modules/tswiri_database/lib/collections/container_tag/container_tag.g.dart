// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetContainerTagCollection on Isar {
  IsarCollection<ContainerTag> get containerTags => this.collection();
}

const ContainerTagSchema = CollectionSchema(
  name: r'ContainerTag',
  id: -8994218866912996082,
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
    r'tagTextID': PropertySchema(
      id: 2,
      name: r'tagTextID',
      type: IsarType.long,
    )
  },
  estimateSize: _containerTagEstimateSize,
  serialize: _containerTagSerialize,
  deserialize: _containerTagDeserialize,
  deserializeProp: _containerTagDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _containerTagGetId,
  getLinks: _containerTagGetLinks,
  attach: _containerTagAttach,
  version: '3.1.0+1',
);

int _containerTagEstimateSize(
  ContainerTag object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.containerUID.length * 3;
  return bytesCount;
}

void _containerTagSerialize(
  ContainerTag object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.containerUID);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeLong(offsets[2], object.tagTextID);
}

ContainerTag _containerTagDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ContainerTag();
  object.containerUID = reader.readString(offsets[0]);
  object.id = id;
  object.tagTextID = reader.readLong(offsets[2]);
  return object;
}

P _containerTagDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _containerTagGetId(ContainerTag object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _containerTagGetLinks(ContainerTag object) {
  return [];
}

void _containerTagAttach(
    IsarCollection<dynamic> col, Id id, ContainerTag object) {
  object.id = id;
}

extension ContainerTagQueryWhereSort
    on QueryBuilder<ContainerTag, ContainerTag, QWhere> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ContainerTagQueryWhere
    on QueryBuilder<ContainerTag, ContainerTag, QWhereClause> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterWhereClause> idBetween(
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

extension ContainerTagQueryFilter
    on QueryBuilder<ContainerTag, ContainerTag, QFilterCondition> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDEqualTo(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDGreaterThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDLessThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDBetween(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDStartsWith(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDEndsWith(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      containerUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterFilterCondition>
      tagTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagTextID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ContainerTagQueryObject
    on QueryBuilder<ContainerTag, ContainerTag, QFilterCondition> {}

extension ContainerTagQueryLinks
    on QueryBuilder<ContainerTag, ContainerTag, QFilterCondition> {}

extension ContainerTagQuerySortBy
    on QueryBuilder<ContainerTag, ContainerTag, QSortBy> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy>
      sortByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> sortByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension ContainerTagQuerySortThenBy
    on QueryBuilder<ContainerTag, ContainerTag, QSortThenBy> {
  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy>
      thenByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QAfterSortBy> thenByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension ContainerTagQueryWhereDistinct
    on QueryBuilder<ContainerTag, ContainerTag, QDistinct> {
  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByContainerUID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<ContainerTag, ContainerTag, QDistinct> distinctByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagTextID');
    });
  }
}

extension ContainerTagQueryProperty
    on QueryBuilder<ContainerTag, ContainerTag, QQueryProperty> {
  QueryBuilder<ContainerTag, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ContainerTag, String, QQueryOperations> containerUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerUID');
    });
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<ContainerTag, int, QQueryOperations> tagTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagTextID');
    });
  }
}
