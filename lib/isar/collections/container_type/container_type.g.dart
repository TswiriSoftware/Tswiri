// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'container_type.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetContainerTypeCollection on Isar {
  IsarCollection<ContainerType> get containerTypes => getCollection();
}

const ContainerTypeSchema = CollectionSchema(
  name: 'ContainerType',
  schema:
      '{"name":"ContainerType","idName":"id","properties":[{"name":"canContain","type":"LongList"},{"name":"containerColor","type":"String"},{"name":"containerDescription","type":"String"},{"name":"containerTypeName","type":"String"},{"name":"enclosing","type":"Bool"},{"name":"iconData","type":"StringList"},{"name":"moveable","type":"Bool"},{"name":"preferredChildContainer","type":"Long"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'canContain': 0,
    'containerColor': 1,
    'containerDescription': 2,
    'containerTypeName': 3,
    'enclosing': 4,
    'iconData': 5,
    'moveable': 6,
    'preferredChildContainer': 7
  },
  listProperties: {'canContain', 'iconData'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _containerTypeGetId,
  setId: _containerTypeSetId,
  getLinks: _containerTypeGetLinks,
  attachLinks: _containerTypeAttachLinks,
  serializeNative: _containerTypeSerializeNative,
  deserializeNative: _containerTypeDeserializeNative,
  deserializePropNative: _containerTypeDeserializePropNative,
  serializeWeb: _containerTypeSerializeWeb,
  deserializeWeb: _containerTypeDeserializeWeb,
  deserializePropWeb: _containerTypeDeserializePropWeb,
  version: 3,
);

int? _containerTypeGetId(ContainerType object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _containerTypeSetId(ContainerType object, int id) {
  object.id = id;
}

List<IsarLinkBase> _containerTypeGetLinks(ContainerType object) {
  return [];
}

const _containerTypeColorConverter = ColorConverter();
const _containerTypeIconConverter = IconConverter();

void _containerTypeSerializeNative(
    IsarCollection<ContainerType> collection,
    IsarRawObject rawObj,
    ContainerType object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.canContain;
  dynamicSize += (value0.length) * 8;
  final _canContain = value0;
  final value1 = _containerTypeColorConverter.toIsar(object.containerColor);
  final _containerColor = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_containerColor.length) as int;
  final value2 = object.containerDescription;
  final _containerDescription = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_containerDescription.length) as int;
  final value3 = object.containerTypeName;
  final _containerTypeName = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_containerTypeName.length) as int;
  final value4 = object.enclosing;
  final _enclosing = value4;
  final value5 = _containerTypeIconConverter.toIsar(object.iconData);
  dynamicSize += (value5.length) * 8;
  final bytesList5 = <IsarUint8List>[];
  for (var str in value5) {
    final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
    bytesList5.add(bytes);
    dynamicSize += bytes.length as int;
  }
  final _iconData = bytesList5;
  final value6 = object.moveable;
  final _moveable = value6;
  final value7 = object.preferredChildContainer;
  final _preferredChildContainer = value7;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLongList(offsets[0], _canContain);
  writer.writeBytes(offsets[1], _containerColor);
  writer.writeBytes(offsets[2], _containerDescription);
  writer.writeBytes(offsets[3], _containerTypeName);
  writer.writeBool(offsets[4], _enclosing);
  writer.writeStringList(offsets[5], _iconData);
  writer.writeBool(offsets[6], _moveable);
  writer.writeLong(offsets[7], _preferredChildContainer);
}

ContainerType _containerTypeDeserializeNative(
    IsarCollection<ContainerType> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ContainerType();
  object.canContain = reader.readLongList(offsets[0]) ?? [];
  object.containerColor =
      _containerTypeColorConverter.fromIsar(reader.readString(offsets[1]));
  object.containerDescription = reader.readString(offsets[2]);
  object.containerTypeName = reader.readString(offsets[3]);
  object.enclosing = reader.readBool(offsets[4]);
  object.iconData = _containerTypeIconConverter
      .fromIsar(reader.readStringList(offsets[5]) ?? []);
  object.id = id;
  object.moveable = reader.readBool(offsets[6]);
  object.preferredChildContainer = reader.readLong(offsets[7]);
  return object;
}

