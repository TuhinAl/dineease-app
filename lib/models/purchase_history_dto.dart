import 'package:json_annotation/json_annotation.dart';
import 'purchase/meal_cost_json_data.dart';

part 'purchase_history_dto.g.dart';

/// Individual meal cost item
@JsonSerializable()
class MealCostData {
  final String? itemName;
  final int? quantity;
  final double? itemCost;

  const MealCostData({this.itemName, this.quantity, this.itemCost});

  factory MealCostData.fromJson(Map<String, dynamic> json) =>
      _$MealCostDataFromJson(json);

  Map<String, dynamic> toJson() => _$MealCostDataToJson(this);

  double get calculatedTotal => (quantity ?? 0) * (itemCost ?? 0);

  @override
  String toString() =>
      'MealCostData(itemName: $itemName, quantity: $quantity, itemCost: $itemCost)';
}

/// Purchaser member reference
@JsonSerializable()
class PurchaserMemberInfos {
  final String? id;
  final String? phoneNumber;

  const PurchaserMemberInfos({this.id, this.phoneNumber});

  factory PurchaserMemberInfos.fromJson(Map<String, dynamic> json) =>
      _$PurchaserMemberInfosFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaserMemberInfosToJson(this);

  @override
  String toString() =>
      'PurchaserMemberInfos(id: $id, phoneNumber: $phoneNumber)';
}

/// Detailed purchase/expense information
@JsonSerializable()
class PurchaseHistoryDetailsDto {
  final String? id;
  final String? utilityCostDateTime;
  final MealCostJsonData? mealCostJsonData;
  final dynamic memberInfoDto; // MemberInfoDto
  final String? memberInfoId;
  final String? purchaseSubTypeEnumKey;
  final String? purchaseSubTypeEnumValue;
  final double? costAmount;
  final int? totalPerson;
  final double? perPerson;
  final double? electricityBill;
  final double? houseKeeperBill;
  final double? dishBill;
  final double? newsPapersBill;
  final double? internetBill;
  final double? gasBill;
  final double? waterBill;
  final double? othersBill;
  final bool? isApprovedByManager;
  final bool? costBearByAllMember;
  final bool? costBearBySelectedMember;
  final String? createdBy;
  final String? createdByName;
  final String? updatedById;
  final String? updatedByName;
  final String? createdDate;

  const PurchaseHistoryDetailsDto({
    this.id,
    this.utilityCostDateTime,
    this.mealCostJsonData,
    this.memberInfoDto,
    this.memberInfoId,
    this.purchaseSubTypeEnumKey,
    this.purchaseSubTypeEnumValue,
    this.costAmount,
    this.totalPerson,
    this.perPerson,
    this.electricityBill,
    this.houseKeeperBill,
    this.dishBill,
    this.newsPapersBill,
    this.internetBill,
    this.gasBill,
    this.waterBill,
    this.othersBill,
    this.isApprovedByManager,
    this.costBearByAllMember,
    this.costBearBySelectedMember,
    this.createdBy,
    this.createdByName,
    this.updatedById,
    this.updatedByName,
    this.createdDate,
  });

  factory PurchaseHistoryDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseHistoryDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseHistoryDetailsDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseHistoryDetailsDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'PurchaseHistoryDetailsDto(id: $id, utilityCostDateTime: $utilityCostDateTime)';
}

/// Purchase record with details
@JsonSerializable()
class PurchaseHistoryDto {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final String? purchaserId;
  final String? purchaserName;
  final dynamic memberInfoDto; // MemberInfoDto
  final PurchaseHistoryDetailsDto? purchaseHistoryDetailsDto;
  final List<PurchaserMemberInfos>? purchaserMemberInfosList;
  final List<PurchaseHistoryDetailsDto>? purchaseHistoryDetailsDtoList;
  final String? memberInfoId;
  final double? totalCost;
  final String? purchaseDateTime;
  final MealCostJsonData? mealCostJsonData;
  final String? purchaseStatusEnumKey;
  final String? purchaseStatusEnumValue;
  final String? purchaseTypeEnumKey;
  final String? purchaseTypeEnumValue;
  final String? approvedById;
  final String? approvedByName;
  final String? createdBy;
  final String? createdByName;
  final String? updatedById;
  final String? updatedByName;
  final String? createdDate;

  const PurchaseHistoryDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.purchaserId,
    this.purchaserName,
    this.memberInfoDto,
    this.purchaseHistoryDetailsDto,
    this.purchaserMemberInfosList,
    this.purchaseHistoryDetailsDtoList,
    this.memberInfoId,
    this.totalCost,
    this.purchaseDateTime,
    this.mealCostJsonData,
    this.purchaseStatusEnumKey,
    this.purchaseStatusEnumValue,
    this.purchaseTypeEnumKey,
    this.purchaseTypeEnumValue,
    this.approvedById,
    this.approvedByName,
    this.createdBy,
    this.createdByName,
    this.updatedById,
    this.updatedByName,
    this.createdDate,
  });

  factory PurchaseHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseHistoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseHistoryDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PurchaseHistoryDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'PurchaseHistoryDto(id: $id, purchaserName: $purchaserName, totalCost: $totalCost)';
}
