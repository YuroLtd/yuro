// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogRecordAdapter extends TypeAdapter<LogRecord> {
  @override
  final int typeId = 200;

  @override
  LogRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogRecord(
      fields[0] as String,
      fields[1] as LogLevel,
      fields[2] as String,
      fields[4] as String,
      fields[3] as String?,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LogRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tag)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.extra)
      ..writeByte(4)
      ..write(obj.stack)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
