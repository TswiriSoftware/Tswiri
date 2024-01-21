// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_detected_element_text.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLDetectedElementTextCollection on Isar {
  IsarCollection<MLDetectedElementText> get mLDetectedElementTexts =>
      this.collection();
}

const MLDetectedElementTextSchema = CollectionSchema(
  name: r'MLDetectedElementText',
  id: -81910300862143460,
  properties: {
    r'detectedText': PropertySchema(
      id: 0,
      name: r'detectedText',
      type: IsarType.string,
    ),
    r'tagTextID': PropertySchema(
      id: 1,
      name: r'tagTextID',
      type: IsarType.long,
    )
  },
  estimateSize: _mLDetectedElementTextEstimateSize,
  serialize: _mLDetectedElementTextSerialize,
  deserialize: _mLDetectedElementTextDeserialize,
  deserializeProp: _mLDetectedElementTextDeserializeProp,
  idName: r'id',
  indexes: {
    r'detectedText': IndexSchema(
      id: -5803330501683015084,
      name: r'detectedText',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'detectedText',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _mLDetectedElementTextGetId,
  getLinks: _mLDetectedElementTextGetLinks,
  attach: _mLDetectedElementTextAttach,
  version: '3.1.0+1',
);

int _mLDetectedElementTextEstimateSize(
  MLDetectedElementText object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.detectedText.length * 3;
  return bytesCount;
}

void _mLDetectedElementTextSerialize(
  MLDetectedElementText object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.detectedText);
  writer.writeLong(offsets[1], object.tagTextID);
}

MLDetectedElementText _mLDetectedElementTextDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLDetectedElementText();
  object.detectedText = reader.readString(offsets[0]);
  object.id = id;
  object.tagTextID = reader.readLongOrNull(offsets[1]);
  return object;
}

P _mLDetectedElementTextDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLDetectedElementTextGetId(MLDetectedElementText object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLDetectedElementTextGetLinks(
    MLDetectedElementText object) {
  return [];
}

void _mLDetectedElementTextAttach(
    IsarCollection<dynamic> col, Id id, MLDetectedElementText object) {
  object.id = id;
}

extension MLDetectedElementTextByIndex
    on IsarCollection<MLDetectedElementText> {
  Future<MLDetectedElementText?> getByDetectedText(String detectedText) {
    return getByIndex(r'detectedText', [detectedText]);
  }

  MLDetectedElementText? getByDetectedTextSync(String detectedText) {
    return getByIndexSync(r'detectedText', [detectedText]);
  }

  Future<bool> deleteByDetectedText(String detectedText) {
    return deleteByIndex(r'detectedText', [detectedText]);
  }

  bool deleteByDetectedTextSync(String detectedText) {
    return deleteByIndexSync(r'detectedText', [detectedText]);
  }

  Future<List<MLDetectedElementText?>> getAllByDetectedText(
      List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return getAllByIndex(r'detectedText', values);
  }

  List<MLDetectedElementText?> getAllByDetectedTextSync(
      List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'detectedText', values);
  }

  Future<int> deleteAllByDetectedText(List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'detectedText', values);
  }

  int deleteAllByDetectedTextSync(List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'detectedText', values);
  }

  Future<Id> putByDetectedText(MLDetectedElementText object) {
    return putByIndex(r'detectedText', object);
  }

  Id putByDetectedTextSync(MLDetectedElementText object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'detectedText', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDetectedText(List<MLDetectedElementText> objects) {
    return putAllByIndex(r'detectedText', objects);
  }

  List<Id> putAllByDetectedTextSync(List<MLDetectedElementText> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'detectedText', objects, saveLinks: saveLinks);
  }
}

extension MLDetectedElementTextQueryWhereSort
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QWhere> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MLDetectedElementTextQueryWhere on QueryBuilder<MLDetectedElementText,
    MLDetectedElementText, QWhereClause> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      detectedTextEqualTo(String detectedText) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'detectedText',
        value: [detectedText],
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      detectedTextNotEqualTo(String detectedText) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedText',
              lower: [],
              upper: [detectedText],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedText',
              lower: [detectedText],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedText',
              lower: [detectedText],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedText',
              lower: [],
              upper: [detectedText],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MLDetectedElementTextQueryFilter on QueryBuilder<
    MLDetectedElementText, MLDetectedElementText, QFilterCondition> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'detectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'detectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'detectedText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'detectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'detectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
          QAfterFilterCondition>
      detectedTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'detectedText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
          QAfterFilterCondition>
      detectedTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'detectedText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedText',
        value: '',
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'detectedText',
        value: '',
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagTextID',
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagTextID',
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagTextID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDGreaterThan(
    int? value, {
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDLessThan(
    int? value, {
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDBetween(
    int? lower,
    int? upper, {
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

extension MLDetectedElementTextQueryObject on QueryBuilder<
    MLDetectedElementText, MLDetectedElementText, QFilterCondition> {}

extension MLDetectedElementTextQueryLinks on QueryBuilder<MLDetectedElementText,
    MLDetectedElementText, QFilterCondition> {}

extension MLDetectedElementTextQuerySortBy
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QSortBy> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByDetectedText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedText', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByDetectedTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedText', Sort.desc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension MLDetectedElementTextQuerySortThenBy
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QSortThenBy> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByDetectedText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedText', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByDetectedTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedText', Sort.desc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByTagTextIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagTextID', Sort.desc);
    });
  }
}

extension MLDetectedElementTextQueryWhereDistinct
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct>
      distinctByDetectedText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detectedText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct>
      distinctByTagTextID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagTextID');
    });
  }
}

extension MLDetectedElementTextQueryProperty on QueryBuilder<
    MLDetectedElementText, MLDetectedElementText, QQueryProperty> {
  QueryBuilder<MLDetectedElementText, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLDetectedElementText, String, QQueryOperations>
      detectedTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detectedText');
    });
  }

  QueryBuilder<MLDetectedElementText, int?, QQueryOperations>
      tagTextIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagTextID');
    });
  }
}
