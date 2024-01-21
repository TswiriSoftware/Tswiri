// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_photo_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLPhotoLabelCollection on Isar {
  IsarCollection<MLPhotoLabel> get mLPhotoLabels => this.collection();
}

const MLPhotoLabelSchema = CollectionSchema(
  name: r'MLPhotoLabel',
  id: 2792120286240114426,
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
    r'photoID': PropertySchema(
      id: 3,
      name: r'photoID',
      type: IsarType.long,
    ),
    r'userFeedback': PropertySchema(
      id: 4,
      name: r'userFeedback',
      type: IsarType.bool,
    )
  },
  estimateSize: _mLPhotoLabelEstimateSize,
  serialize: _mLPhotoLabelSerialize,
  deserialize: _mLPhotoLabelDeserialize,
  deserializeProp: _mLPhotoLabelDeserializeProp,
  idName: r'id',
  indexes: {
    r'detectedLabelTextID_userFeedback': IndexSchema(
      id: 8578679752870373633,
      name: r'detectedLabelTextID_userFeedback',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'detectedLabelTextID',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'userFeedback',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'userFeedback': IndexSchema(
      id: 3507649478022456025,
      name: r'userFeedback',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userFeedback',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _mLPhotoLabelGetId,
  getLinks: _mLPhotoLabelGetLinks,
  attach: _mLPhotoLabelAttach,
  version: '3.1.0+1',
);

int _mLPhotoLabelEstimateSize(
  MLPhotoLabel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _mLPhotoLabelSerialize(
  MLPhotoLabel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.confidence);
  writer.writeLong(offsets[1], object.detectedLabelTextID);
  writer.writeLong(offsets[2], object.hashCode);
  writer.writeLong(offsets[3], object.photoID);
  writer.writeBool(offsets[4], object.userFeedback);
}

MLPhotoLabel _mLPhotoLabelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLPhotoLabel();
  object.confidence = reader.readDouble(offsets[0]);
  object.detectedLabelTextID = reader.readLong(offsets[1]);
  object.id = id;
  object.photoID = reader.readLongOrNull(offsets[3]);
  object.userFeedback = reader.readBoolOrNull(offsets[4]);
  return object;
}

P _mLPhotoLabelDeserializeProp<P>(
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
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLPhotoLabelGetId(MLPhotoLabel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLPhotoLabelGetLinks(MLPhotoLabel object) {
  return [];
}

void _mLPhotoLabelAttach(
    IsarCollection<dynamic> col, Id id, MLPhotoLabel object) {
  object.id = id;
}

extension MLPhotoLabelQueryWhereSort
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QWhere> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhere>
      anyDetectedLabelTextIDUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(
            indexName: r'detectedLabelTextID_userFeedback'),
      );
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhere> anyUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userFeedback'),
      );
    });
  }
}

extension MLPhotoLabelQueryWhere
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QWhereClause> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDEqualToAnyUserFeedback(int detectedLabelTextID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'detectedLabelTextID_userFeedback',
        value: [detectedLabelTextID],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDNotEqualToAnyUserFeedback(int detectedLabelTextID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [],
              upper: [detectedLabelTextID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [detectedLabelTextID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [detectedLabelTextID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [],
              upper: [detectedLabelTextID],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDGreaterThanAnyUserFeedback(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID_userFeedback',
        lower: [detectedLabelTextID],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDLessThanAnyUserFeedback(
    int detectedLabelTextID, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID_userFeedback',
        lower: [],
        upper: [detectedLabelTextID],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDBetweenAnyUserFeedback(
    int lowerDetectedLabelTextID,
    int upperDetectedLabelTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID_userFeedback',
        lower: [lowerDetectedLabelTextID],
        includeLower: includeLower,
        upper: [upperDetectedLabelTextID],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDEqualToUserFeedbackIsNull(int detectedLabelTextID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'detectedLabelTextID_userFeedback',
        value: [detectedLabelTextID, null],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDEqualToUserFeedbackIsNotNull(int detectedLabelTextID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'detectedLabelTextID_userFeedback',
        lower: [detectedLabelTextID, null],
        includeLower: false,
        upper: [
          detectedLabelTextID,
        ],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDUserFeedbackEqualTo(
          int detectedLabelTextID, bool? userFeedback) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'detectedLabelTextID_userFeedback',
        value: [detectedLabelTextID, userFeedback],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      detectedLabelTextIDEqualToUserFeedbackNotEqualTo(
          int detectedLabelTextID, bool? userFeedback) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [detectedLabelTextID],
              upper: [detectedLabelTextID, userFeedback],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [detectedLabelTextID, userFeedback],
              includeLower: false,
              upper: [detectedLabelTextID],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [detectedLabelTextID, userFeedback],
              includeLower: false,
              upper: [detectedLabelTextID],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelTextID_userFeedback',
              lower: [detectedLabelTextID],
              upper: [detectedLabelTextID, userFeedback],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userFeedback',
        value: [null],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userFeedback',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackEqualTo(bool? userFeedback) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userFeedback',
        value: [userFeedback],
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterWhereClause>
      userFeedbackNotEqualTo(bool? userFeedback) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userFeedback',
              lower: [],
              upper: [userFeedback],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userFeedback',
              lower: [userFeedback],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userFeedback',
              lower: [userFeedback],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userFeedback',
              lower: [],
              upper: [userFeedback],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MLPhotoLabelQueryFilter
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QFilterCondition> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      detectedLabelTextIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedLabelTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoID',
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoID',
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDGreaterThan(
    int? value, {
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDLessThan(
    int? value, {
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      photoIDBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      userFeedbackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userFeedback',
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      userFeedbackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userFeedback',
      ));
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterFilterCondition>
      userFeedbackEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userFeedback',
        value: value,
      ));
    });
  }
}

extension MLPhotoLabelQueryObject
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QFilterCondition> {}

extension MLPhotoLabelQueryLinks
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QFilterCondition> {}

extension MLPhotoLabelQuerySortBy
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QSortBy> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByDetectedLabelTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> sortByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      sortByUserFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.desc);
    });
  }
}

extension MLPhotoLabelQuerySortThenBy
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QSortThenBy> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByDetectedLabelTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelTextID', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy> thenByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.asc);
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QAfterSortBy>
      thenByUserFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.desc);
    });
  }
}

extension MLPhotoLabelQueryWhereDistinct
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> {
  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidence');
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct>
      distinctByDetectedLabelTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detectedLabelTextID');
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoID');
    });
  }

  QueryBuilder<MLPhotoLabel, MLPhotoLabel, QDistinct> distinctByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userFeedback');
    });
  }
}

extension MLPhotoLabelQueryProperty
    on QueryBuilder<MLPhotoLabel, MLPhotoLabel, QQueryProperty> {
  QueryBuilder<MLPhotoLabel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLPhotoLabel, double, QQueryOperations> confidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidence');
    });
  }

  QueryBuilder<MLPhotoLabel, int, QQueryOperations>
      detectedLabelTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detectedLabelTextID');
    });
  }

  QueryBuilder<MLPhotoLabel, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<MLPhotoLabel, int?, QQueryOperations> photoIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoID');
    });
  }

  QueryBuilder<MLPhotoLabel, bool?, QQueryOperations> userFeedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userFeedback');
    });
  }
}
