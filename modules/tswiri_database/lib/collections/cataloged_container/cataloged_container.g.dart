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
    r'barcodeUID': PropertySchema(
      id: 0,
      name: r'barcodeUID',
      type: IsarType.string,
    ),
    r'containerTypeID': PropertySchema(
      id: 1,
      name: r'containerTypeID',
      type: IsarType.long,
    ),
    r'containerUID': PropertySchema(
      id: 2,
      name: r'containerUID',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _catalogedContainerEstimateSize,
  serialize: _catalogedContainerSerialize,
  deserialize: _catalogedContainerDeserialize,
  deserializeProp: _catalogedContainerDeserializeProp,
  idName: r'id',
  indexes: {
    r'containerUID': IndexSchema(
      id: 3918990956816157529,
      name: r'containerUID',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'containerUID',
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
    final value = object.barcodeUID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.containerUID.length * 3;
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
  return bytesCount;
}

void _catalogedContainerSerialize(
  CatalogedContainer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcodeUID);
  writer.writeLong(offsets[1], object.containerTypeID);
  writer.writeString(offsets[2], object.containerUID);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.name);
}

CatalogedContainer _catalogedContainerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatalogedContainer();
  object.barcodeUID = reader.readStringOrNull(offsets[0]);
  object.containerTypeID = reader.readLong(offsets[1]);
  object.containerUID = reader.readString(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[4]);
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
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
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
  Future<CatalogedContainer?> getByContainerUID(String containerUID) {
    return getByIndex(r'containerUID', [containerUID]);
  }

  CatalogedContainer? getByContainerUIDSync(String containerUID) {
    return getByIndexSync(r'containerUID', [containerUID]);
  }

  Future<bool> deleteByContainerUID(String containerUID) {
    return deleteByIndex(r'containerUID', [containerUID]);
  }

  bool deleteByContainerUIDSync(String containerUID) {
    return deleteByIndexSync(r'containerUID', [containerUID]);
  }

  Future<List<CatalogedContainer?>> getAllByContainerUID(
      List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return getAllByIndex(r'containerUID', values);
  }

  List<CatalogedContainer?> getAllByContainerUIDSync(
      List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'containerUID', values);
  }

  Future<int> deleteAllByContainerUID(List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'containerUID', values);
  }

  int deleteAllByContainerUIDSync(List<String> containerUIDValues) {
    final values = containerUIDValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'containerUID', values);
  }

  Future<Id> putByContainerUID(CatalogedContainer object) {
    return putByIndex(r'containerUID', object);
  }

  Id putByContainerUIDSync(CatalogedContainer object, {bool saveLinks = true}) {
    return putByIndexSync(r'containerUID', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByContainerUID(List<CatalogedContainer> objects) {
    return putAllByIndex(r'containerUID', objects);
  }

  List<Id> putAllByContainerUIDSync(List<CatalogedContainer> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'containerUID', objects, saveLinks: saveLinks);
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
      containerUIDEqualTo(String containerUID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'containerUID',
        value: [containerUID],
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterWhereClause>
      containerUIDNotEqualTo(String containerUID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUID',
              lower: [],
              upper: [containerUID],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUID',
              lower: [containerUID],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUID',
              lower: [containerUID],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'containerUID',
              lower: [],
              upper: [containerUID],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CatalogedContainerQueryFilter
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barcodeUID',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barcodeUID',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcodeUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcodeUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcodeUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      barcodeUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcodeUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerTypeID',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'containerTypeID',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'containerTypeID',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerTypeIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'containerTypeID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'containerUID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterFilterCondition>
      containerUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerUID',
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
}

extension CatalogedContainerQueryObject
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {}

extension CatalogedContainerQueryLinks
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QFilterCondition> {}

extension CatalogedContainerQuerySortBy
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QSortBy> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerTypeID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerTypeID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerTypeIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerTypeID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      sortByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
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
}

extension CatalogedContainerQuerySortThenBy
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QSortThenBy> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByBarcodeUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByBarcodeUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barcodeUID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerTypeID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerTypeID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerTypeIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerTypeID', Sort.desc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QAfterSortBy>
      thenByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
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
}

extension CatalogedContainerQueryWhereDistinct
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct> {
  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByBarcodeUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barcodeUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByContainerTypeID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerTypeID');
    });
  }

  QueryBuilder<CatalogedContainer, CatalogedContainer, QDistinct>
      distinctByContainerUID({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerUID', caseSensitive: caseSensitive);
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
}

extension CatalogedContainerQueryProperty
    on QueryBuilder<CatalogedContainer, CatalogedContainer, QQueryProperty> {
  QueryBuilder<CatalogedContainer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatalogedContainer, String?, QQueryOperations>
      barcodeUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barcodeUID');
    });
  }

  QueryBuilder<CatalogedContainer, int, QQueryOperations>
      containerTypeIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerTypeID');
    });
  }

  QueryBuilder<CatalogedContainer, String, QQueryOperations>
      containerUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerUID');
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
}
