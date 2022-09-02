// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_detected_element_text.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLDetectedElementTextCollection on Isar {
  IsarCollection<MLDetectedElementText> get mLDetectedElementTexts =>
      getCollection();
}

const MLDetectedElementTextSchema = CollectionSchema(
  name: 'MLDetectedElementText',
  schema:
      '{"name":"MLDetectedElementText","idName":"id","properties":[{"name":"detectedText","type":"String"},{"name":"tagTextID","type":"Long"}],"indexes":[{"name":"detectedText","unique":true,"properties":[{"name":"detectedText","type":"Hash","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'detectedText': 0, 'tagTextID': 1},
  listProperties: {},
  indexIds: {'detectedText': 0},
  indexValueTypes: {
    'detectedText': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLDetectedElementTextGetId,
  setId: _mLDetectedElementTextSetId,
  getLinks: _mLDetectedElementTextGetLinks,
  attachLinks: _mLDetectedElementTextAttachLinks,
  serializeNative: _mLDetectedElementTextSerializeNative,
  deserializeNative: _mLDetectedElementTextDeserializeNative,
  deserializePropNative: _mLDetectedElementTextDeserializePropNative,
  serializeWeb: _mLDetectedElementTextSerializeWeb,
  deserializeWeb: _mLDetectedElementTextDeserializeWeb,
  deserializePropWeb: _mLDetectedElementTextDeserializePropWeb,
  version: 3,
);

int? _mLDetectedElementTextGetId(MLDetectedElementText object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLDetectedElementTextSetId(MLDetectedElementText object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLDetectedElementTextGetLinks(
    MLDetectedElementText object) {
  return [];
}

void _mLDetectedElementTextSerializeNative(
    IsarCollection<MLDetectedElementText> collection,
    IsarRawObject rawObj,
    MLDetectedElementText object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.detectedText;
  final _detectedText = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_detectedText.length) as int;
  final value1 = object.tagTextID;
  final _tagTextID = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _detectedText);
  writer.writeLong(offsets[1], _tagTextID);
}

MLDetectedElementText _mLDetectedElementTextDeserializeNative(
    IsarCollection<MLDetectedElementText> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = MLDetectedElementText();
  object.detectedText = reader.readString(offsets[0]);
  object.id = id;
  object.tagTextID = reader.readLongOrNull(offsets[1]);
  return object;
}

P _mLDetectedElementTextDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLDetectedElementTextSerializeWeb(
    IsarCollection<MLDetectedElementText> collection,
    MLDetectedElementText object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'detectedText', object.detectedText);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'tagTextID', object.tagTextID);
  return jsObj;
}

MLDetectedElementText _mLDetectedElementTextDeserializeWeb(
    IsarCollection<MLDetectedElementText> collection, dynamic jsObj) {
  final object = MLDetectedElementText();
  object.detectedText = IsarNative.jsObjectGet(jsObj, 'detectedText') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.tagTextID = IsarNative.jsObjectGet(jsObj, 'tagTextID');
  return object;
}

P _mLDetectedElementTextDeserializePropWeb<P>(
    Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'detectedText':
      return (IsarNative.jsObjectGet(jsObj, 'detectedText') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'tagTextID':
      return (IsarNative.jsObjectGet(jsObj, 'tagTextID')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLDetectedElementTextAttachLinks(
    IsarCollection col, int id, MLDetectedElementText object) {}

extension MLDetectedElementTextByIndex
    on IsarCollection<MLDetectedElementText> {
  Future<MLDetectedElementText?> getByDetectedText(String detectedText) {
    return getByIndex('detectedText', [detectedText]);
  }

  MLDetectedElementText? getByDetectedTextSync(String detectedText) {
    return getByIndexSync('detectedText', [detectedText]);
  }

  Future<bool> deleteByDetectedText(String detectedText) {
    return deleteByIndex('detectedText', [detectedText]);
  }

  bool deleteByDetectedTextSync(String detectedText) {
    return deleteByIndexSync('detectedText', [detectedText]);
  }

  Future<List<MLDetectedElementText?>> getAllByDetectedText(
      List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return getAllByIndex('detectedText', values);
  }

  List<MLDetectedElementText?> getAllByDetectedTextSync(
      List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return getAllByIndexSync('detectedText', values);
  }

  Future<int> deleteAllByDetectedText(List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return deleteAllByIndex('detectedText', values);
  }

  int deleteAllByDetectedTextSync(List<String> detectedTextValues) {
    final values = detectedTextValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('detectedText', values);
  }
}

extension MLDetectedElementTextQueryWhereSort
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QWhere> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhere>
      anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhere>
      anyDetectedText() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'detectedText'));
  }
}

extension MLDetectedElementTextQueryWhere on QueryBuilder<MLDetectedElementText,
    MLDetectedElementText, QWhereClause> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      detectedTextEqualTo(String detectedText) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'detectedText',
      value: [detectedText],
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterWhereClause>
      detectedTextNotEqualTo(String detectedText) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedText',
        upper: [detectedText],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedText',
        lower: [detectedText],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'detectedText',
        lower: [detectedText],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'detectedText',
        upper: [detectedText],
        includeUpper: false,
      ));
    }
  }
}

extension MLDetectedElementTextQueryFilter on QueryBuilder<
    MLDetectedElementText, MLDetectedElementText, QFilterCondition> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'detectedText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'detectedText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'detectedText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'detectedText',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'detectedText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> detectedTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'detectedText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
          QAfterFilterCondition>
      detectedTextContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'detectedText',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
          QAfterFilterCondition>
      detectedTextMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'detectedText',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'tagTextID',
      value: null,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDEqualTo(int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText,
      QAfterFilterCondition> tagTextIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tagTextID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension MLDetectedElementTextQueryLinks on QueryBuilder<MLDetectedElementText,
    MLDetectedElementText, QFilterCondition> {}

extension MLDetectedElementTextQueryWhereSortBy
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QSortBy> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByDetectedText() {
    return addSortByInternal('detectedText', Sort.asc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByDetectedTextDesc() {
    return addSortByInternal('detectedText', Sort.desc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      sortByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension MLDetectedElementTextQueryWhereSortThenBy
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QSortThenBy> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByDetectedText() {
    return addSortByInternal('detectedText', Sort.asc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByDetectedTextDesc() {
    return addSortByInternal('detectedText', Sort.desc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QAfterSortBy>
      thenByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension MLDetectedElementTextQueryWhereDistinct
    on QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct> {
  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct>
      distinctByDetectedText({bool caseSensitive = true}) {
    return addDistinctByInternal('detectedText', caseSensitive: caseSensitive);
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<MLDetectedElementText, MLDetectedElementText, QDistinct>
      distinctByTagTextID() {
    return addDistinctByInternal('tagTextID');
  }
}

extension MLDetectedElementTextQueryProperty on QueryBuilder<
    MLDetectedElementText, MLDetectedElementText, QQueryProperty> {
  QueryBuilder<MLDetectedElementText, String, QQueryOperations>
      detectedTextProperty() {
    return addPropertyNameInternal('detectedText');
  }

  QueryBuilder<MLDetectedElementText, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLDetectedElementText, int?, QQueryOperations>
      tagTextIDProperty() {
    return addPropertyNameInternal('tagTextID');
  }
}
