// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crash_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CrashInfoAdapter extends TypeAdapter<CrashInfo> {
  @override
  final int typeId = 200;

  @override
  CrashInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CrashInfo(
      message: fields[0] as String,
      stackTrace: fields[1] as String,
      signature: fields[2] as String,
      versionName: fields[3] as String,
      count: fields[4] as int,
      updateTime: fields[5] as String?,
      createTime: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CrashInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.stackTrace)
      ..writeByte(2)
      ..write(obj.signature)
      ..writeByte(3)
      ..write(obj.versionName)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.updateTime)
      ..writeByte(6)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrashInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CrashInfo _$CrashInfoFromJson(Map<String, dynamic> json) => CrashInfo(
      message: json['message'] as String,
      stackTrace: json['stackTrace'] as String,
      signature: json['signature'] as String,
      versionName: json['versionName'] as String,
      count: json['count'] as int? ?? 1,
      updateTime: json['updateTime'] as String?,
      createTime: json['createTime'] as String,
    );

Map<String, dynamic> _$CrashInfoToJson(CrashInfo instance) => <String, dynamic>{
      'message': instance.message,
      'stackTrace': instance.stackTrace,
      'signature': instance.signature,
      'versionName': instance.versionName,
      'count': instance.count,
      'updateTime': instance.updateTime,
      'createTime': instance.createTime,
    };
