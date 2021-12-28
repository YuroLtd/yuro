// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'yuro_analysis/database/entity/crashlytics.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2166427515231783681),
      name: 'Crashlytics',
      lastPropertyId: const IdUid(9, 7863920069893869688),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6524685166175126976),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5044687683448065219),
            name: 'message',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4258367292128595081),
            name: 'stackTrace',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5389308543853405858),
            name: 'signature',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 170518655265141605),
            name: 'count',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8180311926041821906),
            name: 'updateTime',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6019690279984175325),
            name: 'createTime',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7863920069893869688),
            name: 'appVersion',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 2166427515231783681),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [1641745294035736525],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Crashlytics: EntityDefinition<Crashlytics>(
        model: _entities[0],
        toOneRelations: (Crashlytics object) => [],
        toManyRelations: (Crashlytics object) => {},
        getId: (Crashlytics object) => object.id,
        setId: (Crashlytics object, int id) {
          object.id = id;
        },
        objectToFB: (Crashlytics object, fb.Builder fbb) {
          final messageOffset = fbb.writeString(object.message);
          final stackTraceOffset = fbb.writeString(object.stackTrace);
          final signatureOffset = fbb.writeString(object.signature);
          final appVersionOffset = fbb.writeString(object.appVersion);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, messageOffset);
          fbb.addOffset(2, stackTraceOffset);
          fbb.addOffset(3, signatureOffset);
          fbb.addInt64(4, object.count);
          fbb.addInt64(6, object.updateTime?.millisecondsSinceEpoch);
          fbb.addInt64(7, object.createTime.millisecondsSinceEpoch);
          fbb.addOffset(8, appVersionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final updateTimeValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 16);
          final object = Crashlytics(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              message:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              stackTrace:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
              signature:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              appVersion:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 20, ''),
              count:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0),
              updateTime: updateTimeValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(updateTimeValue),
              createTime: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0)));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Crashlytics] entity fields to define ObjectBox queries.
class Crashlytics_ {
  /// see [Crashlytics.id]
  static final id =
      QueryIntegerProperty<Crashlytics>(_entities[0].properties[0]);

  /// see [Crashlytics.message]
  static final message =
      QueryStringProperty<Crashlytics>(_entities[0].properties[1]);

  /// see [Crashlytics.stackTrace]
  static final stackTrace =
      QueryStringProperty<Crashlytics>(_entities[0].properties[2]);

  /// see [Crashlytics.signature]
  static final signature =
      QueryStringProperty<Crashlytics>(_entities[0].properties[3]);

  /// see [Crashlytics.count]
  static final count =
      QueryIntegerProperty<Crashlytics>(_entities[0].properties[4]);

  /// see [Crashlytics.updateTime]
  static final updateTime =
      QueryIntegerProperty<Crashlytics>(_entities[0].properties[5]);

  /// see [Crashlytics.createTime]
  static final createTime =
      QueryIntegerProperty<Crashlytics>(_entities[0].properties[6]);

  /// see [Crashlytics.appVersion]
  static final appVersion =
      QueryStringProperty<Crashlytics>(_entities[0].properties[7]);
}
