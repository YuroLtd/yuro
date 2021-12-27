import 'package:drift/drift.dart';

import 'analysis_database.dart';

part 'crash_table.g.dart';

class CrashTable extends Table {
  // 自增id
  IntColumn get id => integer().autoIncrement()();

  // 位置
  TextColumn get location => text().nullable()();

  // 错误信息
  TextColumn get message => text()();

  // 堆栈信息
  TextColumn get stackTrace => text()();

  // 是否上传
  BoolColumn get upload => boolean().withDefault(const Constant(false))();

  // 创建时间
  DateTimeColumn get createTime => dateTime()();
}

@DriftAccessor(tables: [CrashTable])
class CrashDao extends DatabaseAccessor<AnalysisDatabase> with _$CrashDaoMixin {
  CrashDao(AnalysisDatabase db) : super(db);

  Future<int> add(CrashTableCompanion data) => into(crashTable).insert(data);

  Future<bool> replace(CrashTableData data) => update(crashTable).replace(data.toCompanion(true));

  Future<List<CrashTableData>> noUpload() => (select(crashTable)..where((tbl) => tbl.upload.equals(false))).get();
}
