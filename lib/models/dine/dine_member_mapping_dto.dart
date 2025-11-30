import 'package:json_annotation/json_annotation.dart';

part 'dine_member_mapping_dto.g.dart';

/// Member-Dine relationship mapping
@JsonSerializable()
class DineMemberMappingDto {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final String? dineName;
  final String? employeeInfoId;
  final dynamic memberInfoDto; // MemberInfoDto
  final String? memberInfoId;
  final bool? isAdmin;
  final String? memberDineJoinDate;
  final String? mealLastUpdateDateTime;
  final String? memberInDineStatusEnumKey;
  final String? memberInDineStatusEnumValue;
  final String? dineStatusEnumKey;
  final String? dineStatusEnumValue;
  final String? trialStartDate;
  final String? trialEndDate;
  final bool? enabled;
  final String? createdBy;
  final String? createdDate;

  const DineMemberMappingDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.dineName,
    this.employeeInfoId,
    this.memberInfoDto,
    this.memberInfoId,
    this.isAdmin,
    this.memberDineJoinDate,
    this.mealLastUpdateDateTime,
    this.memberInDineStatusEnumKey,
    this.memberInDineStatusEnumValue,
    this.dineStatusEnumKey,
    this.dineStatusEnumValue,
    this.trialStartDate,
    this.trialEndDate,
    this.enabled,
    this.createdBy,
    this.createdDate,
  });

  factory DineMemberMappingDto.fromJson(Map<String, dynamic> json) =>
      _$DineMemberMappingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DineMemberMappingDtoToJson(this);

  DineMemberMappingDto copyWith({
    String? id,
    dynamic dineInfoDto,
    String? dineInfoId,
    String? dineName,
    String? employeeInfoId,
    dynamic memberInfoDto,
    String? memberInfoId,
    bool? isAdmin,
    String? memberDineJoinDate,
    String? mealLastUpdateDateTime,
    String? memberInDineStatusEnumKey,
    String? memberInDineStatusEnumValue,
    String? dineStatusEnumKey,
    String? dineStatusEnumValue,
    String? trialStartDate,
    String? trialEndDate,
    bool? enabled,
    String? createdBy,
    String? createdDate,
  }) {
    return DineMemberMappingDto(
      id: id ?? this.id,
      dineInfoDto: dineInfoDto ?? this.dineInfoDto,
      dineInfoId: dineInfoId ?? this.dineInfoId,
      dineName: dineName ?? this.dineName,
      employeeInfoId: employeeInfoId ?? this.employeeInfoId,
      memberInfoDto: memberInfoDto ?? this.memberInfoDto,
      memberInfoId: memberInfoId ?? this.memberInfoId,
      isAdmin: isAdmin ?? this.isAdmin,
      memberDineJoinDate: memberDineJoinDate ?? this.memberDineJoinDate,
      mealLastUpdateDateTime:
          mealLastUpdateDateTime ?? this.mealLastUpdateDateTime,
      memberInDineStatusEnumKey:
          memberInDineStatusEnumKey ?? this.memberInDineStatusEnumKey,
      memberInDineStatusEnumValue:
          memberInDineStatusEnumValue ?? this.memberInDineStatusEnumValue,
      dineStatusEnumKey: dineStatusEnumKey ?? this.dineStatusEnumKey,
      dineStatusEnumValue: dineStatusEnumValue ?? this.dineStatusEnumValue,
      trialStartDate: trialStartDate ?? this.trialStartDate,
      trialEndDate: trialEndDate ?? this.trialEndDate,
      enabled: enabled ?? this.enabled,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DineMemberMappingDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'DineMemberMappingDto(id: $id, dineName: $dineName)';
}
