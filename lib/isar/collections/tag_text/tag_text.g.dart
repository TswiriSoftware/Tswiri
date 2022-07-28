// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'tag_text.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetTagTextCollection on Isar {
  IsarCollection<TagText> get tagTexts => getCollection();
}

const TagTextSchema = CollectionSchema(
  name: 'TagText',
  schema:
      '{"name":"TagText","idName":"id","properties":[{"name":"hashCode","type":"Long"},{"name":"text","type":"String"}],"indexes":[{"name":"text","unique":true,"properties":[{"name":"text","type":"Hash","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'hashCode': 0, 'text': 1},
  listProperties: {},
  indexIds: {'text': 0},
  indexValueTypes: {
    'text': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _tagTextGetId,
  setId: _tagTextSetId,
  getLinks: _tagTextGetLinks,
  attachLinks: _tagTextAttachLinks,
  serializeNative: _tagTextSerializeNative,
  deserializeNative: _tagTextDeserializeNative,
  deserializePropNative: _tagTextDeserializePropNative,
  serializeWeb: _tagTextSerializeWeb,
  deserializeWeb: _tagTextDeserializeWeb,
  deserializePropWeb: _tagTextDeserializePropWeb,
  version: 3,
);

int? _tagTextGetId(TagText object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _tagTextSetId(TagText object, int id) {
  object.id = id;
}

List<IsarLinkBase> _tagTextGetLinks(TagText object) {
  return [];
}

void _tagTextSerializeNative(
    IsarCollection<TagText> collection,
    IsarRawObject rawObj,
    TagText object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.hashCode;
  final _hashCode = value0;
  final value1 = object.text;
  final _text = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_text.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _hashCode);
  writer.writeBytes(offsets[1], _text);
}

TagText _tagTextDeserializeNative(IsarCollection<TagText> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = TagText();
  object.id = id;
  object.text = reader.readString(offsets[1]);
  return object;
}

P _tagTextDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _tagTextSerializeWeb(
    IsarCollection<TagText> collection, TagText object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'text', object.text);
  return jsObj;
}

TagText _tagTextDeserializeWeb(
    IsarCollection<TagText> collection, dynamic jsObj) {
  final object = TagText();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.text = IsarNative.jsObjectGet(jsObj, 'text') ?? '';
  return object;
}

P _tagTextDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'text':
      return (IsarNative.jsObjectGet(jsObj, 'text') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _tagTextAttachLinks(IsarCollection col, int id, TagText object) {}

extension TagTextByIndex on IsarCollection<TagText> {
  Future<TagText?> getByText(String text) {
    return getByIndex('text', [text]);
  }

  TagText? getByTextSync(String text) {
    return getByIndexSync('text', [text]);
  }

  Future<bool> deleteByText(String text) {
    return deleteByIndex('text', [text]);
  }

  bool deleteByTextSync(String text) {
    return deleteByIndexSync('text', [text]);
  }

  Future<List<TagText?>> getAllByText(List<String> textValues) {
    final values = textValues.map((e) => [e]).toList();
    return getAllByIndex('text', values);
  }

  List<TagText?> getAllByTextSync(List<String> textValues) {
    final values = textValues.map((e) => [e]).toList();
    return getAllByIndexSync('text', values);
  }

  Future<int> deleteAllByText(List<String> textValues) {
    final values = textValues.map((e) => [e]).toList();
    return deleteAllByIndex('text', values);
  }

  int deleteAllByTextSync(List<String> textValues) {
    final values = textValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('text', values);
  }
}

extension TagTextQueryWhereSort on QueryBuilder<TagText, TagText, QWhere> {
  QueryBuilder<TagText, TagText, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<TagText, TagText, QAfterWhere> anyText() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'text'));
  }
}

extension TagTextQueryWhere on QueryBuilder<TagText, TagText, QWhereClause> {
  QueryBuilder<TagText, TagText, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<TagText, TagText, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> idBetween(
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

  QueryBuilder<TagText, TagText, QAfterWhereClause> textEqualTo(String text) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'text',
      value: [text],
    ));
  }

  QueryBuilder<TagText, TagText, QAfterWhereClause> textNotEqualTo(
      String text) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'text',
        upper: [text],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'text',
        lower: [text],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'text',
        lower: [text],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'text',
        upper: [text],
        includeUpper: false,
      ));
    }
  }
}

extension TagTextQueryFilter
    on QueryBuilder<TagText, TagText, QFilterCondition> {
  QueryBuilder<TagText, TagText, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hashCode',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'text',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<TagText, TagText, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'text',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension TagTextQueryLinks
    on QueryBuilder<TagText, TagText, QFilterCondition> {}

extension TagTextQueryWhereSortBy on QueryBuilder<TagText, TagText, QSortBy> {
  QueryBuilder<TagText, TagText, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> sortByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }
}

extension TagTextQueryWhereSortThenBy
    on QueryBuilder<TagText, TagText, QSortThenBy> {
  QueryBuilder<TagText, TagText, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<TagText, TagText, QAfterSortBy> thenByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }
}

extension TagTextQueryWhereDistinct
    on QueryBuilder<TagText, TagText, QDistinct> {
  QueryBuilder<TagText, TagText, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<TagText, TagText, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<TagText, TagText, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('text', caseSensitive: caseSensitive);
  }
}

extension TagTextQueryProperty
    on QueryBuilder<TagText, TagText, QQueryProperty> {
  QueryBuilder<TagText, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<TagText, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<TagText, String, QQueryOperations> textProperty() {
    return addPropertyNameInternal('text');
  }
}
