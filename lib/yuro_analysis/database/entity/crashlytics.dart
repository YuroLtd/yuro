import 'package:objectbox/objectbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crashlytics.g.dart';

@Entity()
@JsonSerializable()
class Crashlytics extends Object {
  @Id()
  int id;
  final String message;
  final String stackTrace;
  final String signature;
  final String appVersion;
  int count;

  @Property(type: PropertyType.date)
  DateTime? updateTime;

  @Property(type: PropertyType.date)
  final DateTime createTime;

  Crashlytics({
    this.id = 0,
    required this.message,
    required this.stackTrace,
    required this.signature,
    required this.appVersion,
    this.count = 1,
    this.updateTime,
    required this.createTime,
  });

  factory Crashlytics.fromJson(Map<String, dynamic> srcJson) => _$CrashlyticsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CrashlyticsToJson(this);
}
