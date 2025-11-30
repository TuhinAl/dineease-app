import 'package:json_annotation/json_annotation.dart';

part 'enum_dto.g.dart';

/// Generic enum wrapper class
@JsonSerializable()
class EnumDto {
  final String? key;
  final String? value;

  const EnumDto({this.key, this.value});

  factory EnumDto.fromJson(Map<String, dynamic> json) =>
      _$EnumDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EnumDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumDto &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;

  @override
  String toString() => 'EnumDto(key: $key, value: $value)';
}
