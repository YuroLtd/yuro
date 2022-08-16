// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogLevelAdapter extends TypeAdapter<LogLevel> {
  @override
  final int typeId = 201;

  @override
  LogLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return LogLevel.verbose;
      case 2:
        return LogLevel.info;
      case 3:
        return LogLevel.debug;
      case 4:
        return LogLevel.warring;
      case 5:
        return LogLevel.error;
      default:
        return LogLevel.verbose;
    }
  }

  @override
  void write(BinaryWriter writer, LogLevel obj) {
    switch (obj) {
      case LogLevel.verbose:
        writer.writeByte(1);
        break;
      case LogLevel.info:
        writer.writeByte(2);
        break;
      case LogLevel.debug:
        writer.writeByte(3);
        break;
      case LogLevel.warring:
        writer.writeByte(4);
        break;
      case LogLevel.error:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
