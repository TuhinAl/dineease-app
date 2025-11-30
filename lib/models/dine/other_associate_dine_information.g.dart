// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_associate_dine_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherAssociateDineInformation _$OtherAssociateDineInformationFromJson(
  Map<String, dynamic> json,
) => OtherAssociateDineInformation(
  otherDineId: json['otherDineId'] as String?,
  otherDineName: json['otherDineName'] as String?,
  isSubscriptionEnabled: json['isSubscriptionEnabled'] as String?,
  subscriptionTypeEnumKey: json['subscriptionTypeEnumKey'] as String?,
  subscriptionTypeEnumValue: json['subscriptionTypeEnumValue'] as String?,
  dineStatusEnumKey: json['dineStatusEnumKey'] as String?,
  dineStatusEnumValue: json['dineStatusEnumValue'] as String?,
  subscriptionStartDate: json['subscriptionStartDate'] as String?,
  subscriptionEndDate: json['subscriptionEndDate'] as String?,
);

Map<String, dynamic> _$OtherAssociateDineInformationToJson(
  OtherAssociateDineInformation instance,
) => <String, dynamic>{
  'otherDineId': instance.otherDineId,
  'otherDineName': instance.otherDineName,
  'isSubscriptionEnabled': instance.isSubscriptionEnabled,
  'subscriptionTypeEnumKey': instance.subscriptionTypeEnumKey,
  'subscriptionTypeEnumValue': instance.subscriptionTypeEnumValue,
  'dineStatusEnumKey': instance.dineStatusEnumKey,
  'dineStatusEnumValue': instance.dineStatusEnumValue,
  'subscriptionStartDate': instance.subscriptionStartDate,
  'subscriptionEndDate': instance.subscriptionEndDate,
};
