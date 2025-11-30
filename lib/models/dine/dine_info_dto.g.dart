// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dine_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DineInfoDto _$DineInfoDtoFromJson(Map<String, dynamic> json) => DineInfoDto(
  id: json['id'] as String?,
  dineName: json['dineName'] as String?,
  totalMember: (json['totalMember'] as num?)?.toInt(),
  currentAdminId: json['currentAdminId'] as String?,
  adminPhoneNumber: json['adminPhoneNumber'] as String?,
  isSubscriptionEnabled: json['isSubscriptionEnabled'] as bool?,
  isInFreeTrial: json['isInFreeTrial'] as bool?,
  trialStartDate: json['trialStartDate'] as String?,
  trialEndDate: json['trialEndDate'] as String?,
  lastSubscriptionEndDate: json['lastSubscriptionEndDate'] as String?,
  subscriptionTypeEnumValue: json['subscriptionTypeEnumValue'] as String?,
  subscriptionTypeEnumKey: json['subscriptionTypeEnumKey'] as String?,
  dineStatusEnumKey: json['dineStatusEnumKey'] as String?,
  dineStatusEnumValue: json['dineStatusEnumValue'] as String?,
  subscriptionStartDate: json['subscriptionStartDate'] as String?,
  subscriptionEndDate: json['subscriptionEndDate'] as String?,
  enabled: json['enabled'] as bool?,
  createdBy: json['createdBy'] as String?,
  createdDate: json['createdDate'] as String?,
  dineMemberMappingDtoList: json['dineMemberMappingDtoList'] as List<dynamic>?,
  memberInfoDtoList: json['memberInfoDtoList'] as List<dynamic>?,
  mealHistoryDetailsDtoList:
      json['mealHistoryDetailsDtoList'] as List<dynamic>?,
  subscriptionHistoryDtoList:
      json['subscriptionHistoryDtoList'] as List<dynamic>?,
);

Map<String, dynamic> _$DineInfoDtoToJson(DineInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dineName': instance.dineName,
      'totalMember': instance.totalMember,
      'currentAdminId': instance.currentAdminId,
      'adminPhoneNumber': instance.adminPhoneNumber,
      'isSubscriptionEnabled': instance.isSubscriptionEnabled,
      'isInFreeTrial': instance.isInFreeTrial,
      'trialStartDate': instance.trialStartDate,
      'trialEndDate': instance.trialEndDate,
      'lastSubscriptionEndDate': instance.lastSubscriptionEndDate,
      'subscriptionTypeEnumValue': instance.subscriptionTypeEnumValue,
      'subscriptionTypeEnumKey': instance.subscriptionTypeEnumKey,
      'dineStatusEnumKey': instance.dineStatusEnumKey,
      'dineStatusEnumValue': instance.dineStatusEnumValue,
      'subscriptionStartDate': instance.subscriptionStartDate,
      'subscriptionEndDate': instance.subscriptionEndDate,
      'enabled': instance.enabled,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate,
      'dineMemberMappingDtoList': instance.dineMemberMappingDtoList,
      'memberInfoDtoList': instance.memberInfoDtoList,
      'mealHistoryDetailsDtoList': instance.mealHistoryDetailsDtoList,
      'subscriptionHistoryDtoList': instance.subscriptionHistoryDtoList,
    };
