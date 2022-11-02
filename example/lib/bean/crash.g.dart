// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crash.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCrashCollection on Isar {
  IsarCollection<Crash> get crashs => this.collection();
}

const CrashSchema = CollectionSchema(
  name: r'Crash',
  id: 7341725822969116929,
  properties: {
    r'count': PropertySchema(
      id: 0,
      name: r'count',
      type: IsarType.long,
    ),
    r'deviceAbi': PropertySchema(
      id: 1,
      name: r'deviceAbi',
      type: IsarType.string,
    ),
    r'deviceId': PropertySchema(
      id: 2,
      name: r'deviceId',
      type: IsarType.string,
    ),
    r'deviceName': PropertySchema(
      id: 3,
      name: r'deviceName',
      type: IsarType.string,
    ),
    r'deviceNet': PropertySchema(
      id: 4,
      name: r'deviceNet',
      type: IsarType.string,
    ),
    r'deviceRom': PropertySchema(
      id: 5,
      name: r'deviceRom',
      type: IsarType.string,
    ),
    r'deviceSdk': PropertySchema(
      id: 6,
      name: r'deviceSdk',
      type: IsarType.string,
    ),
    r'error': PropertySchema(
      id: 7,
      name: r'error',
      type: IsarType.string,
    ),
    r'errorTime': PropertySchema(
      id: 8,
      name: r'errorTime',
      type: IsarType.string,
    ),
    r'logFile': PropertySchema(
      id: 9,
      name: r'logFile',
      type: IsarType.string,
    ),
    r'md5': PropertySchema(
      id: 10,
      name: r'md5',
      type: IsarType.string,
    ),
    r'stackTrace': PropertySchema(
      id: 11,
      name: r'stackTrace',
      type: IsarType.string,
    ),
    r'uploaded': PropertySchema(
      id: 12,
      name: r'uploaded',
      type: IsarType.bool,
    ),
    r'version': PropertySchema(
      id: 13,
      name: r'version',
      type: IsarType.string,
    )
  },
  estimateSize: _crashEstimateSize,
  serialize: _crashSerialize,
  deserialize: _crashDeserialize,
  deserializeProp: _crashDeserializeProp,
  idName: r'id',
  indexes: {
    r'md5': IndexSchema(
      id: 7963317206643560269,
      name: r'md5',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'md5',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _crashGetId,
  getLinks: _crashGetLinks,
  attach: _crashAttach,
  version: '3.0.2',
);

int _crashEstimateSize(
  Crash object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.deviceAbi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceNet;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceRom;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.deviceSdk;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.error.length * 3;
  bytesCount += 3 + object.errorTime.length * 3;
  {
    final value = object.logFile;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.md5.length * 3;
  bytesCount += 3 + object.stackTrace.length * 3;
  bytesCount += 3 + object.version.length * 3;
  return bytesCount;
}

void _crashSerialize(
  Crash object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.count);
  writer.writeString(offsets[1], object.deviceAbi);
  writer.writeString(offsets[2], object.deviceId);
  writer.writeString(offsets[3], object.deviceName);
  writer.writeString(offsets[4], object.deviceNet);
  writer.writeString(offsets[5], object.deviceRom);
  writer.writeString(offsets[6], object.deviceSdk);
  writer.writeString(offsets[7], object.error);
  writer.writeString(offsets[8], object.errorTime);
  writer.writeString(offsets[9], object.logFile);
  writer.writeString(offsets[10], object.md5);
  writer.writeString(offsets[11], object.stackTrace);
  writer.writeBool(offsets[12], object.uploaded);
  writer.writeString(offsets[13], object.version);
}

Crash _crashDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Crash(
    reader.readString(offsets[7]),
    reader.readString(offsets[11]),
    reader.readString(offsets[10]),
    reader.readStringOrNull(offsets[9]),
    reader.readString(offsets[13]),
    count: reader.readLongOrNull(offsets[0]) ?? 1,
    deviceAbi: reader.readStringOrNull(offsets[1]),
    deviceId: reader.readStringOrNull(offsets[2]),
    deviceName: reader.readStringOrNull(offsets[3]),
    deviceNet: reader.readStringOrNull(offsets[4]),
    deviceRom: reader.readStringOrNull(offsets[5]),
    deviceSdk: reader.readStringOrNull(offsets[6]),
    uploaded: reader.readBoolOrNull(offsets[12]) ?? false,
  );
  object.id = id;
  return object;
}

P _crashDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _crashGetId(Crash object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _crashGetLinks(Crash object) {
  return [];
}

void _crashAttach(IsarCollection<dynamic> col, Id id, Crash object) {
  object.id = id;
}

extension CrashByIndex on IsarCollection<Crash> {
  Future<Crash?> getByMd5(String md5) {
    return getByIndex(r'md5', [md5]);
  }

  Crash? getByMd5Sync(String md5) {
    return getByIndexSync(r'md5', [md5]);
  }

  Future<bool> deleteByMd5(String md5) {
    return deleteByIndex(r'md5', [md5]);
  }

  bool deleteByMd5Sync(String md5) {
    return deleteByIndexSync(r'md5', [md5]);
  }

  Future<List<Crash?>> getAllByMd5(List<String> md5Values) {
    final values = md5Values.map((e) => [e]).toList();
    return getAllByIndex(r'md5', values);
  }

  List<Crash?> getAllByMd5Sync(List<String> md5Values) {
    final values = md5Values.map((e) => [e]).toList();
    return getAllByIndexSync(r'md5', values);
  }

  Future<int> deleteAllByMd5(List<String> md5Values) {
    final values = md5Values.map((e) => [e]).toList();
    return deleteAllByIndex(r'md5', values);
  }

  int deleteAllByMd5Sync(List<String> md5Values) {
    final values = md5Values.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'md5', values);
  }

  Future<Id> putByMd5(Crash object) {
    return putByIndex(r'md5', object);
  }

  Id putByMd5Sync(Crash object, {bool saveLinks = true}) {
    return putByIndexSync(r'md5', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMd5(List<Crash> objects) {
    return putAllByIndex(r'md5', objects);
  }

  List<Id> putAllByMd5Sync(List<Crash> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'md5', objects, saveLinks: saveLinks);
  }
}

extension CrashQueryWhereSort on QueryBuilder<Crash, Crash, QWhere> {
  QueryBuilder<Crash, Crash, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CrashQueryWhere on QueryBuilder<Crash, Crash, QWhereClause> {
  QueryBuilder<Crash, Crash, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Crash, Crash, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Crash, Crash, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Crash, Crash, QAfterWhereClause> idBetween(
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

  QueryBuilder<Crash, Crash, QAfterWhereClause> md5EqualTo(String md5) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'md5',
        value: [md5],
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterWhereClause> md5NotEqualTo(String md5) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'md5',
              lower: [],
              upper: [md5],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'md5',
              lower: [md5],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'md5',
              lower: [md5],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'md5',
              lower: [],
              upper: [md5],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CrashQueryFilter on QueryBuilder<Crash, Crash, QFilterCondition> {
  QueryBuilder<Crash, Crash, QAfterFilterCondition> countEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> countGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> countLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> countBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceAbi',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceAbi',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceAbi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceAbi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceAbi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceAbi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceAbi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceAbi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceAbi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceAbi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceAbi',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceAbiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceAbi',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceId',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceId',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceName',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceName',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceNet',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceNet',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceNet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceNet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceNet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceNet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceNet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceNet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceNet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceNet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceNet',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceNetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceNet',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceRom',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceRom',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceRom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceRom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceRom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceRom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceRom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceRom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceRom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceRom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceRom',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceRomIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceRom',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceSdk',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceSdk',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceSdk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceSdk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceSdk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceSdk',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceSdk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceSdk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceSdk',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceSdk',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceSdk',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> deviceSdkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceSdk',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'error',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'error',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'error',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'error',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'error',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'error',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'error',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'error',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'error',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'error',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errorTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errorTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errorTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'errorTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'errorTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'errorTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'errorTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorTime',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> errorTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'errorTime',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Crash, Crash, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Crash, Crash, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logFile',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logFile',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logFile',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logFile',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logFile',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> logFileIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logFile',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'md5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'md5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'md5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'md5',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'md5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'md5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5Contains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'md5',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5Matches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'md5',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'md5',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> md5IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'md5',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stackTrace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stackTrace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stackTrace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stackTrace',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stackTrace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stackTrace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stackTrace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stackTrace',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stackTrace',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> stackTraceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stackTrace',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> uploadedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploaded',
        value: value,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'version',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: '',
      ));
    });
  }

  QueryBuilder<Crash, Crash, QAfterFilterCondition> versionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'version',
        value: '',
      ));
    });
  }
}

