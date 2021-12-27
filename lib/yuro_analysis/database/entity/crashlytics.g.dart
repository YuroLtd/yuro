// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crashlytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crashlytics _$CrashlyticsFromJson(Map<String, dynamic> json) => Crashlytics(
      id: json['id'] as int? ?? 0,
      message: json['message'] as String,
      stackTrace: json['stackTrace'] as String,
      signature: json['signature'] as String,
      appVersion: json['appVersion'] as String,
      count: json['count'] as int? ?? 1,
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
      createTime: DateTime.parse(json['createTime'] as String),
    );

Map<String, dynamic> _$CrashlyticsToJson(Crashlytics instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'stackTrace': instance.stackTrace,
      'signature': instance.signature,
      'appVersion': instance.appVersion,
      'count': instance.count,
      'updateTime': instance.updateTime?.toIso8601String(),
      'createTime': instance.createTime.toIso8601String(),
    };
