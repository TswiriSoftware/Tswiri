// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_local_identifiers

part of 'photo_label.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetPhotoLabelCollection on Isar {
  IsarCollection<PhotoLabel> get photoLabels => getCollection();
}

const PhotoLabelSchema = CollectionSchema(
  name: 'PhotoLabel',
  schema:
      '{"name":"PhotoLabel","idName":"id","properties":[{"name":"hashCode","type":"Long"},{"name":"photoID","type":"Long"},{"name":"tagTextID","type":"Long"}],"indexes":[{"name":"tagTextID","unique":false,"properties":[{"name":"tagTextID","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {'hashCode': 0, 'photoID': 1, 'tagTextID': 2},
  listProperties: {},
  indexIds: {'tagTextID': 0},
  indexValueTypes: {
    'tagTextID': [
      IndexValueType.long,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _photoLabelGetId,
  setId: _photoLabelSetId,
  getLinks: _photoLabelGetLinks,
  attachLinks: _photoLabelAttachLinks,
  serializeNative: _photoLabelSerializeNative,
  deserializeNative: _photoLabelDeserializeNative,
  deserializePropNative: _photoLabelDeserializePropNative,
  serializeWeb: _photoLabelSerializeWeb,
  deserializeWeb: _photoLabelDeserializeWeb,
  deserializePropWeb: _photoLabelDeserializePropWeb,
  version: 3,
);

int? _photoLabelGetId(PhotoLabel object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _photoLabelSetId(PhotoLabel object, int id) {
  object.id = id;
}

List<IsarLinkBase> _photoLabelGetLinks(PhotoLabel object) {
  return [];
}

void _photoLabelSerializeNative(
    IsarCollection<PhotoLabel> collection,
    IsarRawObject rawObj,
    PhotoLabel object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.hashCode;
  final _hashCode = value0;
  final value1 = object.photoID;
  final _photoID = value1;
  final value2 = object.tagTextID;
  final _tagTextID = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _hashCode);
  writer.writeLong(offsets[1], _photoID);
  writer.writeLong(offsets[2], _tagTextID);
}

PhotoLabel _photoLabelDeserializeNative(IsarCollection<PhotoLabel> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = PhotoLabel();
  object.id = id;
  object.photoID = reader.readLong(offsets[1]);
  object.tagTextID = reader.readLong(offsets[2]);
  return object;
}

P _photoLabelDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _photoLabelSerializeWeb(
    IsarCollection<PhotoLabel> collection, PhotoLabel object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'hashCode', object.hashCode);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'photoID', object.photoID);
  IsarNative.jsObjectSet(jsObj, 'tagTextID', object.tagTextID);
  return jsObj;
}

PhotoLabel _photoLabelDeserializeWeb(
    IsarCollection<PhotoLabel> collection, dynamic jsObj) {
  final object = PhotoLabel();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.photoID =
      IsarNative.jsObjectGet(jsObj, 'photoID') ?? double.negativeInfinity;
  object.tagTextID =
      IsarNative.jsObjectGet(jsObj, 'tagTextID') ?? double.negativeInfinity;
  return object;
}

P _photoLabelDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'hashCode':
      return (IsarNative.jsObjectGet(jsObj, 'hashCode') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'photoID':
      return (IsarNative.jsObjectGet(jsObj, 'photoID') ??
          double.negativeInfinity) as P;
    case 'tagTextID':
      return (IsarNative.jsObjectGet(jsObj, 'tagTextID') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _photoLabelAttachLinks(IsarCollection col, int id, PhotoLabel object) {}

extension PhotoLabelQueryWhereSort
    on QueryBuilder<PhotoLabel, PhotoLabel, QWhere> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhere> anyTagTextID() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'tagTextID'));
  }
}

extension PhotoLabelQueryWhere
    on QueryBuilder<PhotoLabel, PhotoLabel, QWhereClause> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> idBetween(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDEqualTo(
      int tagTextID) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'tagTextID',
      value: [tagTextID],
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDNotEqualTo(
      int tagTextID) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tagTextID',
        upper: [tagTextID],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tagTextID',
        lower: [tagTextID],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'tagTextID',
        lower: [tagTextID],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'tagTextID',
        upper: [tagTextID],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDGreaterThan(
    int tagTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'tagTextID',
      lower: [tagTextID],
      includeLower: include,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDLessThan(
    int tagTextID, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'tagTextID',
      upper: [tagTextID],
      includeUpper: include,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterWhereClause> tagTextIDBetween(
    int lowerTagTextID,
    int upperTagTextID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'tagTextID',
      lower: [lowerTagTextID],
      includeLower: includeLower,
      upper: [upperTagTextID],
      includeUpper: includeUpper,
    ));
  }
}

extension PhotoLabelQueryFilter
    on QueryBuilder<PhotoLabel, PhotoLabel, QFilterCondition> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'hashCode',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hashCode',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> photoIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition>
      photoIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> photoIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'photoID',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> photoIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'photoID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> tagTextIDEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition>
      tagTextIDGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> tagTextIDLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'tagTextID',
      value: value,
    ));
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterFilterCondition> tagTextIDBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'tagTextID',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension PhotoLabelQueryLinks
    on QueryBuilder<PhotoLabel, PhotoLabel, QFilterCondition> {}

extension PhotoLabelQueryWhereSortBy
    on QueryBuilder<PhotoLabel, PhotoLabel, QSortBy> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> sortByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension PhotoLabelQueryWhereSortThenBy
    on QueryBuilder<PhotoLabel, PhotoLabel, QSortThenBy> {
  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByHashCode() {
    return addSortByInternal('hashCode', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByHashCodeDesc() {
    return addSortByInternal('hashCode', Sort.desc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByPhotoID() {
    return addSortByInternal('photoID', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByPhotoIDDesc() {
    return addSortByInternal('photoID', Sort.desc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByTagTextID() {
    return addSortByInternal('tagTextID', Sort.asc);
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QAfterSortBy> thenByTagTextIDDesc() {
    return addSortByInternal('tagTextID', Sort.desc);
  }
}

extension PhotoLabelQueryWhereDistinct
    on QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> {
  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctByHashCode() {
    return addDistinctByInternal('hashCode');
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctByPhotoID() {
    return addDistinctByInternal('photoID');
  }

  QueryBuilder<PhotoLabel, PhotoLabel, QDistinct> distinctByTagTextID() {
    return addDistinctByInternal('tagTextID');
  }
}

extension PhotoLabelQueryProperty
    on QueryBuilder<PhotoLabel, PhotoLabel, QQueryProperty> {
  QueryBuilder<PhotoLabel, int, QQueryOperations> hashCodeProperty() {
    return addPropertyNameInternal('hashCode');
  }

  QueryBuilder<PhotoLabel, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<PhotoLabel, int, QQueryOperations> photoIDProperty() {
    return addPropertyNameInternal('photoID');
  }

  QueryBuilder<PhotoLabel, int, QQueryOperations> tagTextIDProperty() {
    return addPropertyNameInternal('tagTextID');
  }
}