P _containerTypeDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLongList(offset) ?? []) as P;
    case 1:
      return (_containerTypeColorConverter.fromIsar(reader.readString(offset)))
          as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (_containerTypeIconConverter
          .fromIsar(reader.readStringList(offset) ?? [])) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _containerTypeSerializeWeb(
    IsarCollection<ContainerType> collection, ContainerType object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'canContain', object.canContain);
  IsarNative.jsObjectSet(jsObj, 'containerColor',
      _containerTypeColorConverter.toIsar(object.containerColor));
  IsarNative.jsObjectSet(
      jsObj, 'containerDescription', object.containerDescription);
  IsarNative.jsObjectSet(jsObj, 'containerTypeName', object.containerTypeName);
  IsarNative.jsObjectSet(jsObj, 'enclosing', object.enclosing);
  IsarNative.jsObjectSet(
      jsObj, 'iconData', _containerTypeIconConverter.toIsar(object.iconData));
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'moveable', object.moveable);
  IsarNative.jsObjectSet(
      jsObj, 'preferredChildContainer', object.preferredChildContainer);
  return jsObj;
}

ContainerType _containerTypeDeserializeWeb(
    IsarCollection<ContainerType> collection, dynamic jsObj) {
  final object = ContainerType();
  object.canContain = (IsarNative.jsObjectGet(jsObj, 'canContain') as List?)
          ?.map((e) => e ?? double.negativeInfinity)
          .toList()
          .cast<int>() ??
      [];
  object.containerColor = _containerTypeColorConverter
      .fromIsar(IsarNative.jsObjectGet(jsObj, 'containerColor') ?? '');
  object.containerDescription =
      IsarNative.jsObjectGet(jsObj, 'containerDescription') ?? '';
  object.containerTypeName =
      IsarNative.jsObjectGet(jsObj, 'containerTypeName') ?? '';
  object.enclosing = IsarNative.jsObjectGet(jsObj, 'enclosing') ?? false;
  object.iconData = _containerTypeIconConverter.fromIsar(
      (IsarNative.jsObjectGet(jsObj, 'iconData') as List?)
              ?.map((e) => e ?? '')
              .toList()
              .cast<String>() ??
          []);
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.moveable = IsarNative.jsObjectGet(jsObj, 'moveable') ?? false;
  object.preferredChildContainer =
      IsarNative.jsObjectGet(jsObj, 'preferredChildContainer') ??
          double.negativeInfinity;
  return object;
}

