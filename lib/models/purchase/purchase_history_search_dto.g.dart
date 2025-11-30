// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_history_search_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseHistorySearchDto _$PurchaseHistorySearchDtoFromJson(
  Map<String, dynamic> json,
) => PurchaseHistorySearchDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  memberInfoDto: json['memberInfoDto'],
  memberInfoId: json['memberInfoId'] as String?,
  purchaseDateTime: json['purchaseDateTime'] as String?,
  purchaseDateTimeFrom: json['purchaseDateTimeFrom'] as String?,
  purchaseDateTimeTo: json['purchaseDateTimeTo'] as String?,
  mealCostJsonData: json['mealCostJsonData'] == null
      ? null
      : MealCostJsonData.fromJson(
          json['mealCostJsonData'] as Map<String, dynamic>,
        ),
  purchaseStatusEnumKey: json['purchaseStatusEnumKey'] as String?,
  purchaseStatusEnumValue: json['purchaseStatusEnumValue'] as String?,
  approvedById: json['approvedById'] as String?,
  approvedByName: json['approvedByName'] as String?,
  createdBy: json['createdBy'] as String?,
  createdByName: json['createdByName'] as String?,
  updatedById: json['updatedById'] as String?,
  updatedByName: json['updatedByName'] as String?,
  purchaseStatusEnumKeyList:
      (json['purchaseStatusEnumKeyList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  enabled: json['enabled'] as bool?,
  createdDate: json['createdDate'] as String?,
  loadingMode: json['loadingMode'] as bool?,
  updateMode: json['updateMode'] as bool?,
  page: (json['page'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt() ?? 10,
  multiSearchProp: json['multiSearchProp'] as String?,
  displayProp: json['displayProp'] as String?,
);

Map<String, dynamic> _$PurchaseHistorySearchDtoToJson(
  PurchaseHistorySearchDto instance,
) => <String, dynamic>{
  'loadingMode': instance.loadingMode,
  'updateMode': instance.updateMode,
  'page': instance.page,
  'size': instance.size,
  'multiSearchProp': instance.multiSearchProp,
  'displayProp': instance.displayProp,
  'id': instance.id,
  'dineInfoDto': instance.dineInfoDto,
  'dineInfoId': instance.dineInfoId,
  'memberInfoDto': instance.memberInfoDto,
  'memberInfoId': instance.memberInfoId,
  'purchaseDateTime': instance.purchaseDateTime,
  'purchaseDateTimeFrom': instance.purchaseDateTimeFrom,
  'purchaseDateTimeTo': instance.purchaseDateTimeTo,
  'mealCostJsonData': instance.mealCostJsonData,
  'purchaseStatusEnumKey': instance.purchaseStatusEnumKey,
  'purchaseStatusEnumValue': instance.purchaseStatusEnumValue,
  'approvedById': instance.approvedById,
  'approvedByName': instance.approvedByName,
  'createdBy': instance.createdBy,
  'createdByName': instance.createdByName,
  'updatedById': instance.updatedById,
  'updatedByName': instance.updatedByName,
  'purchaseStatusEnumKeyList': instance.purchaseStatusEnumKeyList,
  'enabled': instance.enabled,
  'createdDate': instance.createdDate,
};
