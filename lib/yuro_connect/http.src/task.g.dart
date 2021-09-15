// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['code'] as int,
    json['key'] as String,
    json['data'],
    json['time'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'code': instance.code,
      'key': instance.key,
      'data': instance.data,
      'time': instance.time,
    };
