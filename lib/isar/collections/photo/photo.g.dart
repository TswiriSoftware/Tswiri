// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'photo.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetPhotoCollection on Isar {
  IsarCollection<Photo> get photos => getCollection();
}

const PhotoSchema = CollectionSchema(
  name: 'Photo',
  schema:
      '{"name":"Photo","idName":"id","properties":[{"name":"containerUID","type":"String"},{"name":"extention","type":"String"},{"name":"photoName","type":"Long"},{"name":"photoSize","type":"DoubleList"},{"name":"thumbnailExtention","type":"String"},{"name":"thumbnailName","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'containerUID': 0,
    'extention': 1,
    'photoName': 2,
    'photoSize': 3,
    'thumbnailExtention': 4,
    'thumbnailName': 5
  },
  listProperties: {'photoSize'},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _photoGetId,
  setId: _photoSetId,
  getLinks: _photoGetLinks,
  attachLinks: _photoAttachLinks,
  serializeNative: _photoSerializeNative,
  deserializeNative: _photoDeserializeNative,
  deserializePropNative: _photoDeserializePropNative,
  serializeWeb: _photoSerializeWeb,
  deserializeWeb: _photoDeserializeWeb,
  deserializePropWeb: _photoDeserializePropWeb,
  version: 3,
);

int? _photoGetId(Photo object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _photoSetId(Photo object, int id) {
  object.id = id;
}

List<IsarLinkBase> _photoGetLinks(Photo object) {
  return [];
}

const _photoSizeConverter = SizeConverter();

void _photoSerializeNative(
    IsarCollection<Photo> collection,
    IsarRawObject rawObj,
    Photo object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.containerUID;
  IsarUint8List? _containerUID;
  if (value0 != null) {
    _containerUID = IsarBinaryWriter.utf8Encoder.convert(value0);
  }
  dynamicSize += (_containerUID?.length ?? 0) as int;
  final value1 = object.extention;
  final _extention = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_extention.length) as int;
  final value2 = object.photoName;
  final _photoName = value2;
  final value3 = _photoSizeConverter.toIsar(object.photoSize);
  dynamicSize += (value3.length) * 8;
  final _photoSize = value3;
  final value4 = object.thumbnailExtention;
  final _thumbnailExtention = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_thumbnailExtention.length) as int;
  final value5 = object.thumbnailName;
  final _thumbnailName = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_thumbnailName.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _containerUID);
  writer.writeBytes(offsets[1], _extention);
  writer.writeLong(offsets[2], _photoName);
  writer.writeDoubleList(offsets[3], _photoSize);
  writer.writeBytes(offsets[4], _thumbnailExtention);
  writer.writeBytes(offsets[5], _thumbnailName);
}

Photo _photoDeserializeNative(IsarCollection<Photo> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Photo();
  object.containerUID = reader.readStringOrNull(offsets[0]);
  object.extention = reader.readString(offsets[1]);
  object.id = id;
  object.photoName = reader.readLong(offsets[2]);
  object.photoSize =
      _photoSizeConverter.fromIsar(reader.readDoubleList(offsets[3]) ?? []);
  object.thumbnailExtention = reader.readString(offsets[4]);
  object.thumbnailName = reader.readString(offsets[5]);
  return object;
}

P _photoDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (_photoSizeConverter.fromIsar(reader.readDoubleList(offset) ?? []))
          as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _photoSerializeWeb(IsarCollection<Photo> collection, Photo object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'containerUID', object.containerUID);
  IsarNative.jsObjectSet(jsObj, 'extention', object.extention);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoName', object.photoName);
  IsarNative.jsObjectSet(
      jsObj, 'photoSize', _photoSizeConverter.toIsar(object.photoSize));
  IsarNative.jsObjectSet(
      jsObj, 'thumbnailExtention', object.thumbnailExtention);
  IsarNative.jsObjectSet(jsObj, 'thumbnailName', object.thumbnailName);
  return jsObj;
}

Photo _photoDeserializeWeb(IsarCollection<Photo> collection, dynamic jsObj) {
  final object = Photo();
  object.containerUID = IsarNative.jsObjectGet(jsObj, 'containerUID');
  object.extention = IsarNative.jsObjectGet(jsObj, 'extention') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoName =
      IsarNative.jsObjectGet(jsObj, 'photoName') ?? double.negativeInfinity;
  object.photoSize = _photoSizeConverter.fromIsar(
      (IsarNative.jsObjectGet(jsObj, 'photoSize') as List?)
              ?.map((e) => e ?? double.negativeInfinity)
              .toList()
              .cast<double>() ??
          []);
  object.thumbnailExtention =
      IsarNative.jsObjectGet(jsObj, 'thumbnailExtention') ?? '';
  object.thumbnailName = IsarNative.jsObjectGet(jsObj, 'thumbnailName') ?? '';
  return object;
}

