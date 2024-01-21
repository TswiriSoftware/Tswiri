// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPhotoCollection on Isar {
  IsarCollection<Photo> get photos => this.collection();
}

const PhotoSchema = CollectionSchema(
  name: r'Photo',
  id: 7605685642742149252,
  properties: {
    r'containerUID': PropertySchema(
      id: 0,
      name: r'containerUID',
      type: IsarType.string,
    ),
    r'extension': PropertySchema(
      id: 1,
      name: r'extension',
      type: IsarType.string,
    ),
    r'photoName': PropertySchema(
      id: 2,
      name: r'photoName',
      type: IsarType.long,
    ),
    r'photoSize': PropertySchema(
      id: 3,
      name: r'photoSize',
      type: IsarType.object,
      target: r'IsarSize',
    ),
    r'thumbnailExtension': PropertySchema(
      id: 4,
      name: r'thumbnailExtension',
      type: IsarType.string,
    ),
    r'thumbnailName': PropertySchema(
      id: 5,
      name: r'thumbnailName',
      type: IsarType.string,
    )
  },
  estimateSize: _photoEstimateSize,
  serialize: _photoSerialize,
  deserialize: _photoDeserialize,
  deserializeProp: _photoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'IsarSize': IsarSizeSchema},
  getId: _photoGetId,
  getLinks: _photoGetLinks,
  attach: _photoAttach,
  version: '3.1.0+1',
);

int _photoEstimateSize(
  Photo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.containerUID;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.extension.length * 3;
  bytesCount += 3 +
      IsarSizeSchema.estimateSize(
          object.photoSize, allOffsets[IsarSize]!, allOffsets);
  bytesCount += 3 + object.thumbnailExtension.length * 3;
  bytesCount += 3 + object.thumbnailName.length * 3;
  return bytesCount;
}

void _photoSerialize(
  Photo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.containerUID);
  writer.writeString(offsets[1], object.extension);
  writer.writeLong(offsets[2], object.photoName);
  writer.writeObject<IsarSize>(
    offsets[3],
    allOffsets,
    IsarSizeSchema.serialize,
    object.photoSize,
  );
  writer.writeString(offsets[4], object.thumbnailExtension);
  writer.writeString(offsets[5], object.thumbnailName);
}

Photo _photoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Photo();
  object.containerUID = reader.readStringOrNull(offsets[0]);
  object.extension = reader.readString(offsets[1]);
  object.id = id;
  object.photoName = reader.readLong(offsets[2]);
  object.photoSize = reader.readObjectOrNull<IsarSize>(
        offsets[3],
        IsarSizeSchema.deserialize,
        allOffsets,
      ) ??
      IsarSize();
  object.thumbnailExtension = reader.readString(offsets[4]);
  object.thumbnailName = reader.readString(offsets[5]);
  return object;
}

P _photoDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readObjectOrNull<IsarSize>(
            offset,
            IsarSizeSchema.deserialize,
            allOffsets,
          ) ??
          IsarSize()) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _photoGetId(Photo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _photoGetLinks(Photo object) {
  return [];
}

void _photoAttach(IsarCollection<dynamic> col, Id id, Photo object) {
  object.id = id;
}

extension PhotoQueryWhereSort on QueryBuilder<Photo, Photo, QWhere> {
  QueryBuilder<Photo, Photo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PhotoQueryWhere on QueryBuilder<Photo, Photo, QWhereClause> {
  QueryBuilder<Photo, Photo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Photo, Photo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idBetween(
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

extension PhotoQueryFilter on QueryBuilder<Photo, Photo, QFilterCondition> {
  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'containerUID',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'containerUID',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDEqualTo(
    String? value, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDGreaterThan(
    String? value, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDLessThan(
    String? value, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDStartsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDEndsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'containerUID',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'containerUID',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'containerUID',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extension',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'extension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'extension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extension',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extension',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extensionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extension',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoName',
        value: value,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoName',
        value: value,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoName',
        value: value,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtensionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition>
      thumbnailExtensionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtensionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtensionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailExtension',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition>
      thumbnailExtensionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtensionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtensionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailExtension',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtensionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailExtension',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition>
      thumbnailExtensionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition>
      thumbnailExtensionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailExtension',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailName',
        value: '',
      ));
    });
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailName',
        value: '',
      ));
    });
  }
}

extension PhotoQueryObject on QueryBuilder<Photo, Photo, QFilterCondition> {
  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoSize(
      FilterQuery<IsarSize> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'photoSize');
    });
  }
}

extension PhotoQueryLinks on QueryBuilder<Photo, Photo, QFilterCondition> {}

extension PhotoQuerySortBy on QueryBuilder<Photo, Photo, QSortBy> {
  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extension', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extension', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByPhotoName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoName', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByPhotoNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoName', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailExtension', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailExtension', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailName', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailName', Sort.desc);
    });
  }
}

extension PhotoQuerySortThenBy on QueryBuilder<Photo, Photo, QSortThenBy> {
  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerUID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerUIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'containerUID', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extension', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extension', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByPhotoName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoName', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByPhotoNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoName', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailExtension() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailExtension', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailExtensionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailExtension', Sort.desc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailName', Sort.asc);
    });
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumbnailName', Sort.desc);
    });
  }
}

extension PhotoQueryWhereDistinct on QueryBuilder<Photo, Photo, QDistinct> {
  QueryBuilder<Photo, Photo, QDistinct> distinctByContainerUID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'containerUID', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByExtension(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extension', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByPhotoName() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoName');
    });
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByThumbnailExtension(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailExtension',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByThumbnailName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumbnailName',
          caseSensitive: caseSensitive);
    });
  }
}

extension PhotoQueryProperty on QueryBuilder<Photo, Photo, QQueryProperty> {
  QueryBuilder<Photo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Photo, String?, QQueryOperations> containerUIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'containerUID');
    });
  }

  QueryBuilder<Photo, String, QQueryOperations> extensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extension');
    });
  }

  QueryBuilder<Photo, int, QQueryOperations> photoNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoName');
    });
  }

  QueryBuilder<Photo, IsarSize, QQueryOperations> photoSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoSize');
    });
  }

  QueryBuilder<Photo, String, QQueryOperations> thumbnailExtensionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailExtension');
    });
  }

  QueryBuilder<Photo, String, QQueryOperations> thumbnailNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumbnailName');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IsarSizeSchema = Schema(
  name: r'IsarSize',
  id: 1866783684605857852,
  properties: {
    r'height': PropertySchema(
      id: 0,
      name: r'height',
      type: IsarType.double,
    ),
    r'width': PropertySchema(
      id: 1,
      name: r'width',
      type: IsarType.double,
    )
  },
  estimateSize: _isarSizeEstimateSize,
  serialize: _isarSizeSerialize,
  deserialize: _isarSizeDeserialize,
  deserializeProp: _isarSizeDeserializeProp,
);

int _isarSizeEstimateSize(
  IsarSize object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarSizeSerialize(
  IsarSize object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeDouble(offsets[1], object.width);
}

IsarSize _isarSizeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarSize(
    height: reader.readDoubleOrNull(offsets[0]),
    width: reader.readDoubleOrNull(offsets[1]),
  );
  return object;
}

P _isarSizeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension IsarSizeQueryFilter
    on QueryBuilder<IsarSize, IsarSize, QFilterCondition> {
  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> heightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> heightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'height',
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> heightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> heightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> heightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'height',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> heightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'height',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> widthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> widthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> widthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<IsarSize, IsarSize, QAfterFilterCondition> widthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension IsarSizeQueryObject
    on QueryBuilder<IsarSize, IsarSize, QFilterCondition> {}
