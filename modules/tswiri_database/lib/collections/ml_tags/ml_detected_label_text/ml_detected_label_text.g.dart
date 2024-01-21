// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_detected_label_text.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLDetectedLabelTextCollection on Isar {
  IsarCollection<MLDetectedLabelText> get mLDetectedLabelTexts =>
      this.collection();
}

const MLDetectedLabelTextSchema = CollectionSchema(
  name: r'MLDetectedLabelText',
  id: -8595415678468150704,
  properties: {
    r'detectedLabelText': PropertySchema(
      id: 0,
      name: r'detectedLabelText',
      type: IsarType.string,
    ),
    r'hidden': PropertySchema(
      id: 1,
      name: r'hidden',
      type: IsarType.bool,
    )
  },
  estimateSize: _mLDetectedLabelTextEstimateSize,
  serialize: _mLDetectedLabelTextSerialize,
  deserialize: _mLDetectedLabelTextDeserialize,
  deserializeProp: _mLDetectedLabelTextDeserializeProp,
  idName: r'id',
  indexes: {
    r'detectedLabelText': IndexSchema(
      id: -6625307223829943034,
      name: r'detectedLabelText',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'detectedLabelText',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _mLDetectedLabelTextGetId,
  getLinks: _mLDetectedLabelTextGetLinks,
  attach: _mLDetectedLabelTextAttach,
  version: '3.1.0+1',
);

int _mLDetectedLabelTextEstimateSize(
  MLDetectedLabelText object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.detectedLabelText.length * 3;
  return bytesCount;
}

void _mLDetectedLabelTextSerialize(
  MLDetectedLabelText object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.detectedLabelText);
  writer.writeBool(offsets[1], object.hidden);
}

MLDetectedLabelText _mLDetectedLabelTextDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLDetectedLabelText();
  object.detectedLabelText = reader.readString(offsets[0]);
  object.hidden = reader.readBool(offsets[1]);
  object.id = id;
  return object;
}

P _mLDetectedLabelTextDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLDetectedLabelTextGetId(MLDetectedLabelText object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLDetectedLabelTextGetLinks(
    MLDetectedLabelText object) {
  return [];
}

void _mLDetectedLabelTextAttach(
    IsarCollection<dynamic> col, Id id, MLDetectedLabelText object) {
  object.id = id;
}

extension MLDetectedLabelTextByIndex on IsarCollection<MLDetectedLabelText> {
  Future<MLDetectedLabelText?> getByDetectedLabelText(
      String detectedLabelText) {
    return getByIndex(r'detectedLabelText', [detectedLabelText]);
  }

  MLDetectedLabelText? getByDetectedLabelTextSync(String detectedLabelText) {
    return getByIndexSync(r'detectedLabelText', [detectedLabelText]);
  }

  Future<bool> deleteByDetectedLabelText(String detectedLabelText) {
    return deleteByIndex(r'detectedLabelText', [detectedLabelText]);
  }

  bool deleteByDetectedLabelTextSync(String detectedLabelText) {
    return deleteByIndexSync(r'detectedLabelText', [detectedLabelText]);
  }

  Future<List<MLDetectedLabelText?>> getAllByDetectedLabelText(
      List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return getAllByIndex(r'detectedLabelText', values);
  }

  List<MLDetectedLabelText?> getAllByDetectedLabelTextSync(
      List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'detectedLabelText', values);
  }

  Future<int> deleteAllByDetectedLabelText(
      List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'detectedLabelText', values);
  }

  int deleteAllByDetectedLabelTextSync(List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'detectedLabelText', values);
  }

  Future<Id> putByDetectedLabelText(MLDetectedLabelText object) {
    return putByIndex(r'detectedLabelText', object);
  }

  Id putByDetectedLabelTextSync(MLDetectedLabelText object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'detectedLabelText', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDetectedLabelText(
      List<MLDetectedLabelText> objects) {
    return putAllByIndex(r'detectedLabelText', objects);
  }

  List<Id> putAllByDetectedLabelTextSync(List<MLDetectedLabelText> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'detectedLabelText', objects,
        saveLinks: saveLinks);
  }
}

extension MLDetectedLabelTextQueryWhereSort
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QWhere> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MLDetectedLabelTextQueryWhere
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QWhereClause> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
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

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
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

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      detectedLabelTextEqualTo(String detectedLabelText) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'detectedLabelText',
        value: [detectedLabelText],
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      detectedLabelTextNotEqualTo(String detectedLabelText) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelText',
              lower: [],
              upper: [detectedLabelText],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelText',
              lower: [detectedLabelText],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelText',
              lower: [detectedLabelText],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'detectedLabelText',
              lower: [],
              upper: [detectedLabelText],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MLDetectedLabelTextQueryFilter on QueryBuilder<MLDetectedLabelText,
    MLDetectedLabelText, QFilterCondition> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedLabelText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'detectedLabelText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'detectedLabelText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'detectedLabelText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'detectedLabelText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'detectedLabelText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'detectedLabelText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'detectedLabelText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectedLabelText',
        value: '',
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'detectedLabelText',
        value: '',
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      hiddenEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hidden',
        value: value,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
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

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idBetween(
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
}

extension MLDetectedLabelTextQueryObject on QueryBuilder<MLDetectedLabelText,
    MLDetectedLabelText, QFilterCondition> {}

extension MLDetectedLabelTextQueryLinks on QueryBuilder<MLDetectedLabelText,
    MLDetectedLabelText, QFilterCondition> {}

extension MLDetectedLabelTextQuerySortBy
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QSortBy> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByDetectedLabelText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelText', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByDetectedLabelTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelText', Sort.desc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.desc);
    });
  }
}

extension MLDetectedLabelTextQuerySortThenBy
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QSortThenBy> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByDetectedLabelText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelText', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByDetectedLabelTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectedLabelText', Sort.desc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hidden', Sort.desc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension MLDetectedLabelTextQueryWhereDistinct
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct>
      distinctByDetectedLabelText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detectedLabelText',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct>
      distinctByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hidden');
    });
  }
}

extension MLDetectedLabelTextQueryProperty
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QQueryProperty> {
  QueryBuilder<MLDetectedLabelText, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLDetectedLabelText, String, QQueryOperations>
      detectedLabelTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detectedLabelText');
    });
  }

  QueryBuilder<MLDetectedLabelText, bool, QQueryOperations> hiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hidden');
    });
  }
}