P _photoDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'containerUID':
      return (IsarNative.jsObjectGet(jsObj, 'containerUID')) as P;
    case 'extention':
      return (IsarNative.jsObjectGet(jsObj, 'extention') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'photoName':
      return (IsarNative.jsObjectGet(jsObj, 'photoName') ??
          double.negativeInfinity) as P;
    case 'photoSize':
      return (_photoSizeConverter.fromIsar(
          (IsarNative.jsObjectGet(jsObj, 'photoSize') as List?)
                  ?.map((e) => e ?? double.negativeInfinity)
                  .toList()
                  .cast<double>() ??
              [])) as P;
    case 'thumbnailExtention':
      return (IsarNative.jsObjectGet(jsObj, 'thumbnailExtention') ?? '') as P;
    case 'thumbnailName':
      return (IsarNative.jsObjectGet(jsObj, 'thumbnailName') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _photoAttachLinks(IsarCollection col, int id, Photo object) {}

extension PhotoQueryWhereSort on QueryBuilder<Photo, Photo, QWhere> {
  QueryBuilder<Photo, Photo, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension PhotoQueryWhere on QueryBuilder<Photo, Photo, QWhereClause> {
  QueryBuilder<Photo, Photo, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Photo, Photo, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Photo, Photo, QAfterWhereClause> idBetween(
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

extension PhotoQueryFilter on QueryBuilder<Photo, Photo, QFilterCondition> {
  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'containerUID',
      value: null,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDGreaterThan(
    String? value, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDLessThan(
    String? value, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDStartsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDEndsWith(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'containerUID',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> containerUIDMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'containerUID',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'extention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'extention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'extention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'extention',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'extention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'extention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'extention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> extentionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'extention',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoName',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'photoName',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'photoName',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoNameBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'photoName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoSizeAnyGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'photoSize',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoSizeAnyLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'photoSize',
      value: value,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> photoSizeAnyBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'photoSize',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtentionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'thumbnailExtention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition>
      thumbnailExtentionGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'thumbnailExtention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtentionLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'thumbnailExtention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtentionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'thumbnailExtention',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition>
      thumbnailExtentionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'thumbnailExtention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtentionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'thumbnailExtention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtentionContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'thumbnailExtention',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailExtentionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'thumbnailExtention',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'thumbnailName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'thumbnailName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'thumbnailName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'thumbnailName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'thumbnailName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'thumbnailName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'thumbnailName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Photo, Photo, QAfterFilterCondition> thumbnailNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'thumbnailName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension PhotoQueryLinks on QueryBuilder<Photo, Photo, QFilterCondition> {}

extension PhotoQueryWhereSortBy on QueryBuilder<Photo, Photo, QSortBy> {
  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByExtention() {
    return addSortByInternal('extention', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByExtentionDesc() {
    return addSortByInternal('extention', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByPhotoName() {
    return addSortByInternal('photoName', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByPhotoNameDesc() {
    return addSortByInternal('photoName', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailExtention() {
    return addSortByInternal('thumbnailExtention', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailExtentionDesc() {
    return addSortByInternal('thumbnailExtention', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailName() {
    return addSortByInternal('thumbnailName', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> sortByThumbnailNameDesc() {
    return addSortByInternal('thumbnailName', Sort.desc);
  }
}

extension PhotoQueryWhereSortThenBy on QueryBuilder<Photo, Photo, QSortThenBy> {
  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerUID() {
    return addSortByInternal('containerUID', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByContainerUIDDesc() {
    return addSortByInternal('containerUID', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByExtention() {
    return addSortByInternal('extention', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByExtentionDesc() {
    return addSortByInternal('extention', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByPhotoName() {
    return addSortByInternal('photoName', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByPhotoNameDesc() {
    return addSortByInternal('photoName', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailExtention() {
    return addSortByInternal('thumbnailExtention', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailExtentionDesc() {
    return addSortByInternal('thumbnailExtention', Sort.desc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailName() {
    return addSortByInternal('thumbnailName', Sort.asc);
  }

  QueryBuilder<Photo, Photo, QAfterSortBy> thenByThumbnailNameDesc() {
    return addSortByInternal('thumbnailName', Sort.desc);
  }
}

extension PhotoQueryWhereDistinct on QueryBuilder<Photo, Photo, QDistinct> {
  QueryBuilder<Photo, Photo, QDistinct> distinctByContainerUID(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('containerUID', caseSensitive: caseSensitive);
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByExtention(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('extention', caseSensitive: caseSensitive);
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByPhotoName() {
    return addDistinctByInternal('photoName');
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByThumbnailExtention(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('thumbnailExtention',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Photo, Photo, QDistinct> distinctByThumbnailName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('thumbnailName', caseSensitive: caseSensitive);
  }
}

extension PhotoQueryProperty on QueryBuilder<Photo, Photo, QQueryProperty> {
  QueryBuilder<Photo, String?, QQueryOperations> containerUIDProperty() {
    return addPropertyNameInternal('containerUID');
  }

  QueryBuilder<Photo, String, QQueryOperations> extentionProperty() {
    return addPropertyNameInternal('extention');
  }

  QueryBuilder<Photo, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Photo, int, QQueryOperations> photoNameProperty() {
    return addPropertyNameInternal('photoName');
  }

  QueryBuilder<Photo, Size, QQueryOperations> photoSizeProperty() {
    return addPropertyNameInternal('photoSize');
  }

  QueryBuilder<Photo, String, QQueryOperations> thumbnailExtentionProperty() {
    return addPropertyNameInternal('thumbnailExtention');
  }

  QueryBuilder<Photo, String, QQueryOperations> thumbnailNameProperty() {
    return addPropertyNameInternal('thumbnailName');
  }
}
