// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_text_element.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLTextElementCollection on Isar {
  IsarCollection<MLTextElement> get mLTextElements => this.collection();
}

const MLTextElementSchema = CollectionSchema(
  name: r'MLTextElement',
  id: -8153687795569615519,
  properties: {
    r'cornerPoints': PropertySchema(
      id: 0,
      name: r'cornerPoints',
      type: IsarType.object,
      target: r'CornerPoints',
    ),
    r'detectedElementTextID': PropertySchema(
      id: 1,
      name: r'detectedElementTextID',
      type: IsarType.long,
    ),
    r'lineID': PropertySchema(
      id: 2,
      name: r'lineID',
      type: IsarType.long,
    ),
    r'lineIndex': PropertySchema(
      id: 3,
      name: r'lineIndex',
      type: IsarType.long,
    ),
    r'photoID': PropertySchema(
      id: 4,
      name: r'photoID',
      type: IsarType.long,
    ),
    r'userFeedback': PropertySchema(
      id: 5,
      name: r'userFeedback',
      type: IsarType.bool,
    )
  },
  estimateSize: _mLTextElementEstimateSize,
  serialize: _mLTextElementSerialize,
  deserialize: _mLTextElementDeserialize,
  deserializeProp: _mLTextElementDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'CornerPoints': CornerPointsSchema},
  getId: _mLTextElementGetId,
  getLinks: _mLTextElementGetLinks,
  attach: _mLTextElementAttach,
  version: '3.1.0+1',
);

int _mLTextElementEstimateSize(
  MLTextElement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      CornerPointsSchema.estimateSize(
          object.cornerPoints, allOffsets[CornerPoints]!, allOffsets);
  return bytesCount;
}

void _mLTextElementSerialize(
  MLTextElement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<CornerPoints>(
    offsets[0],
    allOffsets,
    CornerPointsSchema.serialize,
    object.cornerPoints,
  );
  writer.writeLong(offsets[1], object.detectedElementTextID);
  writer.writeLong(offsets[2], object.lineID);
  writer.writeLong(offsets[3], object.lineIndex);
  writer.writeLong(offsets[4], object.photoID);
  writer.writeBool(offsets[5], object.userFeedback);
}

MLTextElement _mLTextElementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLTextElement();
  object.cornerPoints = reader.readObjectOrNull<CornerPoints>(
        offsets[0],
        CornerPointsSchema.deserialize,
        allOffsets,
      ) ??
      CornerPoints();
  object.detectedElementTextID = reader.readLong(offsets[1]);
  object.id = id;
  object.lineID = reader.readLong(offsets[2]);
  object.lineIndex = reader.readLong(offsets[3]);
  object.photoID = reader.readLong(offsets[4]);
  object.userFeedback = reader.readBoolOrNull(offsets[5]);
  return object;
}

P _mLTextElementDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<CornerPoints>(
            offset,
            CornerPointsSchema.deserialize,
            allOffsets,
          ) ??
          CornerPoints()) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBoolOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLTextElementGetId(MLTextElement object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLTextElementGetLinks(MLTextElement object) {
  return [];
}

void _mLTextElementAttach(
    IsarCollection<dynamic> col, Id id, MLTextElement object) {
  object.id = id;
}

extension MLTextElementQueryWhereSort
    on QueryBuilder<MLTextElement, MLTextElement, QWhere> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MLTextElementQueryWhere
    on QueryBuilder<MLTextElement, MLTextElement, QWhereClause> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterWhereClause> idBetween(
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

extension MLTextElementQueryFilter
    on QueryBuilder<MLTextElement, MLTextElement, QFilterCondition> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedElementTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'detectedElementTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'detectedElementTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      detectedElementTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'detectedElementTextID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      lineIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDLessThan(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      photoIDBetween(
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

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      userFeedbackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userFeedback',
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      userFeedbackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userFeedback',
      ));
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      userFeedbackEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userFeedback',
        value: value,
      ));
    });
  }
}

extension MLTextElementQueryObject
    on QueryBuilder<MLTextElement, MLTextElement, QFilterCondition> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterFilterCondition>
      cornerPoints(FilterQuery<CornerPoints> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'cornerPoints');
    });
  }
}

extension MLTextElementQueryLinks
    on QueryBuilder<MLTextElement, MLTextElement, QFilterCondition> {}

extension MLTextElementQuerySortBy
    on QueryBuilder<MLTextElement, MLTextElement, QSortBy> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByDetectedElementTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedElementTextID', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByDetectedElementTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedElementTextID', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByLineID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineID', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByLineIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineID', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByLineIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineIndex', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByLineIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineIndex', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> sortByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      sortByUserFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.desc);
    });
  }
}

extension MLTextElementQuerySortThenBy
    on QueryBuilder<MLTextElement, MLTextElement, QSortThenBy> {
  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByDetectedElementTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedElementTextID', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByDetectedElementTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedElementTextID', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByLineID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineID', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByLineIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineID', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByLineIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineIndex', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByLineIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineIndex', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy> thenByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.asc);
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QAfterSortBy>
      thenByUserFeedbackDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userFeedback', Sort.desc);
    });
  }
}

extension MLTextElementQueryWhereDistinct
    on QueryBuilder<MLTextElement, MLTextElement, QDistinct> {
  QueryBuilder<MLTextElement, MLTextElement, QDistinct>
      distinctByDetectedElementTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detectedElementTextID');
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctByLineID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineID');
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctByLineIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineIndex');
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct> distinctByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoID');
    });
  }

  QueryBuilder<MLTextElement, MLTextElement, QDistinct>
      distinctByUserFeedback() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userFeedback');
    });
  }
}

extension MLTextElementQueryProperty
    on QueryBuilder<MLTextElement, MLTextElement, QQueryProperty> {
  QueryBuilder<MLTextElement, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLTextElement, CornerPoints, QQueryOperations>
      cornerPointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cornerPoints');
    });
  }

  QueryBuilder<MLTextElement, int, QQueryOperations>
      detectedElementTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detectedElementTextID');
    });
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> lineIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineID');
    });
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> lineIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineIndex');
    });
  }

  QueryBuilder<MLTextElement, int, QQueryOperations> photoIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoID');
    });
  }

  QueryBuilder<MLTextElement, bool?, QQueryOperations> userFeedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userFeedback');
    });
  }
}
