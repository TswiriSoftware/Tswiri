// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPhotoLabelCollection on Isar {
  IsarCollection<PhotoLabel> get photoLabels => this.collection();
}

const PhotoLabelSchema = CollectionSchema(
  name: r'PhotoLabel',
  id: 2362795667242640436,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'photoID': PropertySchema(
      id: 1,
      name: r'photoID',
      type: IsarType.long,
    ),
    r'tagTextID': PropertySchema(
      id: 2,
      name: r'tagTextID',
      type: IsarType.long,
    )
  },
  estimateSize: _photoLabelEstimateSize,
  serialize: _photoLabelSerialize,
  deserialize: _photoLabelDeserialize,
  deserializeProp: _photoLabelDeserializeProp,
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
  getId: _photoLabelGetId,
  getLinks: _photoLabelGetLinks,
  attach: _photoLabelAttach,
  version: '3.1.0+1',
);

int _photoLabelEstimateSize(
  PhotoLabel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _photoLabelSerialize(
  PhotoLabel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeLong(offsets[1], object.photoID);
  writer.writeLong(offsets[2], object.tagTextID);
}

PhotoLabel _photoLabelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PhotoLabel();
  object.id = id;
  object.photoID = reader.readLong(offsets[1]);
  object.tagTextID = reader.readLong(offsets[2]);
  return object;
}

P _photoLabelDeserializeProp<P>(
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

Id _photoLabelGetId(PhotoLabel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _photoLabelGetLinks(PhotoLabel object) {
  return [];
}

void _photoLabelAttach(IsarCollection<dynamic> col, Id id, PhotoLabel object) {
  object.id = id;
}

extension PhotoLabelQueryWhereSort
    on QueryBuilder<PhotoLabel, PhotoLabel, QWhere> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhere> anyTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tagTextID'),
      );
    });
  }
}

extension PhotoLabelQueryWhere
    on QueryBuilder<PhotoLabel, PhotoLabel, QWhereClause> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDEqualTo(
      int tagTextID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tagTextID',
        value: [tagTextID],
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDNotEqualTo(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDGreaterThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDLessThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDBetween(
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

extension PhotoLabelQueryFilter
    on QueryBuilder<PhotoLabel, PhotoLabel, QFilterCondition> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> photoIDEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition>
      photoIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> photoIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> photoIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> tagTextIDEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> tagTextIDLessThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> tagTextIDBetween(
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

extension PhotoLabelQueryObject
    on QueryBuilder<PhotoLabel, PhotoLabel, QFilterCondition> {}

extension PhotoLabelQueryLinks
    on QueryBuilder<PhotoLabel, PhotoLabel, QFilterCondition> {}

extension PhotoLabelQuerySortBy
    on QueryBuilder<PhotoLabel, PhotoLabel, QSortBy> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension PhotoLabelQuerySortThenBy
    on QueryBuilder<PhotoLabel, PhotoLabel, QSortThenBy> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension PhotoLabelQueryWhereDistinct
    on QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> {
  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoID');
    });
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagTextID');
    });
  }
}

extension PhotoLabelQueryProperty
    on QueryBuilder<PhotoLabel, PhotoLabel, QQueryProperty> {
  QueryBuilder<PhotoLabel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PhotoLabel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<PhotoLabel, int, QQueryOperations> photoIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoID');
    });
  }

  QueryBuilder<PhotoLabel, int, QQueryOperations> tagTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagTextID');
    });
  }
}
