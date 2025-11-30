// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_history_details_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealHistoryDetailsSearchDto _$MealHistoryDetailsSearchDtoFromJson(
  Map<String, dynamic> json,
) => MealHistoryDetailsSearchDto(
  id: json['id'] as String?,
  dineInfoId: json['dineInfoId'] as String?,
  memberInfoId: json['memberInfoId'] as String?,
  mealDateTime: json['mealDateTime'] as String?,
  mealDateTimeFrom: json['mealDateTimeFrom'] as String?,
  mealDateTimeTo: json['mealDateTimeTo'] as String?,
  isApprovedByManager: json['isApprovedByManager'] as bool?,
  mealCreateById: json['mealCreateById'] as String?,
  mealCreateByName: json['mealCreateByName'] as String?,
  mealStatusEnumKey: json['mealStatusEnumKey'] as String?,
  mealStatusEnumValue: json['mealStatusEnumValue'] as String?,
  mealStatusEnumKeyList: (json['mealStatusEnumKeyList'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  enabled: json['enabled'] as bool?,
  createdBy: json['createdBy'] as String?,
  createdDate: json['createdDate'] as String?,
  loadingMode: json['loadingMode'] as bool?,
  updateMode: json['updateMode'] as bool?,
  page: (json['page'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt() ?? 10,
  multiSearchProp: json['multiSearchProp'] as String?,
  displayProp: json['displayProp'] as String?,
);

Map<String, dynamic> _$MealHistoryDetailsSearchDtoToJson(
  MealHistoryDetailsSearchDto instance,
) => <String, dynamic>{
  'loadingMode': instance.loadingMode,
  'updateMode': instance.updateMode,
  'page': instance.page,
  'size': instance.size,
  'multiSearchProp': instance.multiSearchProp,
  'displayProp': instance.displayProp,
  'id': instance.id,
  'dineInfoId': instance.dineInfoId,
  'memberInfoId': instance.memberInfoId,
  'mealDateTime': instance.mealDateTime,
  'mealDateTimeFrom': instance.mealDateTimeFrom,
  'mealDateTimeTo': instance.mealDateTimeTo,
  'isApprovedByManager': instance.isApprovedByManager,
  'mealCreateById': instance.mealCreateById,
  'mealCreateByName': instance.mealCreateByName,
  'mealStatusEnumKey': instance.mealStatusEnumKey,
  'mealStatusEnumValue': instance.mealStatusEnumValue,
  'mealStatusEnumKeyList': instance.mealStatusEnumKeyList,
  'enabled': instance.enabled,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate,
};
