// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_dine_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalDineInformation _$PersonalDineInformationFromJson(
  Map<String, dynamic> json,
) => PersonalDineInformation(
  personalDineId: json['personalDineId'] as String?,
  personalDineName: json['personalDineName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  isSubscriptionEnabled: json['isSubscriptionEnabled'] as String?,
  subscriptionTypeEnumKey: json['subscriptionTypeEnumKey'] as String?,
  subscriptionTypeEnumValue: json['subscriptionTypeEnumValue'] as String?,
  dineStatusEnumKey: json['dineStatusEnumKey'] as String?,
  dineStatusEnumValue: json['dineStatusEnumValue'] as String?,
  subscriptionStartDate: json['subscriptionStartDate'] as String?,
  subscriptionEndDate: json['subscriptionEndDate'] as String?,
);

Map<String, dynamic> _$PersonalDineInformationToJson(
  PersonalDineInformation instance,
) => <String, dynamic>{
  'personalDineId': instance.personalDineId,
  'personalDineName': instance.personalDineName,
  'phoneNumber': instance.phoneNumber,
  'isSubscriptionEnabled': instance.isSubscriptionEnabled,
  'subscriptionTypeEnumKey': instance.subscriptionTypeEnumKey,
  'subscriptionTypeEnumValue': instance.subscriptionTypeEnumValue,
  'dineStatusEnumKey': instance.dineStatusEnumKey,
  'dineStatusEnumValue': instance.dineStatusEnumValue,
  'subscriptionStartDate': instance.subscriptionStartDate,
  'subscriptionEndDate': instance.subscriptionEndDate,
};
