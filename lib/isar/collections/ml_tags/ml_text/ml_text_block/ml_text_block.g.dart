// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_text_block.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLTextBlockCollection on Isar {
  IsarCollection<MLTextBlock> get mLTextBlocks => getCollection();
}

const MLTextBlockSchema = CollectionSchema(
  name: 'MLTextBlock',
  schema:
      '{"name":"MLTextBlock","idName":"id","properties":[{"name":"cornerPoints","type":"LongList"},{"name":"recognizedLanguages","type":"StringList"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'cornerPoints': 0, 'recognizedLanguages': 1},
  listProperties: {'cornerPoints', 'recognizedLanguages'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLTextBlockGetId,
  setId: _mLTextBlockSetId,
  getLinks: _mLTextBlockGetLinks,
  attachLinks: _mLTextBlockAttachLinks,
  serializeNative: _mLTextBlockSerializeNative,
  deserializeNative: _mLTextBlockDeserializeNative,
  deserializePropNative: _mLTextBlockDeserializePropNative,
  serializeWeb: _mLTextBlockSerializeWeb,
  deserializeWeb: _mLTextBlockDeserializeWeb,
  deserializePropWeb: _mLTextBlockDeserializePropWeb,
  version: 3,
);

int? _mLTextBlockGetId(MLTextBlock object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLTextBlockSetId(MLTextBlock object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLTextBlockGetLinks(MLTextBlock object) {
  return [];
}

const _mLTextBlockCornerPointConverter = CornerPointConverter();

void _mLTextBlockSerializeNative(
    IsarCollection<MLTextBlock> collection,
    IsarRawObject rawObj,
    MLTextBlock object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = _mLTextBlockCornerPointConverter.toIsar(object.cornerPoints);
  dynamicSize += (value0.length) * 8;
  final _cornerPoints = value0;
  final value1 = object.recognizedLanguages;
  dynamicSize += (value1.length) * 8;
  final bytesList1 = <IsarUint8List>[];
  for (var str in value1) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList1.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _recognizedLanguages = bytesList1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLongList(offsets[0], _cornerPoints);
  writer.writeStringList(offsets[1], _recognizedLanguages);
}

MLTextBlock _mLTextBlockDeserializeNative(
    IsarCollection<MLTextBlock> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = MLTextBlock();
  object.cornerPoints = _mLTextBlockCornerPointConverter
      .fromIsar(reader.readLongList(offsets[0]) ?? []);
  object.id = id;
  object.recognizedLanguages = reader.readStringList(offsets[1]) ?? [];
  return object;
}

P _mLTextBlockDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (_mLTextBlockCornerPointConverter
          .fromIsar(reader.readLongList(offset) ?? [])) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLTextBlockSerializeWeb(
    IsarCollection<MLTextBlock> collection, MLTextBlock object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'cornerPoints',
      _mLTextBlockCornerPointConverter.toIsar(object.cornerPoints));
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(
      jsObj, 'recognizedLanguages', object.recognizedLanguages);
  return jsObj;
}

MLTextBlock _mLTextBlockDeserializeWeb(
    IsarCollection<MLTextBlock> collection, dynamic jsObj) {
  final object = MLTextBlock();
  object.cornerPoints = _mLTextBlockCornerPointConverter.fromIsar(
      (IsarNative.jsObjectGet(jsObj, 'cornerPoints') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<int>() ??
          []);
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.recognizedLanguages =
      (IsarNative.jsObjectGet(jsObj, 'recognizedLanguages') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          [];
  return object;
}

P _mLTextBlockDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'cornerPoints':
      return (_mLTextBlockCornerPointConverter.fromIsar(
          (IsarNative.jsObjectGet(jsObj, 'cornerPoints') as List?)
                  ?.map((e) => e ?? double.negativeInfinity)
                  .toList()
                  .cast<int>() ??
              [])) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'recognizedLanguages':
      return ((IsarNative.jsObjectGet(jsObj, 'recognizedLanguages') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _mLTextBlockAttachLinks(IsarCollection col, int id, MLTextBlock object) {}

extension MLTextBlockQueryWhereSort
    on QueryBuilder<MLTextBlock, MLTextBlock, QWhere> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension MLTextBlockQueryWhere
    on QueryBuilder<MLTextBlock, MLTextBlock, QWhereClause> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idNotEqualTo(
      int id) {
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterWhereClause> idBetween(
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
}

extension MLTextBlockQueryFilter
    on QueryBuilder<MLTextBlock, MLTextBlock, QFilterCondition> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      cornerPointsAnyEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      cornerPointsAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      cornerPointsAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      cornerPointsAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'cornerPoints',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'recognizedLanguages',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyContains(String value,
          {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterFilterCondition>
      recognizedLanguagesAnyMatches(String pattern,
          {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'recognizedLanguages',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension MLTextBlockQueryLinks
    on QueryBuilder<MLTextBlock, MLTextBlock, QFilterCondition> {}

extension MLTextBlockQueryWhereSortBy
    on QueryBuilder<MLTextBlock, MLTextBlock, QSortBy> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension MLTextBlockQueryWhereSortThenBy
    on QueryBuilder<MLTextBlock, MLTextBlock, QSortThenBy> {
  QueryBuilder<MLTextBlock, MLTextBlock, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLTextBlock, MLTextBlock, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension MLTextBlockQueryWhereDistinct
    on QueryBuilder<MLTextBlock, MLTextBlock, QDistinct> {
  QueryBuilder<MLTextBlock, MLTextBlock, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }
}

extension MLTextBlockQueryProperty
    on QueryBuilder<MLTextBlock, MLTextBlock, QQueryProperty> {
  QueryBuilder<MLTextBlock, List<Point<int>>, QQueryOperations>
      cornerPointsProperty() {
    return addPropertyNameInternal('cornerPoints');
  }

  QueryBuilder<MLTextBlock, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLTextBlock, List<String>, QQueryOperations>
      recognizedLanguagesProperty() {
    return addPropertyNameInternal('recognizedLanguages');
  }
}
