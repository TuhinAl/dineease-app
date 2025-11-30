import 'package:json_annotation/json_annotation.dart';
import '../common/form_status_with_page.dart';

part 'meal_history_details_search_dto.g.dart';

/// Search criteria for meal history
@JsonSerializable()
class MealHistoryDetailsSearchDto extends FormStatusWithPage {
  final String? id;
  final String? dineInfoId;
  final String? memberInfoId;
  final String? mealDateTime;
  final String? mealDateTimeFrom;
  final String? mealDateTimeTo;
  final bool? isApprovedByManager;
  final String? mealCreateById;
  final String? mealCreateByName;
  final String? mealStatusEnumKey;
  final String? mealStatusEnumValue;
  final List<String>? mealStatusEnumKeyList;
  final bool? enabled;
  final String? createdBy;
  final String? createdDate;

  const MealHistoryDetailsSearchDto({
    this.id,
    this.dineInfoId,
    this.memberInfoId,
    this.mealDateTime,
    this.mealDateTimeFrom,
    this.mealDateTimeTo,
    this.isApprovedByManager,
    this.mealCreateById,
    this.mealCreateByName,
    this.mealStatusEnumKey,
    this.mealStatusEnumValue,
    this.mealStatusEnumKeyList,
    this.enabled,
    this.createdBy,
    this.createdDate,
    // FormStatusWithPage properties
    super.loadingMode,
    super.updateMode,
    super.page,
    super.size,
    super.multiSearchProp,
    super.displayProp,
  });

  factory MealHistoryDetailsSearchDto.fromJson(Map<String, dynamic> json) =>
      _$MealHistoryDetailsSearchDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MealHistoryDetailsSearchDtoToJson(this);

  @override
  String toString() =>
      'MealHistoryDetailsSearchDto(dineInfoId: $dineInfoId, memberInfoId: $memberInfoId)';
}
