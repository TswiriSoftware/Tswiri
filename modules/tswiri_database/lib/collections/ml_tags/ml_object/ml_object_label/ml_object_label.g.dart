// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_object_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLObjectLabelCollection on Isar {
  IsarCollection<MLObjectLabel> get mLObjectLabels => this.collection();
}

const MLObjectLabelSchema = CollectionSchema(
  name: r'MLObjectLabel',
  id: -5843152430039701143,
  properties: {
    r'confidence': PropertySchema(
      id: 0,
      name: r'confidence',
      type: IsarType.double,
    ),
    r'detectedLabelTextID': PropertySchema(
      id: 1,
      name: r'detectedLabelTextID',
      type: IsarType.long,
    ),
    r'hashCode': PropertySchema(
      id: 2,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'objectID': PropertySchema(
      id: 3,
      name: r'objectID',
      type: IsarType.long,
    ),
    r'userFeedback': PropertySchema(
      id: 4,
      name: r'userFeedback',
      type: IsarType.bool,
    )
  },
  estimateSize: _mLObjectLabelEstimateSize,
  serialize: _mLObjectLabelSerialize,
  deserialize: _mLObjectLabelDeserialize,
  deserializeProp: _mLObjectLabelDeserializeProp,
  idName: r'id',
  indexes: {
    r'detectedLabelTextID': IndexSchema(
      id: 8682492204343278483,
      name: r'detectedLabelTextID',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'detectedLabelTextID',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _mLObjectLabelGetId,
  getLinks: _mLObjectLabelGetLinks,
  attach: _mLObjectLabelAttach,
  version: '3.1.0+1',
);

int _mLObjectLabelEstimateSize(
  MLObjectLabel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _mLObjectLabelSerialize(
  MLObjectLabel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.confidence);
  writer.writeLong(offsets[1], object.detectedLabelTextID);
  writer.writeLong(offsets[2], object.hashCode);
  writer.writeLong(offsets[3], object.objectID);
  writer.writeBool(offsets[4], object.userFeedback);
}

MLObjectLabel _mLObjectLabelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLObjectLabel();
  object.confidence = reader.readDouble(offsets[0]);
  object.detectedLabelTextID = reader.readLong(offsets[1]);
  object.id = id;
  object.objectID = reader.readLong(offsets[3]);
  object.userFeedback = reader.readBoolOrNull(offsets[4]);
  return object;
}

P _mLObjectLabelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLObjectLabelGetId(MLObjectLabel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLObjectLabelGetLinks(MLObjectLabel object) {
  return [];
}

void _mLObjectLabelAttach(
    IsarCollection<dynamic> col, Id id, MLObjectLabel object) {
  object.id = id;
}

extension MLObjectLabelQueryWhereSort
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QWhere> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhere>
      anyDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'detectedLabelTextID'),
      );
    });
  }
}

extension MLObjectLabelQueryWhere
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QWhereClause> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDEqualTo(int detectedLabelTextID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'detectedLabelTextID',
        value: [detectedLabelTextID],
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDNotEqualTo(int detectedLabelTextID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID',
              lower: [],
              upper: [detectedLabelTextID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID',
              lower: [detectedLabelTextID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID',
              lower: [detectedLabelTextID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID',
              lower: [],
              upper: [detectedLabelTextID],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDGreaterThan(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID',
        lower: [detectedLabelTextID],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDLessThan(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID',
        lower: [],
        upper: [detectedLabelTextID],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterWhereClause>
      detectedLabelTextIDBetween(
    int lowerDetectedLabelTextID,
    int upperDetectedLabelTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID',
        lower: [lowerDetectedLabelTextID],
        includeLower: includeLower,
        upper: [upperDetectedLabelTextID],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MLObjectLabelQueryFilter
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QFilterCondition> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      confidenceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedLabelTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'detectedLabelTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'detectedLabelTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      detectedLabelTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'detectedLabelTextID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      objectIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'objectID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      objectIDBetween(
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

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      userFeedbackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userFeedback',
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      userFeedbackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userFeedback',
      ));
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterFilterCondition>
      userFeedbackEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userFeedback',
        value: value,
      ));
    });
  }
}

extension MLObjectLabelQueryObject
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QFilterCondition> {}

extension MLObjectLabelQueryLinks
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QFilterCondition> {}

extension MLObjectLabelQuerySortBy
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QSortBy> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByDetectedLabelTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> sortByObjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByObjectIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      sortByUserFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.desc);
    });
  }
}

extension MLObjectLabelQuerySortThenBy
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QSortThenBy> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByDetectedLabelTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy> thenByObjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByObjectIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'objectID', Sort.desc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.asc);
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QAfterSortBy>
      thenByUserFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.desc);
    });
  }
}

extension MLObjectLabelQueryWhereDistinct
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> {
  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidence');
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct>
      distinctByDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detectedLabelTextID');
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct> distinctByObjectID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'objectID');
    });
  }

  QueryBuilder<MLObjectLabel, MLObjectLabel, QDistinct>
      distinctByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userFeedback');
    });
  }
}

extension MLObjectLabelQueryProperty
    on QueryBuilder<MLObjectLabel, MLObjectLabel, QQueryProperty> {
  QueryBuilder<MLObjectLabel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLObjectLabel, double, QQueryOperations> confidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidence');
    });
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations>
      detectedLabelTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detectedLabelTextID');
    });
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<MLObjectLabel, int, QQueryOperations> objectIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'objectID');
    });
  }

  QueryBuilder<MLObjectLabel, bool?, QQueryOperations> userFeedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userFeedback');
    });
  }
}
