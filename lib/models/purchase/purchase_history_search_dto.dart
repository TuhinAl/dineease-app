import 'package:json_annotation/json_annotation.dart';
import '../common/form_status_with_page.dart';
import '../purchase/meal_cost_json_data.dart';

part 'purchase_history_search_dto.g.dart';

/// Search criteria for purchases
@JsonSerializable()
class PurchaseHistorySearchDto extends FormStatusWithPage {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final dynamic memberInfoDto; // MemberInfoDto
  final String? memberInfoId;
  final String? purchaseDateTime;
  final String? purchaseDateTimeFrom;
  final String? purchaseDateTimeTo;
  final MealCostJsonData? mealCostJsonData;
  final String? purchaseStatusEnumKey;
  final String? purchaseStatusEnumValue;
  final String? approvedById;
  final String? approvedByName;
  final String? createdBy;
  final String? createdByName;
  final String? updatedById;
  final String? updatedByName;
  final List<String>? purchaseStatusEnumKeyList;
  final bool? enabled;
  final String? createdDate;

  const PurchaseHistorySearchDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.memberInfoDto,
    this.memberInfoId,
    this.purchaseDateTime,
    this.purchaseDateTimeFrom,
    this.purchaseDateTimeTo,
    this.mealCostJsonData,
    this.purchaseStatusEnumKey,
    this.purchaseStatusEnumValue,
    this.approvedById,
    this.approvedByName,
    this.createdBy,
    this.createdByName,
    this.updatedById,
    this.updatedByName,
    this.purchaseStatusEnumKeyList,
    this.enabled,
    this.createdDate,
    // FormStatusWithPage properties
    super.loadingMode,
    super.updateMode,
    super.page,
    super.size,
    super.multiSearchProp,
    super.displayProp,
  });

  factory PurchaseHistorySearchDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseHistorySearchDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PurchaseHistorySearchDtoToJson(this);

  @override
  String toString() =>
      'PurchaseHistorySearchDto(dineInfoId: $dineInfoId, memberInfoId: $memberInfoId)';
}
