// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_calibration_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCameraCalibrationEntryCollection on Isar {
  IsarCollection<CameraCalibrationEntry> get cameraCalibrationEntrys =>
      this.collection();
}

const CameraCalibrationEntrySchema = CollectionSchema(
  name: r'CameraCalibrationEntry',
  id: 330827334019573009,
  properties: {
    r'diagonalSize': PropertySchema(
      id: 0,
      name: r'diagonalSize',
      type: IsarType.double,
    ),
    r'distanceFromCamera': PropertySchema(
      id: 1,
      name: r'distanceFromCamera',
      type: IsarType.double,
    ),
    r'hashCode': PropertySchema(
      id: 2,
      name: r'hashCode',
      type: IsarType.long,
    )
  },
  estimateSize: _cameraCalibrationEntryEstimateSize,
  serialize: _cameraCalibrationEntrySerialize,
  deserialize: _cameraCalibrationEntryDeserialize,
  deserializeProp: _cameraCalibrationEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cameraCalibrationEntryGetId,
  getLinks: _cameraCalibrationEntryGetLinks,
  attach: _cameraCalibrationEntryAttach,
  version: '3.1.0+1',
);

int _cameraCalibrationEntryEstimateSize(
  CameraCalibrationEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _cameraCalibrationEntrySerialize(
  CameraCalibrationEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.diagonalSize);
  writer.writeDouble(offsets[1], object.distanceFromCamera);
  writer.writeLong(offsets[2], object.hashCode);
}

CameraCalibrationEntry _cameraCalibrationEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CameraCalibrationEntry();
  object.diagonalSize = reader.readDouble(offsets[0]);
  object.distanceFromCamera = reader.readDouble(offsets[1]);
  object.id = id;
  return object;
}

P _cameraCalibrationEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cameraCalibrationEntryGetId(CameraCalibrationEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cameraCalibrationEntryGetLinks(
    CameraCalibrationEntry object) {
  return [];
}

void _cameraCalibrationEntryAttach(
    IsarCollection<dynamic> col, Id id, CameraCalibrationEntry object) {
  object.id = id;
}

extension CameraCalibrationEntryQueryWhereSort
    on QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QWhere> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CameraCalibrationEntryQueryWhere on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QWhereClause> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterWhereClause> idBetween(
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

extension CameraCalibrationEntryQueryFilter on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QFilterCondition> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'diagonalSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'diagonalSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'diagonalSize',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> diagonalSizeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'diagonalSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> distanceFromCameraEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceFromCamera',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> distanceFromCameraGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceFromCamera',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> distanceFromCameraLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceFromCamera',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> distanceFromCameraBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceFromCamera',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeGreaterThan(
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

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeLessThan(
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

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> hashCodeBetween(
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

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry,
      QAfterFilterCondition> idBetween(
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
}

extension CameraCalibrationEntryQueryObject on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QFilterCondition> {}

extension CameraCalibrationEntryQueryLinks on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QFilterCondition> {}

extension CameraCalibrationEntryQuerySortBy
    on QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QSortBy> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDiagonalSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSize', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDiagonalSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSize', Sort.desc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDistanceFromCamera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceFromCamera', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByDistanceFromCameraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceFromCamera', Sort.desc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }
}

extension CameraCalibrationEntryQuerySortThenBy on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QSortThenBy> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDiagonalSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSize', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDiagonalSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagonalSize', Sort.desc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDistanceFromCamera() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceFromCamera', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByDistanceFromCameraDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceFromCamera', Sort.desc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CameraCalibrationEntryQueryWhereDistinct
    on QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct> {
  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctByDiagonalSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagonalSize');
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctByDistanceFromCamera() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceFromCamera');
    });
  }

  QueryBuilder<CameraCalibrationEntry, CameraCalibrationEntry, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }
}

extension CameraCalibrationEntryQueryProperty on QueryBuilder<
    CameraCalibrationEntry, CameraCalibrationEntry, QQueryProperty> {
  QueryBuilder<CameraCalibrationEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CameraCalibrationEntry, double, QQueryOperations>
      diagonalSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagonalSize');
    });
  }

  QueryBuilder<CameraCalibrationEntry, double, QQueryOperations>
      distanceFromCameraProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceFromCamera');
    });
  }

  QueryBuilder<CameraCalibrationEntry, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }
}
