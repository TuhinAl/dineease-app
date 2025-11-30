// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCostData _$MealCostDataFromJson(Map<String, dynamic> json) => MealCostData(
  itemName: json['itemName'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  itemCost: (json['itemCost'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MealCostDataToJson(MealCostData instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'quantity': instance.quantity,
      'itemCost': instance.itemCost,
    };

PurchaserMemberInfos _$PurchaserMemberInfosFromJson(
  Map<String, dynamic> json,
) => PurchaserMemberInfos(
  id: json['id'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$PurchaserMemberInfosToJson(
  PurchaserMemberInfos instance,
) => <String, dynamic>{'id': instance.id, 'phoneNumber': instance.phoneNumber};

PurchaseHistoryDetailsDto _$PurchaseHistoryDetailsDtoFromJson(
  Map<String, dynamic> json,
) => PurchaseHistoryDetailsDto(
  id: json['id'] as String?,
  utilityCostDateTime: json['utilityCostDateTime'] as String?,
  mealCostJsonData: json['mealCostJsonData'] == null
      ? null
      : MealCostJsonData.fromJson(
          json['mealCostJsonData'] as Map<String, dynamic>,
        ),
  memberInfoDto: json['memberInfoDto'],
  memberInfoId: json['memberInfoId'] as String?,
  purchaseSubTypeEnumKey: json['purchaseSubTypeEnumKey'] as String?,
  purchaseSubTypeEnumValue: json['purchaseSubTypeEnumValue'] as String?,
  costAmount: (json['costAmount'] as num?)?.toDouble(),
  totalPerson: (json['totalPerson'] as num?)?.toInt(),
  perPerson: (json['perPerson'] as num?)?.toDouble(),
  electricityBill: (json['electricityBill'] as num?)?.toDouble(),
  houseKeeperBill: (json['houseKeeperBill'] as num?)?.toDouble(),
  dishBill: (json['dishBill'] as num?)?.toDouble(),
  newsPapersBill: (json['newsPapersBill'] as num?)?.toDouble(),
  internetBill: (json['internetBill'] as num?)?.toDouble(),
  gasBill: (json['gasBill'] as num?)?.toDouble(),
  waterBill: (json['waterBill'] as num?)?.toDouble(),
  othersBill: (json['othersBill'] as num?)?.toDouble(),
  isApprovedByManager: json['isApprovedByManager'] as bool?,
  costBearByAllMember: json['costBearByAllMember'] as bool?,
  costBearBySelectedMember: json['costBearBySelectedMember'] as bool?,
  createdBy: json['createdBy'] as String?,
  createdByName: json['createdByName'] as String?,
  updatedById: json['updatedById'] as String?,
  updatedByName: json['updatedByName'] as String?,
  createdDate: json['createdDate'] as String?,
);

Map<String, dynamic> _$PurchaseHistoryDetailsDtoToJson(
  PurchaseHistoryDetailsDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'utilityCostDateTime': instance.utilityCostDateTime,
  'mealCostJsonData': instance.mealCostJsonData,
  'memberInfoDto': instance.memberInfoDto,
  'memberInfoId': instance.memberInfoId,
  'purchaseSubTypeEnumKey': instance.purchaseSubTypeEnumKey,
  'purchaseSubTypeEnumValue': instance.purchaseSubTypeEnumValue,
  'costAmount': instance.costAmount,
  'totalPerson': instance.totalPerson,
  'perPerson': instance.perPerson,
  'electricityBill': instance.electricityBill,
  'houseKeeperBill': instance.houseKeeperBill,
  'dishBill': instance.dishBill,
  'newsPapersBill': instance.newsPapersBill,
  'internetBill': instance.internetBill,
  'gasBill': instance.gasBill,
  'waterBill': instance.waterBill,
  'othersBill': instance.othersBill,
  'isApprovedByManager': instance.isApprovedByManager,
  'costBearByAllMember': instance.costBearByAllMember,
  'costBearBySelectedMember': instance.costBearBySelectedMember,
  'createdBy': instance.createdBy,
  'createdByName': instance.createdByName,
  'updatedById': instance.updatedById,
  'updatedByName': instance.updatedByName,
  'createdDate': instance.createdDate,
};

PurchaseHistoryDto _$PurchaseHistoryDtoFromJson(
  Map<String, dynamic> json,
) => PurchaseHistoryDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  purchaserId: json['purchaserId'] as String?,
  purchaserName: json['purchaserName'] as String?,
  memberInfoDto: json['memberInfoDto'],
  purchaseHistoryDetailsDto: json['purchaseHistoryDetailsDto'] == null
      ? null
      : PurchaseHistoryDetailsDto.fromJson(
          json['purchaseHistoryDetailsDto'] as Map<String, dynamic>,
        ),
  purchaserMemberInfosList: (json['purchaserMemberInfosList'] as List<dynamic>?)
      ?.map((e) => PurchaserMemberInfos.fromJson(e as Map<String, dynamic>))
      .toList(),
  purchaseHistoryDetailsDtoList:
      (json['purchaseHistoryDetailsDtoList'] as List<dynamic>?)
          ?.map(
            (e) =>
                PurchaseHistoryDetailsDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  memberInfoId: json['memberInfoId'] as String?,
  totalCost: (json['totalCost'] as num?)?.toDouble(),
  purchaseDateTime: json['purchaseDateTime'] as String?,
  mealCostJsonData: json['mealCostJsonData'] == null
      ? null
      : MealCostJsonData.fromJson(
          json['mealCostJsonData'] as Map<String, dynamic>,
        ),
  purchaseStatusEnumKey: json['purchaseStatusEnumKey'] as String?,
  purchaseStatusEnumValue: json['purchaseStatusEnumValue'] as String?,
  purchaseTypeEnumKey: json['purchaseTypeEnumKey'] as String?,
  purchaseTypeEnumValue: json['purchaseTypeEnumValue'] as String?,
  approvedById: json['approvedById'] as String?,
  approvedByName: json['approvedByName'] as String?,
  createdBy: json['createdBy'] as String?,
  createdByName: json['createdByName'] as String?,
  updatedById: json['updatedById'] as String?,
  updatedByName: json['updatedByName'] as String?,
  createdDate: json['createdDate'] as String?,
);

Map<String, dynamic> _$PurchaseHistoryDtoToJson(PurchaseHistoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dineInfoDto': instance.dineInfoDto,
      'dineInfoId': instance.dineInfoId,
      'purchaserId': instance.purchaserId,
      'purchaserName': instance.purchaserName,
      'memberInfoDto': instance.memberInfoDto,
      'purchaseHistoryDetailsDto': instance.purchaseHistoryDetailsDto,
      'purchaserMemberInfosList': instance.purchaserMemberInfosList,
      'purchaseHistoryDetailsDtoList': instance.purchaseHistoryDetailsDtoList,
      'memberInfoId': instance.memberInfoId,
      'totalCost': instance.totalCost,
      'purchaseDateTime': instance.purchaseDateTime,
      'mealCostJsonData': instance.mealCostJsonData,
      'purchaseStatusEnumKey': instance.purchaseStatusEnumKey,
      'purchaseStatusEnumValue': instance.purchaseStatusEnumValue,
      'purchaseTypeEnumKey': instance.purchaseTypeEnumKey,
      'purchaseTypeEnumValue': instance.purchaseTypeEnumValue,
      'approvedById': instance.approvedById,
      'approvedByName': instance.approvedByName,
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'updatedById': instance.updatedById,
      'updatedByName': instance.updatedByName,
      'createdDate': instance.createdDate,
    };
