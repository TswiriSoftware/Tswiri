// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'ml_text_line.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetMLTextLineCollection on Isar {
  IsarCollection<MLTextLine> get mLTextLines => getCollection();
}

const MLTextLineSchema = CollectionSchema(
  name: 'MLTextLine',
  schema:
      '{"name":"MLTextLine","idName":"id","properties":[{"name":"blockID","type":"Long"},{"name":"blockIndex","type":"Long"},{"name":"cornerPoints","type":"LongList"},{"name":"recognizedLanguages","type":"StringList"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'blockID': 0,
    'blockIndex': 1,
    'cornerPoints': 2,
    'recognizedLanguages': 3
  },
  listProperties: {'cornerPoints', 'recognizedLanguages'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _mLTextLineGetId,
  setId: _mLTextLineSetId,
  getLinks: _mLTextLineGetLinks,
  attachLinks: _mLTextLineAttachLinks,
  serializeNative: _mLTextLineSerializeNative,
  deserializeNative: _mLTextLineDeserializeNative,
  deserializePropNative: _mLTextLineDeserializePropNative,
  serializeWeb: _mLTextLineSerializeWeb,
  deserializeWeb: _mLTextLineDeserializeWeb,
  deserializePropWeb: _mLTextLineDeserializePropWeb,
  version: 3,
);

int? _mLTextLineGetId(MLTextLine object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _mLTextLineSetId(MLTextLine object, int id) {
  object.id = id;
}

List<IsarLinkBase> _mLTextLineGetLinks(MLTextLine object) {
  return [];
}

const _mLTextLineCornerPointConverter = CornerPointConverter();

void _mLTextLineSerializeNative(
    IsarCollection<MLTextLine> collection,
    IsarRawObject rawObj,
    MLTextLine object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.blockID;
  final _blockID = value0;
  final value1 = object.blockIndex;
  final _blockIndex = value1;
  final value2 = _mLTextLineCornerPointConverter.toIsar(object.cornerPoints);
  dynamicSize += (value2.length) * 8;
  final _cornerPoints = value2;
  final value3 = object.recognizedLanguages;
  dynamicSize += (value3.length) * 8;
  final bytesList3 = <IsarUint8List>[];
  for (var str in value3) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList3.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _recognizedLanguages = bytesList3;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _blockID);
  writer.writeLong(offsets[1], _blockIndex);
  writer.writeLongList(offsets[2], _cornerPoints);
  writer.writeStringList(offsets[3], _recognizedLanguages);
}

MLTextLine _mLTextLineDeserializeNative(IsarCollection<MLTextLine> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = MLTextLine();
  object.blockID = reader.readLong(offsets[0]);
  object.blockIndex = reader.readLong(offsets[1]);
  object.cornerPoints = _mLTextLineCornerPointConverter
      .fromIsar(reader.readLongList(offsets[2]) ?? []);
  object.id = id;
  object.recognizedLanguages = reader.readStringList(offsets[3]) ?? [];
  return object;
}

P _mLTextLineDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (_mLTextLineCornerPointConverter
          .fromIsar(reader.readLongList(offset) ?? [])) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _mLTextLineSerializeWeb(
    IsarCollection<MLTextLine> collection, MLTextLine object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'blockID', object.blockID);
  IsarNative.jsObjectSet(jsObj, 'blockIndex', object.blockIndex);
  IsarNative.jsObjectSet(jsObj, 'cornerPoints',
      _mLTextLineCornerPointConverter.toIsar(object.cornerPoints));
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(
      jsObj, 'recognizedLanguages', object.recognizedLanguages);
  return jsObj;
}

