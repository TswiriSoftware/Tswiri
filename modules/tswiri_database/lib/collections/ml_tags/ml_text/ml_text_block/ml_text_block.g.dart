// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_text_block.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLTextBlockCollection on Isar {
  IsarCollection<MLTextBlock> get mLTextBlocks => this.collection();
}

const MLTextBlockSchema = CollectionSchema(
  name: r'MLTextBlock',
  id: 9126700708740949900,
  properties: {
    r'cornerPoints': PropertySchema(
      id: 0,
      name: r'cornerPoints',
      type: IsarType.object,
      target: r'CornerPoints',
    ),
    r'recognizedLanguages': PropertySchema(
      id: 1,
      name: r'recognizedLanguages',
      type: IsarType.stringList,
    )
  },
  estimateSize: _mLTextBlockEstimateSize,
  serialize: _mLTextBlockSerialize,
  deserialize: _mLTextBlockDeserialize,
  deserializeProp: _mLTextBlockDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'CornerPoints': CornerPointsSchema},
  getId: _mLTextBlockGetId,
  getLinks: _mLTextBlockGetLinks,
  attach: _mLTextBlockAttach,
  version: '3.1.0+1',
);

int _mLTextBlockEstimateSize(
  MLTextBlock object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      CornerPointsSchema.estimateSize(
          object.cornerPoints, allOffsets[CornerPoints]!, allOffsets);
  bytesCount += 3 + object.recognizedLanguages.length * 3;
  {
    for (var i = 0; i < object.recognizedLanguages.length; i++) {
      final value = object.recognizedLanguages[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _mLTextBlockSerialize(
  MLTextBlock object,
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
  writer.writeStringList(offsets[1], object.recognizedLanguages);
}

MLTextBlock _mLTextBlockDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLTextBlock();
  object.cornerPoints = reader.readObjectOrNull<CornerPoints>(
        offsets[0],
        CornerPointsSchema.deserialize,
        allOffsets,
      ) ??
      CornerPoints();
  object.id = id;
  object.recognizedLanguages = reader.readStringList(offsets[1]) ?? [];
  return object;
}

P _mLTextBlockDeserializeProp<P>(
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
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLTextBlockGetId(MLTextBlock object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLTextBlockGetLinks(MLTextBlock object) {
  return [];
}

void _mLTextBlockAttach(
    IsarCollection<dynamic> col, Id id, MLTextBlock object) {
  object.id = id;
}

extension MLTextBlockQueryWhereSort
    on QueryBuilder<MLTextBlock, MLTextBlock, QWhere> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MLTextBlockQueryWhere
    on QueryBuilder<MLTextBlock, MLTextBlock, QWhereClause> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idBetween(
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

extension MLTextBlockQueryFilter
    on QueryBuilder<MLTextBlock, MLTextBlock, QFilterCondition> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recognizedLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recognizedLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recognizedLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recognizedLanguages',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recognizedLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recognizedLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recognizedLanguages',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recognizedLanguages',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recognizedLanguages',
        value: '',
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recognizedLanguages',
        value: '',
      ));
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recognizedLanguages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recognizedLanguages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recognizedLanguages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recognizedLanguages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recognizedLanguages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'recognizedLanguages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension MLTextBlockQueryObject
    on QueryBuilder<MLTextBlock, MLTextBlock, QFilterCondition> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> cornerPoints(
      FilterQuery<CornerPoints> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'cornerPoints');
    });
  }
}

extension MLTextBlockQueryLinks
    on QueryBuilder<MLTextBlock, MLTextBlock, QFilterCondition> {}

extension MLTextBlockQuerySortBy
    on QueryBuilder<MLTextBlock, MLTextBlock, QSortBy> {}

extension MLTextBlockQuerySortThenBy
    on QueryBuilder<MLTextBlock, MLTextBlock, QSortThenBy> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension MLTextBlockQueryWhereDistinct
    on QueryBuilder<MLTextBlock, MLTextBlock, QDistinct> {
  QueryBuilder<MLTextBlock, MLTextBlock, QDistinct>
      distinctByRecognizedLanguages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recognizedLanguages');
    });
  }
}

extension MLTextBlockQueryProperty
    on QueryBuilder<MLTextBlock, MLTextBlock, QQueryProperty> {
  QueryBuilder<MLTextBlock, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLTextBlock, CornerPoints, QQueryOperations>
      cornerPointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cornerPoints');
    });
  }

  QueryBuilder<MLTextBlock, List<String>, QQueryOperations>
      recognizedLanguagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recognizedLanguages');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const CornerPointsSchema = Schema(
  name: r'CornerPoints',
  id: 5355938919179617338,
  properties: {
    r'bottomLeft': PropertySchema(
      id: 0,
      name: r'bottomLeft',
      type: IsarType.longList,
    ),
    r'bottomRight': PropertySchema(
      id: 1,
      name: r'bottomRight',
      type: IsarType.longList,
    ),
    r'topLeft': PropertySchema(
      id: 2,
      name: r'topLeft',
      type: IsarType.longList,
    ),
    r'topRight': PropertySchema(
      id: 3,
      name: r'topRight',
      type: IsarType.longList,
    )
  },
  estimateSize: _cornerPointsEstimateSize,
  serialize: _cornerPointsSerialize,
  deserialize: _cornerPointsDeserialize,
  deserializeProp: _cornerPointsDeserializeProp,
);

int _cornerPointsEstimateSize(
  CornerPoints object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bottomLeft;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.bottomRight;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.topLeft;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.topRight;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _cornerPointsSerialize(
  CornerPoints object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.bottomLeft);
  writer.writeLongList(offsets[1], object.bottomRight);
  writer.writeLongList(offsets[2], object.topLeft);
  writer.writeLongList(offsets[3], object.topRight);
}

CornerPoints _cornerPointsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CornerPoints(
    bottomLeft: reader.readLongList(offsets[0]),
    bottomRight: reader.readLongList(offsets[1]),
    topLeft: reader.readLongList(offsets[2]),
    topRight: reader.readLongList(offsets[3]),
  );
  return object;
}

P _cornerPointsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readLongList(offset)) as P;
    case 2:
      return (reader.readLongList(offset)) as P;
    case 3:
      return (reader.readLongList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension CornerPointsQueryFilter
    on QueryBuilder<CornerPoints, CornerPoints, QFilterCondition> {
  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bottomLeft',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bottomLeft',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bottomLeft',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bottomLeft',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bottomLeft',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bottomLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomLeft',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomLeft',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomLeft',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomLeft',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomLeft',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomLeftLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomLeft',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bottomRight',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bottomRight',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bottomRight',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bottomRight',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bottomRight',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bottomRight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomRight',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomRight',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomRight',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomRight',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomRight',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      bottomRightLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bottomRight',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topLeft',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topLeft',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topLeft',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topLeft',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topLeft',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topLeft',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topLeft',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topLeft',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topLeft',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topLeft',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topLeftLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topLeft',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topRight',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topRight',
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topRight',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topRight',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topRight',
        value: value,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topRight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topRight',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topRight',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topRight',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topRight',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topRight',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CornerPoints, CornerPoints, QAfterFilterCondition>
      topRightLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'topRight',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CornerPointsQueryObject
    on QueryBuilder<CornerPoints, CornerPoints, QFilterCondition> {}
