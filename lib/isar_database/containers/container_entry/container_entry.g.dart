// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'container_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetContainerEntryCollection on Isar {
  IsarCollection<ContainerEntry> get containerEntrys => getCollection();
}

const ContainerEntrySchema = CollectionSchema(
  name: 'ContainerEntry',
  schema:
      '{"name":"ContainerEntry","idName":"id","properties":[{"name":"barcodeUID","type":"String"},{"name":"containerType","type":"String"},{"name":"containerUID","type":"String"},{"name":"description","type":"String"},{"name":"name","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'barcodeUID': 0,
    'containerType': 1,
    'containerUID': 2,
    'description': 3,
    'name': 4
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _containerEntryGetId,
  setId: _containerEntrySetId,
  getLinks: _containerEntryGetLinks,
  attachLinks: _containerEntryAttachLinks,
  serializeNative: _containerEntrySerializeNative,
  deserializeNative: _containerEntryDeserializeNative,
  deserializePropNative: _containerEntryDeserializePropNative,
  serializeWeb: _containerEntrySerializeWeb,
  deserializeWeb: _containerEntryDeserializeWeb,
  deserializePropWeb: _containerEntryDeserializePropWeb,
  version: 3,
);

int? _containerEntryGetId(ContainerEntry object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _containerEntrySetId(ContainerEntry object, int id) {
  object.id = id;
}

List<IsarLinkBase> _containerEntryGetLinks(ContainerEntry object) {
  return [];
}

void _containerEntrySerializeNative(
    IsarCollection<ContainerEntry> collection,
    IsarRawObject rawObj,
    ContainerEntry object,
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
  final value1 = object.containerType;
  final _containerType = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_containerType.length) as int;
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
  writer.writeBytes(offsets[1], _containerType);
  writer.writeBytes(offsets[2], _containerUID);
  writer.writeBytes(offsets[3], _description);
  writer.writeBytes(offsets[4], _name);
}

ContainerEntry _containerEntryDeserializeNative(
    IsarCollection<ContainerEntry> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ContainerEntry();
  object.barcodeUID = reader.readStringOrNull(offsets[0]);
  object.containerType = reader.readString(offsets[1]);
  object.containerUID = reader.readString(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[4]);
  return object;
}

P _containerEntryDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
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

dynamic _containerEntrySerializeWeb(
    IsarCollection<ContainerEntry> collection, ContainerEntry object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'barcodeUID', object.barcodeUID);
  IsarNative.jsObjectSet(jsObj, 'containerType', object.containerType);
  IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
  IsarNative.jsObjectSet(jsObj, 'description', object.description);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  return jsObj;
}

ContainerEntry _containerEntryDeserializeWeb(
    IsarCollection<ContainerEntry> collection, dynamic jsObj) {
  final object = ContainerEntry();
  object.barcodeUID = IsarNative.jsObjectGet(jsObj, 'barcodeUID');
  object.containerType = IsarNative.jsObjectGet(jsObj, 'containerType') ?? '';
  object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID') ?? '';
  object.description = IsarNative.jsObjectGet(jsObj, 'description');
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.name = IsarNative.jsObjectGet(jsObj, 'name');
  return object;
}

P _containerEntryDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'barcodeUID':
      return (IsarNative.jsObjectGet(jsObj, 'barcodeUID')) as P;
    case 'containerType':
      return (IsarNative.jsObjectGet(jsObj, 'containerType') ?? '') as P;
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

void _containerEntryAttachLinks(
    IsarCollection col, int id, ContainerEntry object) {}

extension ContainerEntryQueryWhereSort
    on QueryBuilder<ContainerEntry, ContainerEntry, QWhere> {
  QueryBuilder<ContainerEntry, ContainerEntry, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ContainerEntryQueryWhere
    on QueryBuilder<ContainerEntry, ContainerEntry, QWhereClause> {
  QueryBuilder<ContainerEntry, ContainerEntry, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterWhereClause> idBetween(
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

extension ContainerEntryQueryFilter
    on QueryBuilder<ContainerEntry, ContainerEntry, QFilterCondition> {
  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      barcodeUIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'barcodeUID',
      value: null,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'barcodeUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'barcodeUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerTypeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      descriptionIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'description',
      value: null,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'description',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'description',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      nameIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'name',
      value: null,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
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

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ContainerEntryQueryLinks
    on QueryBuilder<ContainerEntry, ContainerEntry, QFilterCondition> {}

extension ContainerEntryQueryWhereSortBy
    on QueryBuilder<ContainerEntry, ContainerEntry, QSortBy> {
  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByContainerType() {
    return addSortByInternal('containerType', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByContainerTypeDesc() {
    return addSortByInternal('containerType', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      sortByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }
}

extension ContainerEntryQueryWhereSortThenBy
    on QueryBuilder<ContainerEntry, ContainerEntry, QSortThenBy> {
  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByBarcodeUID() {
    return addSortByInternal('barcodeUID', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return addSortByInternal('barcodeUID', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByContainerType() {
    return addSortByInternal('containerType', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByContainerTypeDesc() {
    return addSortByInternal('containerType', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByDescription() {
    return addSortByInternal('description', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy>
      thenByDescriptionDesc() {
    return addSortByInternal('description', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }
}

extension ContainerEntryQueryWhereDistinct
    on QueryBuilder<ContainerEntry, ContainerEntry, QDistinct> {
  QueryBuilder<ContainerEntry, ContainerEntry, QDistinct> distinctByBarcodeUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('barcodeUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QDistinct>
      distinctByContainerType({bool caseSensitive = true}) {
    return addDistinctByInternal('containerType', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QDistinct>
      distinctByContainerUID({bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('description', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerEntry, ContainerEntry, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }
}

extension ContainerEntryQueryProperty
    on QueryBuilder<ContainerEntry, ContainerEntry, QQueryProperty> {
  QueryBuilder<ContainerEntry, String?, QQueryOperations> barcodeUIDProperty() {
    return addPropertyNameInternal('barcodeUID');
  }

  QueryBuilder<ContainerEntry, String, QQueryOperations>
      containerTypeProperty() {
    return addPropertyNameInternal('containerType');
  }

  QueryBuilder<ContainerEntry, String, QQueryOperations>
      containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<ContainerEntry, String?, QQueryOperations>
      descriptionProperty() {
    return addPropertyNameInternal('description');
  }

  QueryBuilder<ContainerEntry, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerEntry, String?, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }
}
