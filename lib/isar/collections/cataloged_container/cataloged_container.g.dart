// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'cataloged_container.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCatalogedContainerCollection on Isar {
  IsarCollection<CatalogedContainer> get catalogedContainers => getCollection();
}

const CatalogedContainerSchema = CollectionSchema(
  name: 'CatalogedContainer',
  schema:
      '{"name":"CatalogedContainer","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"containerTypeID","type":"Long"},{"name":"containerUID","type":"String"},{"name":"description","type":"String"},{"name":"name","type":"String"}],"indexes":[{"name":"containerUID","unique":true,"properties":[{"name":"containerUID","type":"Hash","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'barcodeUID': 0,
    'containerTypeID': 1,
    'containerUID': 2,
    'description': 3,
    'name': 4
  },
  listProperties: {},
  indexIds: {'containerUID': 0},
  indexValueTypes: {
    'containerUID': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _catalogedContainerGetId,
  setId: _catalogedContainerSetId,
  getLinks: _catalogedContainerGetLinks,
  attachLinks: _catalogedContainerAttachLinks,
  serializeNative: _catalogedContainerSerializeNative,
  deserializeNative: _catalogedContainerDeserializeNative,
  deserializePropNative: _catalogedContainerDeserializePropNative,
  serializeWeb: _catalogedContainerSerializeWeb,
  deserializeWeb: _catalogedContainerDeserializeWeb,
  deserializePropWeb: _catalogedContainerDeserializePropWeb,
  version: 3,
);

int? _catalogedContainerGetId(CatalogedContainer object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _catalogedContainerSetId(CatalogedContainer object, int id) {
  object.id = id;
}

List<IsarLinkBase> _catalogedContainerGetLinks(CatalogedContainer object) {
  return [];
}

void _catalogedContainerSerializeNative(
    IsarCollection<CatalogedContainer> collection,
    IsarRawObject rawObj,
    CatalogedContainer object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.barcodeUID;
  IsarUint8List? _barcodeUID;
  if (value0 != null) {
    _barcodeUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  }
  dynamicSize += (_barcodeUID?.length ?? 0) as int;
  final value1 = object.containerTypeID;
  final _containerTypeID = value1;
  final value2 = object.containerUID;
  final _containerUID = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_containerUID.length) as int;
  final value3 = object.description;
  IsarUint8List? _description;
  if (value3 != null) {
    _description = IsarBinaryWriter.utf8Encoder.convert(value3);
  }
  dynamicSize += (_description?.length ?? 0) as int;
  final value4 = object.name;
  IsarUint8List? _name;
  if (value4 != null) {
    _name = IsarBinaryWriter.utf8Encoder.convert(value4);
  }
  dynamicSize += (_name?.length ?? 0) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _barcodeUID);
  writer.writeLong(offsets[1], _containerTypeID);
  writer.writeBytes(offsets[2], _containerUID);
  writer.writeBytes(offsets[3], _description);
  writer.writeBytes(offsets[4], _name);
}

CatalogedContainer _catalogedContainerDeserializeNative(
    IsarCollection<CatalogedContainer> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CatalogedContainer();
  object.barcodeUID = reader.readStringOrNull(offsets[0]);
  object.containerTypeID = reader.readLong(offsets[1]);
  object.containerUID = reader.readString(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[4]);
  return object;
}

P _catalogedContainerDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _catalogedContainerSerializeWeb(
    IsarCollection<CatalogedContainer> collection, CatalogedContainer object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'containerTypeID', object.containerTypeID);
  IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
  IsarNative.jsObjectSet(jsObj, 'description', object.description);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  return jsObj;
}

CatalogedContainer _catalogedContainerDeserializeWeb(
    IsarCollection<CatalogedContainer> collection, dynamic jsObj) {
  final object = CatalogedContainer();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID');
  object.containerTypeID = IsarNative.jsObjectGet(jsObj, 'containerTypeID') ??
      double.negativeInfinity;
  object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
  object.description = IsarNative.jsObjectGet(jsObj, 'description');
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.name = IsarNative.jsObjectGet(jsObj, 'name');
  return object;
}

