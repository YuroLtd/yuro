import 'package:json_annotation/json_annotation.dart';
import 'package:yuro/yuro.dart';

part 'crash_info.g.dart';

@HiveType(typeId: 200)
@JsonSerializable()
class CrashInfo extends HiveObject {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final String stackTrace;

  @HiveField(2)
  final String signature;

  @HiveField(3)
  final String versionName;

  @HiveField(4)
  int count;

  @HiveField(5)
  DateTime? updateTime;

  @HiveField(6)
  final DateTime createTime;

  CrashInfo({
    required this.message,
    required this.stackTrace,
    required this.signature,
    required this.versionName,
    this.count = 1,
    this.updateTime,
    required this.createTime,
  });

  factory CrashInfo.fromJson(Map<String, dynamic> srcJson) => _$CrashInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CrashInfoToJson(this);
}