// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ml_object.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMLObjectCollection on Isar {
  IsarCollection<MLObject> get mLObjects => this.collection();
}

const MLObjectSchema = CollectionSchema(
  name: r'MLObject',
  id: -7759777828874167920,
  properties: {
    r'boundingBox': PropertySchema(
      id: 0,
      name: r'boundingBox',
      type: IsarType.doubleList,
    ),
    r'hashCode': PropertySchema(
      id: 1,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'photoID': PropertySchema(
      id: 2,
      name: r'photoID',
      type: IsarType.long,
    )
  },
  estimateSize: _mLObjectEstimateSize,
  serialize: _mLObjectSerialize,
  deserialize: _mLObjectDeserialize,
  deserializeProp: _mLObjectDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _mLObjectGetId,
  getLinks: _mLObjectGetLinks,
  attach: _mLObjectAttach,
  version: '3.1.0+1',
);

int _mLObjectEstimateSize(
  MLObject object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.boundingBox.length * 8;
  return bytesCount;
}

void _mLObjectSerialize(
  MLObject object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDoubleList(offsets[0], object.boundingBox);
  writer.writeLong(offsets[1], object.hashCode);
  writer.writeLong(offsets[2], object.photoID);
}

MLObject _mLObjectDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MLObject();
  object.boundingBox = reader.readDoubleList(offsets[0]) ?? [];
  object.id = id;
  object.photoID = reader.readLong(offsets[2]);
  return object;
}

P _mLObjectDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mLObjectGetId(MLObject object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mLObjectGetLinks(MLObject object) {
  return [];
}

void _mLObjectAttach(IsarCollection<dynamic> col, Id id, MLObject object) {
  object.id = id;
}

extension MLObjectQueryWhereSort on QueryBuilder<MLObject, MLObject, QWhere> {
  QueryBuilder<MLObject, MLObject, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MLObjectQueryWhere on QueryBuilder<MLObject, MLObject, QWhereClause> {
  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterWhereClause> idBetween(
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
}

extension MLObjectQueryFilter
    on QueryBuilder<MLObject, MLObject, QFilterCondition> {
  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boundingBox',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'boundingBox',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'boundingBox',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'boundingBox',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boundingBox',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> boundingBoxIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boundingBox',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boundingBox',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boundingBox',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boundingBox',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition>
      boundingBoxLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'boundingBox',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoID',
        value: value,
      ));
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterFilterCondition> photoIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MLObjectQueryObject
    on QueryBuilder<MLObject, MLObject, QFilterCondition> {}

extension MLObjectQueryLinks
    on QueryBuilder<MLObject, MLObject, QFilterCondition> {}

extension MLObjectQuerySortBy on QueryBuilder<MLObject, MLObject, QSortBy> {
  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> sortByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }
}

extension MLObjectQuerySortThenBy
    on QueryBuilder<MLObject, MLObject, QSortThenBy> {
  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.asc);
    });
  }

  QueryBuilder<MLObject, MLObject, QAfterSortBy> thenByPhotoIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoID', Sort.desc);
    });
  }
}

extension MLObjectQueryWhereDistinct
    on QueryBuilder<MLObject, MLObject, QDistinct> {
  QueryBuilder<MLObject, MLObject, QDistinct> distinctByBoundingBox() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boundingBox');
    });
  }

  QueryBuilder<MLObject, MLObject, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<MLObject, MLObject, QDistinct> distinctByPhotoID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoID');
    });
  }
}

extension MLObjectQueryProperty
    on QueryBuilder<MLObject, MLObject, QQueryProperty> {
  QueryBuilder<MLObject, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MLObject, List<double>, QQueryOperations> boundingBoxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boundingBox');
    });
  }

  QueryBuilder<MLObject, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<MLObject, int, QQueryOperations> photoIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoID');
    });
  }
}
