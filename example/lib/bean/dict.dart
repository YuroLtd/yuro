import 'package:json_annotation/json_annotation.dart';

part 'dict.g.dart';

@JsonSerializable()
class Dict extends Object {
  @JsonKey(name: 'dictCode')
  final int dictCode;

  @JsonKey(name: 'dictSort')
  final int dictSort;

  @JsonKey(name: 'dictLabel')
  final String dictLabel;

  @JsonKey(name: 'dictValue')
  final String dictValue;

  @JsonKey(name: 'dictType')
  final String dictType;

  Dict(
    this.dictCode,
    this.dictSort,
    this.dictLabel,
    this.dictValue,
    this.dictType,
  );

  factory Dict.fromJson(Map<String, dynamic> srcJson) => _$DictFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DictToJson(this);
}
