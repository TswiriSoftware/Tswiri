// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cataloged_container.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCatalogedContainerCollection on Isar {
  IsarCollection<CatalogedContainer> get catalogedContainers =>
      this.collection();
}

const CatalogedContainerSchema = CollectionSchema(
  name: r'CatalogedContainer',
  id: -1328495142418178125,
  properties: {
    r'barcodeUUID': PropertySchema(
      id: 0,
      name: r'barcodeUUID',
      type: IsarType.string,
    ),
    r'containerUUID': PropertySchema(
      id: 1,
      name: r'containerUUID',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 2,
      name: r'description',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'typeUUID': PropertySchema(
      id: 4,
      name: r'typeUUID',
      type: IsarType.string,
    )
  },
  estimateSize: _catalogedContainerEstimateSize,
  serialize: _catalogedContainerSerialize,
  deserialize: _catalogedContainerDeserialize,
  deserializeProp: _catalogedContainerDeserializeProp,
  idName: r'id',
  indexes: {
    r'containerUUID': IndexSchema(
      id: 7747540438472048801,
      name: r'containerUUID',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'containerUUID',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _catalogedContainerGetId,
  getLinks: _catalogedContainerGetLinks,
  attach: _catalogedContainerAttach,
  version: '3.1.0+1',
);

int _catalogedContainerEstimateSize(
  CatalogedContainer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.barcodeUUID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.containerUUID.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.typeUUID.length * 3;
  return bytesCount;
}

void _catalogedContainerSerialize(
  CatalogedContainer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcodeUUID);
  writer.writeString(offsets[1], object.containerUUID);
  writer.writeString(offsets[2], object.description);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.typeUUID);
}

CatalogedContainer _catalogedContainerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatalogedContainer();
  object.barcodeUUID = reader.readStringOrNull(offsets[0]);
  object.containerUUID = reader.readString(offsets[1]);
  object.description = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[3]);
  object.typeUUID = reader.readString(offsets[4]);
  return object;
}

P _catalogedContainerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _catalogedContainerGetId(CatalogedContainer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _catalogedContainerGetLinks(
    CatalogedContainer object) {
  return [];
}

void _catalogedContainerAttach(
    IsarCollection<dynamic> col, Id id, CatalogedContainer object) {
  object.id = id;
}

extension CatalogedContainerByIndex on IsarCollection<CatalogedContainer> {
  Future<CatalogedContainer?> getByContainerUUID(String containerUUID) {
    return getByIndex(r'containerUUID', [containerUUID]);
  }

  CatalogedContainer? getByContainerUUIDSync(String containerUUID) {
    return getByIndexSync(r'containerUUID', [containerUUID]);
  }

  Future<bool> deleteByContainerUUID(String containerUUID) {
    return deleteByIndex(r'containerUUID', [containerUUID]);
  }

  bool deleteByContainerUUIDSync(String containerUUID) {
    return deleteByIndexSync(r'containerUUID', [containerUUID]);
  }

  Future<List<CatalogedContainer?>> getAllByContainerUUID(
      List<String> containerUUIDValues) {
    final values = containerUUIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'containerUUID', values);
  }

  List<CatalogedContainer?> getAllByContainerUUIDSync(
      List<String> containerUUIDValues) {
    final values = containerUUIDValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'containerUUID', values);
  }

  Future<int> deleteAllByContainerUUID(List<String> containerUUIDValues) {
    final values = containerUUIDValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'containerUUID', values);
  }

  int deleteAllByContainerUUIDSync(List<String> containerUUIDValues) {
    final values = containerUUIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'containerUUID', values);
  }

  Future<Id> putByContainerUUID(CatalogedContainer object) {
    return putByIndex(r'containerUUID', object);
  }

  Id putByContainerUUIDSync(CatalogedContainer object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'containerUUID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByContainerUUID(List<CatalogedContainer> objects) {
    return putAllByIndex(r'containerUUID', objects);
  }

  List<Id> putAllByContainerUUIDSync(List<CatalogedContainer> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'containerUUID', objects, saveLinks: saveLinks);
  }
}

extension CatalogedContainerQueryWhereSort
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QWhere> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CatalogedContainerQueryWhere
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QWhereClause> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      containerUUIDEqualTo(String containerUUID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'containerUUID',
        value: [containerUUID],
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      containerUUIDNotEqualTo(String containerUUID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUUID',
              lower: [],
              upper: [containerUUID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUUID',
              lower: [containerUUID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUUID',
              lower: [containerUUID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUUID',
              lower: [],
              upper: [containerUUID],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CatalogedContainerQueryFilter
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barcodeUUID',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barcodeUUID',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcodeUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcodeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcodeUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcodeUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'containerUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
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

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typeUUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'typeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'typeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typeUUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typeUUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typeUUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      typeUUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typeUUID',
        value: '',
      ));
    });
  }
}

extension CatalogedContainerQueryObject
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {}

extension CatalogedContainerQueryLinks
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {}

extension CatalogedContainerQuerySortBy
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QSortBy> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByBarcodeUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByBarcodeUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByTypeUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByTypeUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeUUID', Sort.desc);
    });
  }
}

extension CatalogedContainerQuerySortThenBy
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QSortThenBy> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByBarcodeUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByBarcodeUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByTypeUUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeUUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByTypeUUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typeUUID', Sort.desc);
    });
  }
}

extension CatalogedContainerQueryWhereDistinct
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByBarcodeUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcodeUUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByContainerUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerUUID',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByTypeUUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typeUUID', caseSensitive: caseSensitive);
    });
  }
}

extension CatalogedContainerQueryProperty
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QQueryProperty> {
  QueryBuilder<CatalogedContainer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatalogedContainer, String?, QQueryOperations>
      barcodeUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcodeUUID');
    });
  }

  QueryBuilder<CatalogedContainer, String, QQueryOperations>
      containerUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerUUID');
    });
  }

  QueryBuilder<CatalogedContainer, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CatalogedContainer, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CatalogedContainer, String, QQueryOperations>
      typeUUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typeUUID');
    });
  }
}
