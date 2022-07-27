// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_detected_label_text.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLDetectedLabelTextCollection on Isar {
  IsarCollection<MLDetectedLabelText> get mLDetectedLabelTexts =>
      getCollection();
}

const MLDetectedLabelTextSchema = CollectionSchema(
  name: 'MLDetectedLabelText',
  schema:
      '{"name":"MLDetectedLabelText","idName":"id","properties":[{"name":"detectedLabelText","type":"String"},{"name":"hidden","type":"Bool"}],"indexes":[{"name":"detectedLabelText","unique":true,"properties":[{"name":"detectedLabelText","type":"Hash","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'detectedLabelText': 0, 'hidden': 1},
  listProperties: {},
  indexIds: {'detectedLabelText': 0},
  indexValueTypes: {
    'detectedLabelText': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLDetectedLabelTextGetId,
  setId: _mLDetectedLabelTextSetId,
  getLinks: _mLDetectedLabelTextGetLinks,
  attachLinks: _mLDetectedLabelTextAttachLinks,
  serializeNative: _mLDetectedLabelTextSerializeNative,
  deserializeNative: _mLDetectedLabelTextDeserializeNative,
  deserializePropNative: _mLDetectedLabelTextDeserializePropNative,
  serializeWeb: _mLDetectedLabelTextSerializeWeb,
  deserializeWeb: _mLDetectedLabelTextDeserializeWeb,
  deserializePropWeb: _mLDetectedLabelTextDeserializePropWeb,
  version: 3,
);

int? _mLDetectedLabelTextGetId(MLDetectedLabelText object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLDetectedLabelTextSetId(MLDetectedLabelText object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLDetectedLabelTextGetLinks(MLDetectedLabelText object) {
  return [];
}

void _mLDetectedLabelTextSerializeNative(
    IsarCollection<MLDetectedLabelText> collection,
    IsarRawObject rawObj,
    MLDetectedLabelText object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.detectedLabelText;
  final _detectedLabelText = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_detectedLabelText.length) as int;
  final value1 = object.hidden;
  final _hidden = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _detectedLabelText);
  writer.writeBool(offsets[1], _hidden);
}

MLDetectedLabelText _mLDetectedLabelTextDeserializeNative(
    IsarCollection<MLDetectedLabelText> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = MLDetectedLabelText();
  object.detectedLabelText = reader.readString(offsets[0]);
  object.hidden = reader.readBool(offsets[1]);
  object.id = id;
  return object;
}

P _mLDetectedLabelTextDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLDetectedLabelTextSerializeWeb(
    IsarCollection<MLDetectedLabelText> collection,
    MLDetectedLabelText object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'detectedLabelText', object.detectedLabelText);
  IsarNative.jsObjectSet(jsObj, 'hidden', object.hidden);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  return jsObj;
}

MLDetectedLabelText _mLDetectedLabelTextDeserializeWeb(
    IsarCollection<MLDetectedLabelText> collection, dynamic jsObj) {
  final object = MLDetectedLabelText();
  object.detectedLabelText =
      IsarNative.jsObjectGet(jsObj, 'detectedLabelText') ?? '';
  object.hidden = IsarNative.jsObjectGet(jsObj, 'hidden') ?? false;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _mLDetectedLabelTextDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'detectedLabelText':
      return (IsarNative.jsObjectGet(jsObj, 'detectedLabelText') ?? '') as P;
    case 'hidden':
      return (IsarNative.jsObjectGet(jsObj, 'hidden') ?? false) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLDetectedLabelTextAttachLinks(
    IsarCollection col, int id, MLDetectedLabelText object) {}

extension MLDetectedLabelTextByIndex on IsarCollection<MLDetectedLabelText> {
  Future<MLDetectedLabelText?> getByDetectedLabelText(
      String detectedLabelText) {
    return getByIndex('detectedLabelText', [detectedLabelText]);
  }

  MLDetectedLabelText? getByDetectedLabelTextSync(String detectedLabelText) {
    return getByIndexSync('detectedLabelText', [detectedLabelText]);
  }

  Future<bool> deleteByDetectedLabelText(String detectedLabelText) {
    return deleteByIndex('detectedLabelText', [detectedLabelText]);
  }

  bool deleteByDetectedLabelTextSync(String detectedLabelText) {
    return deleteByIndexSync('detectedLabelText', [detectedLabelText]);
  }

  Future<List<MLDetectedLabelText?>> getAllByDetectedLabelText(
      List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return getAllByIndex('detectedLabelText', values);
  }

  List<MLDetectedLabelText?> getAllByDetectedLabelTextSync(
      List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return getAllByIndexSync('detectedLabelText', values);
  }

  Future<int> deleteAllByDetectedLabelText(
      List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return deleteAllByIndex('detectedLabelText', values);
  }

  int deleteAllByDetectedLabelTextSync(List<String> detectedLabelTextValues) {
    final values = detectedLabelTextValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('detectedLabelText', values);
  }
}

extension MLDetectedLabelTextQueryWhereSort
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QWhere> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhere>
      anyDetectedLabelText() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'detectedLabelText'));
  }
}

