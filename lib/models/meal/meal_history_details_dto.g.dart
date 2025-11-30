// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_history_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealHistoryDetailsDto _$MealHistoryDetailsDtoFromJson(
  Map<String, dynamic> json,
) => MealHistoryDetailsDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  memberInfoDto: json['memberInfoDto'],
  memberInfoId: json['memberInfoId'] as String?,
  mealDateTime: json['mealDateTime'] as String?,
  mealLastUpdateDateTime: json['mealLastUpdateDateTime'] as String?,
  breakfastMealNumber: (json['breakfastMealNumber'] as num?)?.toInt(),
  lunchMealNumber: (json['lunchMealNumber'] as num?)?.toInt(),
  dinnerMealNumber: (json['dinnerMealNumber'] as num?)?.toInt(),
  totalMealNumber: (json['totalMealNumber'] as num?)?.toInt(),
  mealStatusEnumKey: json['mealStatusEnumKey'] as String?,
  mealStatusEnumValue: json['mealStatusEnumValue'] as String?,
  isApprovedByManager: json['isApprovedByManager'] as bool?,
  mealCreateBy: json['mealCreateBy'] as String?,
  mealCreateById: json['mealCreateById'] as String?,
  mealCreateByName: json['mealCreateByName'] as String?,
  enabled: json['enabled'] as bool?,
  createdBy: json['createdBy'] as String?,
  createdDate: json['createdDate'] as String?,
);

Map<String, dynamic> _$MealHistoryDetailsDtoToJson(
  MealHistoryDetailsDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'dineInfoDto': instance.dineInfoDto,
  'dineInfoId': instance.dineInfoId,
  'memberInfoDto': instance.memberInfoDto,
  'memberInfoId': instance.memberInfoId,
  'mealDateTime': instance.mealDateTime,
  'mealLastUpdateDateTime': instance.mealLastUpdateDateTime,
  'breakfastMealNumber': instance.breakfastMealNumber,
  'lunchMealNumber': instance.lunchMealNumber,
  'dinnerMealNumber': instance.dinnerMealNumber,
  'totalMealNumber': instance.totalMealNumber,
  'mealStatusEnumKey': instance.mealStatusEnumKey,
  'mealStatusEnumValue': instance.mealStatusEnumValue,
  'isApprovedByManager': instance.isApprovedByManager,
  'mealCreateBy': instance.mealCreateBy,
  'mealCreateById': instance.mealCreateById,
  'mealCreateByName': instance.mealCreateByName,
  'enabled': instance.enabled,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate,
};
