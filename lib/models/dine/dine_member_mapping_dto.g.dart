// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dine_member_mapping_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DineMemberMappingDto _$DineMemberMappingDtoFromJson(
  Map<String, dynamic> json,
) => DineMemberMappingDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  dineName: json['dineName'] as String?,
  employeeInfoId: json['employeeInfoId'] as String?,
  memberInfoDto: json['memberInfoDto'],
  memberInfoId: json['memberInfoId'] as String?,
  isAdmin: json['isAdmin'] as bool?,
  memberDineJoinDate: json['memberDineJoinDate'] as String?,
  mealLastUpdateDateTime: json['mealLastUpdateDateTime'] as String?,
  memberInDineStatusEnumKey: json['memberInDineStatusEnumKey'] as String?,
  memberInDineStatusEnumValue: json['memberInDineStatusEnumValue'] as String?,
  dineStatusEnumKey: json['dineStatusEnumKey'] as String?,
  dineStatusEnumValue: json['dineStatusEnumValue'] as String?,
  trialStartDate: json['trialStartDate'] as String?,
  trialEndDate: json['trialEndDate'] as String?,
  enabled: json['enabled'] as bool?,
  createdBy: json['createdBy'] as String?,
  createdDate: json['createdDate'] as String?,
);

Map<String, dynamic> _$DineMemberMappingDtoToJson(
  DineMemberMappingDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'dineInfoDto': instance.dineInfoDto,
  'dineInfoId': instance.dineInfoId,
  'dineName': instance.dineName,
  'employeeInfoId': instance.employeeInfoId,
  'memberInfoDto': instance.memberInfoDto,
  'memberInfoId': instance.memberInfoId,
  'isAdmin': instance.isAdmin,
  'memberDineJoinDate': instance.memberDineJoinDate,
  'mealLastUpdateDateTime': instance.mealLastUpdateDateTime,
  'memberInDineStatusEnumKey': instance.memberInDineStatusEnumKey,
  'memberInDineStatusEnumValue': instance.memberInDineStatusEnumValue,
  'dineStatusEnumKey': instance.dineStatusEnumKey,
  'dineStatusEnumValue': instance.dineStatusEnumValue,
  'trialStartDate': instance.trialStartDate,
  'trialEndDate': instance.trialEndDate,
  'enabled': instance.enabled,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate,
};