extension MLDetectedLabelTextQueryWhere
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QWhereClause> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      detectedLabelTextEqualTo(String detectedLabelText) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'detectedLabelText',
      value: [detectedLabelText],
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterWhereClause>
      detectedLabelTextNotEqualTo(String detectedLabelText) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelText',
        upper: [detectedLabelText],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelText',
        lower: [detectedLabelText],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedLabelText',
        lower: [detectedLabelText],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedLabelText',
        upper: [detectedLabelText],
        includeUpper: false,
      ));
    }
  }
}

extension MLDetectedLabelTextQueryFilter on QueryBuilder<MLDetectedLabelText,
    MLDetectedLabelText, QFilterCondition> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'detectedLabelText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'detectedLabelText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'detectedLabelText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'detectedLabelText',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'detectedLabelText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'detectedLabelText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'detectedLabelText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      detectedLabelTextMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'detectedLabelText',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      hiddenEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hidden',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterFilterCondition>
      idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension MLDetectedLabelTextQueryLinks on QueryBuilder<MLDetectedLabelText,
    MLDetectedLabelText, QFilterCondition> {}

extension MLDetectedLabelTextQueryWhereSortBy
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QSortBy> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByDetectedLabelText() {
    return addSortByInternal('detectedLabelText', Sort.asc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByDetectedLabelTextDesc() {
    return addSortByInternal('detectedLabelText', Sort.desc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByHidden() {
    return addSortByInternal('hidden', Sort.asc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByHiddenDesc() {
    return addSortByInternal('hidden', Sort.desc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension MLDetectedLabelTextQueryWhereSortThenBy
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QSortThenBy> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByDetectedLabelText() {
    return addSortByInternal('detectedLabelText', Sort.asc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByDetectedLabelTextDesc() {
    return addSortByInternal('detectedLabelText', Sort.desc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByHidden() {
    return addSortByInternal('hidden', Sort.asc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByHiddenDesc() {
    return addSortByInternal('hidden', Sort.desc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension MLDetectedLabelTextQueryWhereDistinct
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct> {
  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct>
      distinctByDetectedLabelText({bool caseSensitive = true}) {
    return addDistinctByInternal('detectedLabelText',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct>
      distinctByHidden() {
    return addDistinctByInternal('hidden');
  }

  QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }
}

extension MLDetectedLabelTextQueryProperty
    on QueryBuilder<MLDetectedLabelText, MLDetectedLabelText, QQueryProperty> {
  QueryBuilder<MLDetectedLabelText, String, QQueryOperations>
      detectedLabelTextProperty() {
    return addPropertyNameInternal('detectedLabelText');
  }

  QueryBuilder<MLDetectedLabelText, bool, QQueryOperations> hiddenProperty() {
    return addPropertyNameInternal('hidden');
  }

  QueryBuilder<MLDetectedLabelText, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }
}
