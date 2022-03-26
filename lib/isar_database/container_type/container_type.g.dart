// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_type.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetContainerTypeCollection on Isar {
  IsarCollection<ContainerType> get containerTypes {
    return getCollection('ContainerType');
  }
}

final ContainerTypeSchema = CollectionSchema(
  name: 'ContainerType',
  schema:
      '{"name":"ContainerType","idName":"id","properties":[{"name":"canBeChildrensOrigin","type":"Bool"},{"name":"canContain","type":"StringList"},{"name":"containerColor","type":"String"},{"name":"containerType","type":"String"},{"name":"structured","type":"Bool"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ContainerTypeNativeAdapter(),
  webAdapter: const _ContainerTypeWebAdapter(),
  idName: 'id',
  propertyIds: {
    'canBeChildrensOrigin': 0,
    'canContain': 1,
    'containerColor': 2,
    'containerType': 3,
    'structured': 4
  },
  listProperties: {'canContain'},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _ContainerTypeWebAdapter extends IsarWebTypeAdapter<ContainerType> {
  const _ContainerTypeWebAdapter();

  @override
  Object serialize(
      IsarCollection<ContainerType> collection, ContainerType object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'canBeChildrensOrigin', object.canBeOrigin);
    IsarNative.jsObjectSet(jsObj, 'canContain', object.canContain);
    IsarNative.jsObjectSet(jsObj, 'containerColor', object.containerColor);
    IsarNative.jsObjectSet(jsObj, 'containerType', object.containerType);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'structured', object.structured);
    return jsObj;
  }

  @override
  ContainerType deserialize(
      IsarCollection<ContainerType> collection, dynamic jsObj) {
    final object = ContainerType();
    object.canBeOrigin =
        IsarNative.jsObjectGet(jsObj, 'canBeChildrensOrigin') ?? false;
    object.canContain = (IsarNative.jsObjectGet(jsObj, 'canContain') as List?)
            ?.map((e) => e ?? '')
            .toList()
            .cast<String>() ??
        [];
    object.containerColor =
        IsarNative.jsObjectGet(jsObj, 'containerColor') ?? '';
    object.containerType = IsarNative.jsObjectGet(jsObj, 'containerType') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    object.structured = IsarNative.jsObjectGet(jsObj, 'structured') ?? false;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'canBeChildrensOrigin':
        return (IsarNative.jsObjectGet(jsObj, 'canBeChildrensOrigin') ?? false)
            as P;
      case 'canContain':
        return ((IsarNative.jsObjectGet(jsObj, 'canContain') as List?)
                ?.map((e) => e ?? '')
                .toList()
                .cast<String>() ??
            []) as P;
      case 'containerColor':
        return (IsarNative.jsObjectGet(jsObj, 'containerColor') ?? '') as P;
      case 'containerType':
        return (IsarNative.jsObjectGet(jsObj, 'containerType') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'structured':
        return (IsarNative.jsObjectGet(jsObj, 'structured') ?? false) as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerType object) {}
}

class _ContainerTypeNativeAdapter extends IsarNativeTypeAdapter<ContainerType> {
  const _ContainerTypeNativeAdapter();

  @override
  void serialize(
      IsarCollection<ContainerType> collection,
      IsarRawObject rawObj,
      ContainerType object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.canBeOrigin;
    final _canBeChildrensOrigin = value0;
    final value1 = object.canContain;
    dynamicSize += (value1.length) * 8;
    final bytesList1 = <IsarUint8List>[];
    for (var str in value1) {
      final bytes = IsarBinaryWriter.utf8Encoder.convert(str);
      bytesList1.add(bytes);
      dynamicSize += bytes.length as int;
    }
    final _canContain = bytesList1;
    final value2 = object.containerColor;
    final _containerColor = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_containerColor.length) as int;
    final value3 = object.containerType;
    final _containerType = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_containerType.length) as int;
    final value4 = object.structured;
    final _structured = value4;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBool(offsets[0], _canBeChildrensOrigin);
    writer.writeStringList(offsets[1], _canContain);
    writer.writeBytes(offsets[2], _containerColor);
    writer.writeBytes(offsets[3], _containerType);
    writer.writeBool(offsets[4], _structured);
  }

  @override
  ContainerType deserialize(IsarCollection<ContainerType> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = ContainerType();
    object.canBeOrigin = reader.readBool(offsets[0]);
    object.canContain = reader.readStringList(offsets[1]) ?? [];
    object.containerColor = reader.readString(offsets[2]);
    object.containerType = reader.readString(offsets[3]);
    object.id = id;
    object.structured = reader.readBool(offsets[4]);
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readBool(offset)) as P;
      case 1:
        return (reader.readStringList(offset) ?? []) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readBool(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ContainerType object) {}
}

