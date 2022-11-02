// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dict.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dict _$DictFromJson(Map<String, dynamic> json) => Dict(
      json['dictCode'] as int,
      json['dictSort'] as int,
      json['dictLabel'] as String,
      json['dictValue'] as String,
      json['dictType'] as String,
    );

Map<String, dynamic> _$DictToJson(Dict instance) => <String, dynamic>{
      'dictCode': instance.dictCode,
      'dictSort': instance.dictSort,
      'dictLabel': instance.dictLabel,
      'dictValue': instance.dictValue,
      'dictType': instance.dictType,
    };