P _catalogedContainerDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID')) as P;
    case 'containerTypeID':
      return (IsarNative.jsObjectGet(jsObj, 'containerTypeID') ??
          double.negativeInfinity) as P;
    case 'containerUID':
      return (IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '') as P;
    case 'description':
      return (IsarNative.jsObjectGet(jsObj, 'description')) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name')) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _catalogedContainerAttachLinks(
    IsarCollection col, int id, CatalogedContainer object) {}

extension CatalogedContainerByIndex on IsarCollection<CatalogedContainer> {
  Future<CatalogedContainer?> getByContainerUID(String containerUID) {
    return getByIndex('containerUID', [containerUID]);
  }

  CatalogedContainer? getByContainerUIDSync(String containerUID) {
    return getByIndexSync('containerUID', [containerUID]);
  }

  Future<bool> deleteByContainerUID(String containerUID) {
    return deleteByIndex('containerUID', [containerUID]);
  }

  bool deleteByContainerUIDSync(String containerUID) {
    return deleteByIndexSync('containerUID', [containerUID]);
  }

  Future<List<CatalogedContainer?>> getAllByContainerUID(
      List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return getAllByIndex('containerUID', values);
  }

  List<CatalogedContainer?> getAllByContainerUIDSync(
      List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return getAllByIndexSync('containerUID', values);
  }

  Future<int> deleteAllByContainerUID(List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return deleteAllByIndex('containerUID', values);
  }

  int deleteAllByContainerUIDSync(List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('containerUID', values);
  }
}

extension CatalogedContainerQueryWhereSort
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QWhere> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhere>
      anyContainerUID() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'containerUID'));
  }
}

extension CatalogedContainerQueryWhere
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QWhereClause> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      idGreaterThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      idLessThan(int id, {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      containerUIDEqualTo(String containerUID) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'containerUID',
      value: [containerUID],
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      containerUIDNotEqualTo(String containerUID) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'containerUID',
        upper: [containerUID],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'containerUID',
        lower: [containerUID],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'containerUID',
        lower: [containerUID],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'containerUID',
        upper: [containerUID],
        includeUpper: false,
      ));
    }
  }
}

extension CatalogedContainerQueryFilter
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'barcodeUID',
      value: null,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'barcodeUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerTypeID',
      value: value,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerTypeID',
      value: value,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerTypeID',
      value: value,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerTypeID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerUID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'description',
      value: null,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'description',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CatalogedContainerQueryLinks
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {}

extension CatalogedContainerQueryWhereSortBy
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QSortBy> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerTypeID() {
    return addSortByInternal('containerTypeID', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerTypeIDDesc() {
    return addSortByInternal('containerTypeID', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }
}

extension CatalogedContainerQueryWhereSortThenBy
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QSortThenBy> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerTypeID() {
    return addSortByInternal('containerTypeID', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerTypeIDDesc() {
    return addSortByInternal('containerTypeID', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }
}

extension CatalogedContainerQueryWhereDistinct
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByContainerTypeID() {
    return addDistinctByInternal('containerTypeID');
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByContainerUID({bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }
}

extension CatalogedContainerQueryProperty
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QQueryProperty> {
  QueryBuilder<CatalogedContainer, String?, QQueryOperations>
      barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<CatalogedContainer, int, QQueryOperations>
      containerTypeIDProperty() {
    return addPropertyNameInternal('containerTypeID');
  }

  QueryBuilder<CatalogedContainer, String, QQueryOperations>
      containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<CatalogedContainer, String?, QQueryOperations>
      descriptionProperty() {
    return addPropertyNameInternal('description');
  }

  QueryBuilder<CatalogedContainer, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CatalogedContainer, String?, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }
}
