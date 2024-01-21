// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetObjectLabelCollection on Isar {
  IsarCollection<ObjectLabel> get objectLabels => this.collection();
}

const ObjectLabelSchema = CollectionSchema(
  name: r'ObjectLabel',
  id: 527779606956548866,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'objectID': PropertySchema(
      id: 1,
      name: r'objectID',
      type: IsarType.long,
    ),
    r'tagTextID': PropertySchema(
      id: 2,
      name: r'tagTextID',
      type: IsarType.long,
    )
  },
  estimateSize: _objectLabelEstimateSize,
  serialize: _objectLabelSerialize,
  deserialize: _objectLabelDeserialize,
  deserializeProp: _objectLabelDeserializeProp,
  idName: r'id',
  indexes: {
    r'tagTextID': IndexSchema(
      id: -5214036049182336314,
      name: r'tagTextID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tagTextID',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _objectLabelGetId,
  getLinks: _objectLabelGetLinks,
  attach: _objectLabelAttach,
  version: '3.1.0+1',
);

int _objectLabelEstimateSize(
  ObjectLabel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _objectLabelSerialize(
  ObjectLabel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeLong(offsets[1], object.objectID);
  writer.writeLong(offsets[2], object.tagTextID);
}

ObjectLabel _objectLabelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ObjectLabel();
  object.id = id;
  object.objectID = reader.readLong(offsets[1]);
  object.tagTextID = reader.readLong(offsets[2]);
  return object;
}

P _objectLabelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _objectLabelGetId(ObjectLabel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _objectLabelGetLinks(ObjectLabel object) {
  return [];
}

void _objectLabelAttach(
    IsarCollection<dynamic> col, Id id, ObjectLabel object) {
  object.id = id;
}

extension ObjectLabelQueryWhereSort
    on QueryBuilder<ObjectLabel, ObjectLabel, QWhere> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhere> anyTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tagTextID'),
      );
    });
  }
}

extension ObjectLabelQueryWhere
    on QueryBuilder<ObjectLabel, ObjectLabel, QWhereClause> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDEqualTo(
      int tagTextID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tagTextID',
        value: [tagTextID],
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDNotEqualTo(
      int tagTextID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagTextID',
              lower: [],
              upper: [tagTextID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagTextID',
              lower: [tagTextID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagTextID',
              lower: [tagTextID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagTextID',
              lower: [],
              upper: [tagTextID],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause>
      tagTextIDGreaterThan(
    int tagTextID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagTextID',
        lower: [tagTextID],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDLessThan(
    int tagTextID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagTextID',
        lower: [],
        upper: [tagTextID],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterWhereClause> tagTextIDBetween(
    int lowerTagTextID,
    int upperTagTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagTextID',
        lower: [lowerTagTextID],
        includeLower: includeLower,
        upper: [upperTagTextID],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ObjectLabelQueryFilter
    on QueryBuilder<ObjectLabel, ObjectLabel, QFilterCondition> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> objectIDEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objectID',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
      objectIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'objectID',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
      objectIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'objectID',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition> objectIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'objectID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
      tagTextIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterFilterCondition>
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

extension ObjectLabelQueryObject
    on QueryBuilder<ObjectLabel, ObjectLabel, QFilterCondition> {}

extension ObjectLabelQueryLinks
    on QueryBuilder<ObjectLabel, ObjectLabel, QFilterCondition> {}

extension ObjectLabelQuerySortBy
    on QueryBuilder<ObjectLabel, ObjectLabel, QSortBy> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByObjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByObjectIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.desc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> sortByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension ObjectLabelQuerySortThenBy
    on QueryBuilder<ObjectLabel, ObjectLabel, QSortThenBy> {
  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByObjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByObjectIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.desc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QAfterSortBy> thenByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension ObjectLabelQueryWhereDistinct
    on QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> {
  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctByObjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objectID');
    });
  }

  QueryBuilder<ObjectLabel, ObjectLabel, QDistinct> distinctByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagTextID');
    });
  }
}

extension ObjectLabelQueryProperty
    on QueryBuilder<ObjectLabel, ObjectLabel, QQueryProperty> {
  QueryBuilder<ObjectLabel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ObjectLabel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<ObjectLabel, int, QQueryOperations> objectIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objectID');
    });
  }

  QueryBuilder<ObjectLabel, int, QQueryOperations> tagTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagTextID');
    });
  }
}