extension ContainerTypeQueryWhereSort
    on QueryBuilder<ContainerType, ContainerType, QWhere> {
  QueryBuilder<ContainerType, ContainerType, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ContainerTypeQueryWhere
    on QueryBuilder<ContainerType, ContainerType, QWhereClause> {
  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }
}

extension ContainerTypeQueryFilter
    on QueryBuilder<ContainerType, ContainerType, QFilterCondition> {
  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canBeChildrensOriginEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'canBeChildrensOrigin',
      value: value,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'canContain',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'canContain',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'canContain',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'canContain',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'canContain',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'canContain',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'canContain',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      canContainAnyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'canContain',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'containerColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'containerColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'containerColor',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'containerColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'containerColor',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerColorContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerColor',
      value: value,
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
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

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContainerType, ContainerType, QAfterFilterCondition>
      containerTypeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerType',
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
      structuredEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'structured',
      value: value,
    ));
  }
}

extension ContainerTypeQueryLinks
    on QueryBuilder<ContainerType, ContainerType, QFilterCondition> {}

extension ContainerTypeQueryWhereSortBy
    on QueryBuilder<ContainerType, ContainerType, QSortBy> {
  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByCanBeChildrensOrigin() {
    return addSortByInternal('canBeChildrensOrigin', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByCanBeChildrensOriginDesc() {
    return addSortByInternal('canBeChildrensOrigin', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerColor() {
    return addSortByInternal('containerColor', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerColorDesc() {
    return addSortByInternal('containerColor', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerType() {
    return addSortByInternal('containerType', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByContainerTypeDesc() {
    return addSortByInternal('containerType', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> sortByStructured() {
    return addSortByInternal('structured', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      sortByStructuredDesc() {
    return addSortByInternal('structured', Sort.desc);
  }
}

extension ContainerTypeQueryWhereSortThenBy
    on QueryBuilder<ContainerType, ContainerType, QSortThenBy> {
  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByCanBeChildrensOrigin() {
    return addSortByInternal('canBeChildrensOrigin', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByCanBeChildrensOriginDesc() {
    return addSortByInternal('canBeChildrensOrigin', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerColor() {
    return addSortByInternal('containerColor', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerColorDesc() {
    return addSortByInternal('containerColor', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerType() {
    return addSortByInternal('containerType', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByContainerTypeDesc() {
    return addSortByInternal('containerType', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy> thenByStructured() {
    return addSortByInternal('structured', Sort.asc);
  }

  QueryBuilder<ContainerType, ContainerType, QAfterSortBy>
      thenByStructuredDesc() {
    return addSortByInternal('structured', Sort.desc);
  }
}

extension ContainerTypeQueryWhereDistinct
    on QueryBuilder<ContainerType, ContainerType, QDistinct> {
  QueryBuilder<ContainerType, ContainerType, QDistinct>
      distinctByCanBeChildrensOrigin() {
    return addDistinctByInternal('canBeChildrensOrigin');
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct>
      distinctByContainerColor({bool caseSensitive = true}) {
    return addDistinctByInternal('containerColor',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct> distinctByContainerType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('containerType', caseSensitive: caseSensitive);
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContainerType, ContainerType, QDistinct> distinctByStructured() {
    return addDistinctByInternal('structured');
  }
}

extension ContainerTypeQueryProperty
    on QueryBuilder<ContainerType, ContainerType, QQueryProperty> {
  QueryBuilder<ContainerType, bool, QQueryOperations>
      canBeChildrensOriginProperty() {
    return addPropertyNameInternal('canBeChildrensOrigin');
  }

  QueryBuilder<ContainerType, List<String>, QQueryOperations>
      canContainProperty() {
    return addPropertyNameInternal('canContain');
  }

  QueryBuilder<ContainerType, String, QQueryOperations>
      containerColorProperty() {
    return addPropertyNameInternal('containerColor');
  }

  QueryBuilder<ContainerType, String, QQueryOperations>
      containerTypeProperty() {
    return addPropertyNameInternal('containerType');
  }

  QueryBuilder<ContainerType, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContainerType, bool, QQueryOperations> structuredProperty() {
    return addPropertyNameInternal('structured');
  }
}