MLTextLine _mLTextLineDeserializeWeb(
    IsarCollection<MLTextLine> collection, dynamic jsObj) {
  final object = MLTextLine();
  object.blockID =
      IsarNative.jsObjectGet(jsObj, 'blockID') ?? double.negativeInfinity;
  object.blockIndex =
      IsarNative.jsObjectGet(jsObj, 'blockIndex') ?? double.negativeInfinity;
  object.cornerPoints = _mLTextLineCornerPointConverter.fromIsar(
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

P _mLTextLineDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'blockID':
      return (IsarNative.jsObjectGet(jsObj, 'blockID') ??
          double.negativeInfinity) as P;
    case 'blockIndex':
      return (IsarNative.jsObjectGet(jsObj, 'blockIndex') ??
          double.negativeInfinity) as P;
    case 'cornerPoints':
      return (_mLTextLineCornerPointConverter.fromIsar(
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

void _mLTextLineAttachLinks(IsarCollection col, int id, MLTextLine object) {}

extension MLTextLineQueryWhereSort
    on QueryBuilder<MLTextLine, MLTextLine, QWhere> {
  QueryBuilder<MLTextLine, MLTextLine, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension MLTextLineQueryWhere
    on QueryBuilder<MLTextLine, MLTextLine, QWhereClause> {
  QueryBuilder<MLTextLine, MLTextLine, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterWhereClause> idBetween(
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

extension MLTextLineQueryFilter
    on QueryBuilder<MLTextLine, MLTextLine, QFilterCondition> {
  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> blockIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'blockID',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
      blockIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'blockID',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> blockIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'blockID',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> blockIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'blockID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> blockIndexEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'blockIndex',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
      blockIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'blockIndex',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
      blockIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'blockIndex',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> blockIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'blockIndex',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
      cornerPointsAnyEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'cornerPoints',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
      recognizedLanguagesAnyContains(String value,
          {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'recognizedLanguages',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterFilterCondition>
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

extension MLTextLineQueryLinks
    on QueryBuilder<MLTextLine, MLTextLine, QFilterCondition> {}

extension MLTextLineQueryWhereSortBy
    on QueryBuilder<MLTextLine, MLTextLine, QSortBy> {
  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> sortByBlockID() {
    return addSortByInternal('blockID', Sort.asc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> sortByBlockIDDesc() {
    return addSortByInternal('blockID', Sort.desc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> sortByBlockIndex() {
    return addSortByInternal('blockIndex', Sort.asc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> sortByBlockIndexDesc() {
    return addSortByInternal('blockIndex', Sort.desc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension MLTextLineQueryWhereSortThenBy
    on QueryBuilder<MLTextLine, MLTextLine, QSortThenBy> {
  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> thenByBlockID() {
    return addSortByInternal('blockID', Sort.asc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> thenByBlockIDDesc() {
    return addSortByInternal('blockID', Sort.desc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> thenByBlockIndex() {
    return addSortByInternal('blockIndex', Sort.asc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> thenByBlockIndexDesc() {
    return addSortByInternal('blockIndex', Sort.desc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<MLTextLine, MLTextLine, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }
}

extension MLTextLineQueryWhereDistinct
    on QueryBuilder<MLTextLine, MLTextLine, QDistinct> {
  QueryBuilder<MLTextLine, MLTextLine, QDistinct> distinctByBlockID() {
    return addDistinctByInternal('blockID');
  }

  QueryBuilder<MLTextLine, MLTextLine, QDistinct> distinctByBlockIndex() {
    return addDistinctByInternal('blockIndex');
  }

  QueryBuilder<MLTextLine, MLTextLine, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }
}

extension MLTextLineQueryProperty
    on QueryBuilder<MLTextLine, MLTextLine, QQueryProperty> {
  QueryBuilder<MLTextLine, int, QQueryOperations> blockIDProperty() {
    return addPropertyNameInternal('blockID');
  }

  QueryBuilder<MLTextLine, int, QQueryOperations> blockIndexProperty() {
    return addPropertyNameInternal('blockIndex');
  }

  QueryBuilder<MLTextLine, List<Point<int>>, QQueryOperations>
      cornerPointsProperty() {
    return addPropertyNameInternal('cornerPoints');
  }

  QueryBuilder<MLTextLine, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<MLTextLine, List<String>, QQueryOperations>
      recognizedLanguagesProperty() {
    return addPropertyNameInternal('recognizedLanguages');
  }
}