extension CrashQueryObject on QueryBuilder<Crash, Crash, QFilterCondition> {}

extension CrashQueryLinks on QueryBuilder<Crash, Crash, QFilterCondition> {}

extension CrashQuerySortBy on QueryBuilder<Crash, Crash, QSortBy> {
  QueryBuilder<Crash, Crash, QAfterSortBy> sortByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceAbi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAbi', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceAbiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAbi', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceNet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceNet', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceNetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceNet', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceRom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceRom', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceRomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceRom', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceSdk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceSdk', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByDeviceSdkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceSdk', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByErrorTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorTime', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByErrorTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorTime', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByLogFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logFile', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByLogFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logFile', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByMd5() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'md5', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByMd5Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'md5', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByStackTrace() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackTrace', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByStackTraceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackTrace', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension CrashQuerySortThenBy on QueryBuilder<Crash, Crash, QSortThenBy> {
  QueryBuilder<Crash, Crash, QAfterSortBy> thenByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceAbi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAbi', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceAbiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceAbi', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceName', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceNet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceNet', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceNetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceNet', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceRom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceRom', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceRomDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceRom', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceSdk() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceSdk', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByDeviceSdkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceSdk', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'error', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByErrorTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorTime', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByErrorTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorTime', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByLogFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logFile', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByLogFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logFile', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByMd5() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'md5', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByMd5Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'md5', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByStackTrace() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackTrace', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByStackTraceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stackTrace', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploaded', Sort.desc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<Crash, Crash, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension CrashQueryWhereDistinct on QueryBuilder<Crash, Crash, QDistinct> {
  QueryBuilder<Crash, Crash, QDistinct> distinctByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'count');
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByDeviceAbi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceAbi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByDeviceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByDeviceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByDeviceNet(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceNet', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByDeviceRom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceRom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByDeviceSdk(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceSdk', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByError(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'error', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByErrorTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByLogFile(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logFile', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByMd5(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'md5', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByStackTrace(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stackTrace', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uploaded');
    });
  }

  QueryBuilder<Crash, Crash, QDistinct> distinctByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version', caseSensitive: caseSensitive);
    });
  }
}

extension CrashQueryProperty on QueryBuilder<Crash, Crash, QQueryProperty> {
  QueryBuilder<Crash, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Crash, int, QQueryOperations> countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'count');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> deviceAbiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceAbi');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> deviceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceId');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> deviceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceName');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> deviceNetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceNet');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> deviceRomProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceRom');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> deviceSdkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceSdk');
    });
  }

  QueryBuilder<Crash, String, QQueryOperations> errorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'error');
    });
  }

  QueryBuilder<Crash, String, QQueryOperations> errorTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorTime');
    });
  }

  QueryBuilder<Crash, String?, QQueryOperations> logFileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logFile');
    });
  }

  QueryBuilder<Crash, String, QQueryOperations> md5Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'md5');
    });
  }

  QueryBuilder<Crash, String, QQueryOperations> stackTraceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stackTrace');
    });
  }

  QueryBuilder<Crash, bool, QQueryOperations> uploadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uploaded');
    });
  }

  QueryBuilder<Crash, String, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
