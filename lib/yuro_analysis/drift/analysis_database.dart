import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:yuro/yuro_core/yuro_core.dart';
import 'package:yuro/yuro_util/yuro_util.dart';

import 'crash_table.dart';

part 'analysis_database.g.dart';

@DriftDatabase(tables: [CrashTable], daos: [CrashDao])
class AnalysisDatabase extends _$AnalysisDatabase {
  static AnalysisDatabase? _instance;

  static AnalysisDatabase get instance {
    if (_instance == null) {
      final executor = LazyDatabase(() async {
        final root = await Yuro.temporaryDirectory.then((dir) => dir.parent);
        final dbFile = File(root.path.join('databases/analysis.db'));
        return NativeDatabase(dbFile);
      });
      _instance = AnalysisDatabase._(executor);
    }
    return _instance!;
  }

  AnalysisDatabase._(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (migrator) async => await migrator.createAll(),
      onUpgrade: (migrator, from, to) async {
        if (from == 1 && to == 2) {
          await migrator.deleteTable(crashTable.actualTableName);
          await migrator.createTable(crashTable);
        }
      });
}