P _containerTypeDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'canContain':
      return ((IsarNative.jsObjectGet(jsObj, 'canContain') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<int>() ??
          []) as P;
    case 'containerColor':
      return (_containerTypeColorConverter.fromIsar(
          IsarNative.jsObjectGet(jsObj, 'containerColor') ?? '')) as P;
    case 'containerDescription':
      return (IsarNative.jsObjectGet(jsObj, 'containerDescription') ?? '') as P;
    case 'containerTypeName':
      return (IsarNative.jsObjectGet(jsObj, 'containerTypeName') ?? '') as P;
    case 'enclosing':
      return (IsarNative.jsObjectGet(jsObj, 'enclosing') ?? false) as P;
    case 'iconData':
      return (_containerTypeIconConverter.fromIsar(
          (IsarNative.jsObjectGet(jsObj, 'iconData') as List?)
                  ?.map((e) => e ?? '')
                  .toList()
                  .cast<String>() ??
              [])) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'moveable':
      return (IsarNative.jsObjectGet(jsObj, 'moveable') ?? false) as P;
    case 'preferredChildContainer':
      return (IsarNative.jsObjectGet(jsObj, 'preferredChildContainer') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _containerTypeAttachLinks(
    IsarCollection col, int id, ContainerType object) {}

extension ContainerTypeQueryWhereSort
    on QueryBuilder<ContainerType, ContainerType, QWhere> {
  QueryBuilder<ContainerType, ContainerType, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ContainerTypeQueryWhere
    on QueryBuilder<ContainerType, ContainerType, QWhereClause> {
  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idBetween(
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

extension ContainerTypeQueryFilter
    on QueryBuilder<ContainerType, ContainerType, QFilterCondition> {
  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'canContain',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'canContain',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'canContain',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'canContain',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorEqualTo(
    Color value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerColor',
      value: _containerTypeColorConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorGreaterThan(
    Color value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerColor',
      value: _containerTypeColorConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorLessThan(
    Color value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerColor',
      value: _containerTypeColorConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorBetween(
    Color lower,
    Color upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerColor',
      lower: _containerTypeColorConverter.toIsar(lower),
      includeLower: includeLower,
      upper: _containerTypeColorConverter.toIsar(upper),
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorStartsWith(
    Color value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerColor',
      value: _containerTypeColorConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorEndsWith(
    Color value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerColor',
      value: _containerTypeColorConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorContains(Color value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerColor',
      value: _containerTypeColorConverter.toIsar(value),
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerColor',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerDescription',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerDescription',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerDescription',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerDescription',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerDescription',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerDescription',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerDescription',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerDescription',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerTypeName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerTypeName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerTypeName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerTypeName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerTypeName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerTypeName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerTypeName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeNameMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerTypeName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      enclosingEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'enclosing',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'iconData',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'iconData',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'iconData',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'iconData',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'iconData',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'iconData',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'iconData',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      iconDataAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'iconData',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      moveableEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'moveable',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      preferredChildContainerEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'preferredChildContainer',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      preferredChildContainerGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'preferredChildContainer',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      preferredChildContainerLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'preferredChildContainer',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      preferredChildContainerBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'preferredChildContainer',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ContainerTypeQueryLinks
    on QueryBuilder<ContainerType, ContainerType, QFilterCondition> {}

extension ContainerTypeQueryWhereSortBy
    on QueryBuilder<ContainerType, ContainerType, QSortBy> {
  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerColor() {
    return addSortByInternal('containerColor', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerColorDesc() {
    return addSortByInternal('containerColor', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerDescription() {
    return addSortByInternal('containerDescription', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerDescriptionDesc() {
    return addSortByInternal('containerDescription', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerTypeName() {
    return addSortByInternal('containerTypeName', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerTypeNameDesc() {
    return addSortByInternal('containerTypeName', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortByEnclosing() {
    return addSortByInternal('enclosing', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByEnclosingDesc() {
    return addSortByInternal('enclosing', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortByMoveable() {
    return addSortByInternal('moveable', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByMoveableDesc() {
    return addSortByInternal('moveable', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByPreferredChildContainer() {
    return addSortByInternal('preferredChildContainer', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByPreferredChildContainerDesc() {
    return addSortByInternal('preferredChildContainer', Sort.desc);
  }
}

extension ContainerTypeQueryWhereSortThenBy
    on QueryBuilder<ContainerType, ContainerType, QSortThenBy> {
  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerColor() {
    return addSortByInternal('containerColor', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerColorDesc() {
    return addSortByInternal('containerColor', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerDescription() {
    return addSortByInternal('containerDescription', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerDescriptionDesc() {
    return addSortByInternal('containerDescription', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerTypeName() {
    return addSortByInternal('containerTypeName', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerTypeNameDesc() {
    return addSortByInternal('containerTypeName', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenByEnclosing() {
    return addSortByInternal('enclosing', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByEnclosingDesc() {
    return addSortByInternal('enclosing', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenByMoveable() {
    return addSortByInternal('moveable', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByMoveableDesc() {
    return addSortByInternal('moveable', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByPreferredChildContainer() {
    return addSortByInternal('preferredChildContainer', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByPreferredChildContainerDesc() {
    return addSortByInternal('preferredChildContainer', Sort.desc);
  }
}

extension ContainerTypeQueryWhereDistinct
    on QueryBuilder<ContainerType, ContainerType, QDistinct> {
  QueryBuilder<ContainerType, ContainerType, QDistinct>
      distinctByContainerColor({bool caseSensitive = true}) {
    return addDistinctByInternal('containerColor',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct>
      distinctByContainerDescription({bool caseSensitive = true}) {
    return addDistinctByInternal('containerDescription',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct>
      distinctByContainerTypeName({bool caseSensitive = true}) {
    return addDistinctByInternal('containerTypeName',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct> distinctByEnclosing() {
    return addDistinctByInternal('enclosing');
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct> distinctByMoveable() {
    return addDistinctByInternal('moveable');
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct>
      distinctByPreferredChildContainer() {
    return addDistinctByInternal('preferredChildContainer');
  }
}

extension ContainerTypeQueryProperty
    on QueryBuilder<ContainerType, ContainerType, QQueryProperty> {
  QueryBuilder<ContainerType, List<int>, QQueryOperations>
      canContainProperty() {
    return addPropertyNameInternal('canContain');
  }

  QueryBuilder<ContainerType, Color, QQueryOperations>
      containerColorProperty() {
    return addPropertyNameInternal('containerColor');
  }

  QueryBuilder<ContainerType, String, QQueryOperations>
      containerDescriptionProperty() {
    return addPropertyNameInternal('containerDescription');
  }

  QueryBuilder<ContainerType, String, QQueryOperations>
      containerTypeNameProperty() {
    return addPropertyNameInternal('containerTypeName');
  }

  QueryBuilder<ContainerType, bool, QQueryOperations> enclosingProperty() {
    return addPropertyNameInternal('enclosing');
  }

  QueryBuilder<ContainerType, IconData, QQueryOperations> iconDataProperty() {
    return addPropertyNameInternal('iconData');
  }

  QueryBuilder<ContainerType, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerType, bool, QQueryOperations> moveableProperty() {
    return addPropertyNameInternal('moveable');
  }

  QueryBuilder<ContainerType, int, QQueryOperations>
      preferredChildContainerProperty() {
    return addPropertyNameInternal('preferredChildContainer');
  }
}
