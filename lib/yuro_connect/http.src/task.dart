import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'key')
  String key;

  @JsonKey(name: 'data')
  dynamic data;

  @JsonKey(name: 'time')
  String time;

  Task(
    this.code,
    this.key,
    this.data,
    this.time,
  );

  factory Task.fromJson(Map<String, dynamic> srcJson) => Task(
        srcJson['code'] as int,
        srcJson['key'] as String,
        srcJson['data'],
        srcJson['time'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'key': key,
        'data': data,
        'time': time,
      };
}
