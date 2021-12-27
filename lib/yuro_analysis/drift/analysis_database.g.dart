// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CrashTableData extends DataClass implements Insertable<CrashTableData> {
  final int id;
  final String? location;
  final String message;
  final String stackTrace;
  final bool upload;
  final DateTime createTime;
  CrashTableData(
      {required this.id,
      this.location,
      required this.message,
      required this.stackTrace,
      required this.upload,
      required this.createTime});
  factory CrashTableData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CrashTableData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      location: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}location']),
      message: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}message'])!,
      stackTrace: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}stack_trace'])!,
      upload: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}upload'])!,
      createTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_time'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String?>(location);
    }
    map['message'] = Variable<String>(message);
    map['stack_trace'] = Variable<String>(stackTrace);
    map['upload'] = Variable<bool>(upload);
    map['create_time'] = Variable<DateTime>(createTime);
    return map;
  }

  CrashTableCompanion toCompanion(bool nullToAbsent) {
    return CrashTableCompanion(
      id: Value(id),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      message: Value(message),
      stackTrace: Value(stackTrace),
      upload: Value(upload),
      createTime: Value(createTime),
    );
  }

  factory CrashTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrashTableData(
      id: serializer.fromJson<int>(json['id']),
      location: serializer.fromJson<String?>(json['location']),
      message: serializer.fromJson<String>(json['message']),
      stackTrace: serializer.fromJson<String>(json['stackTrace']),
      upload: serializer.fromJson<bool>(json['upload']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'location': serializer.toJson<String?>(location),
      'message': serializer.toJson<String>(message),
      'stackTrace': serializer.toJson<String>(stackTrace),
      'upload': serializer.toJson<bool>(upload),
      'createTime': serializer.toJson<DateTime>(createTime),
    };
  }

  CrashTableData copyWith(
          {int? id,
          String? location,
          String? message,
          String? stackTrace,
          bool? upload,
          DateTime? createTime}) =>
      CrashTableData(
        id: id ?? this.id,
        location: location ?? this.location,
        message: message ?? this.message,
        stackTrace: stackTrace ?? this.stackTrace,
        upload: upload ?? this.upload,
        createTime: createTime ?? this.createTime,
      );
  @override
  String toString() {
    return (StringBuffer('CrashTableData(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('message: $message, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('upload: $upload, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, location, message, stackTrace, upload, createTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrashTableData &&
          other.id == this.id &&
          other.location == this.location &&
          other.message == this.message &&
          other.stackTrace == this.stackTrace &&
          other.upload == this.upload &&
          other.createTime == this.createTime);
}

class CrashTableCompanion extends UpdateCompanion<CrashTableData> {
  final Value<int> id;
  final Value<String?> location;
  final Value<String> message;
  final Value<String> stackTrace;
  final Value<bool> upload;
  final Value<DateTime> createTime;
  const CrashTableCompanion({
    this.id = const Value.absent(),
    this.location = const Value.absent(),
    this.message = const Value.absent(),
    this.stackTrace = const Value.absent(),
    this.upload = const Value.absent(),
    this.createTime = const Value.absent(),
  });
  CrashTableCompanion.insert({
    this.id = const Value.absent(),
    this.location = const Value.absent(),
    required String message,
    required String stackTrace,
    this.upload = const Value.absent(),
    required DateTime createTime,
  })  : message = Value(message),
        stackTrace = Value(stackTrace),
        createTime = Value(createTime);
  static Insertable<CrashTableData> custom({
    Expression<int>? id,
    Expression<String?>? location,
    Expression<String>? message,
    Expression<String>? stackTrace,
    Expression<bool>? upload,
    Expression<DateTime>? createTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (location != null) 'location': location,
      if (message != null) 'message': message,
      if (stackTrace != null) 'stack_trace': stackTrace,
      if (upload != null) 'upload': upload,
      if (createTime != null) 'create_time': createTime,
    });
  }

  CrashTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? location,
      Value<String>? message,
      Value<String>? stackTrace,
      Value<bool>? upload,
      Value<DateTime>? createTime}) {
    return CrashTableCompanion(
      id: id ?? this.id,
      location: location ?? this.location,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
      upload: upload ?? this.upload,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (location.present) {
      map['location'] = Variable<String?>(location.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (stackTrace.present) {
      map['stack_trace'] = Variable<String>(stackTrace.value);
    }
    if (upload.present) {
      map['upload'] = Variable<bool>(upload.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrashTableCompanion(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('message: $message, ')
          ..write('stackTrace: $stackTrace, ')
          ..write('upload: $upload, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }
}

class $CrashTableTable extends CrashTable
    with TableInfo<$CrashTableTable, CrashTableData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CrashTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedColumn<String?> location = GeneratedColumn<String?>(
      'location', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedColumn<String?> message = GeneratedColumn<String?>(
      'message', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _stackTraceMeta = const VerificationMeta('stackTrace');
  @override
  late final GeneratedColumn<String?> stackTrace = GeneratedColumn<String?>(
      'stack_trace', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _uploadMeta = const VerificationMeta('upload');
  @override
  late final GeneratedColumn<bool?> upload = GeneratedColumn<bool?>(
      'upload', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (upload IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _createTimeMeta = const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime?> createTime = GeneratedColumn<DateTime?>(
      'create_time', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, location, message, stackTrace, upload, createTime];
  @override
  String get aliasedName => _alias ?? 'crash_table';
  @override
  String get actualTableName => 'crash_table';
  @override
  VerificationContext validateIntegrity(Insertable<CrashTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('stack_trace')) {
      context.handle(
          _stackTraceMeta,
          stackTrace.isAcceptableOrUnknown(
              data['stack_trace']!, _stackTraceMeta));
    } else if (isInserting) {
      context.missing(_stackTraceMeta);
    }
    if (data.containsKey('upload')) {
      context.handle(_uploadMeta,
          upload.isAcceptableOrUnknown(data['upload']!, _uploadMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrashTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CrashTableData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CrashTableTable createAlias(String alias) {
    return $CrashTableTable(_db, alias);
  }
}

abstract class _$AnalysisDatabase extends GeneratedDatabase {
  _$AnalysisDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $CrashTableTable crashTable = $CrashTableTable(this);
  late final CrashDao crashDao = CrashDao(this as AnalysisDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [crashTable];
}
