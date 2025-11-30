import 'package:json_annotation/json_annotation.dart';

part 'meal_history_details_dto.g.dart';

/// Meal entry details
@JsonSerializable()
class MealHistoryDetailsDto {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final dynamic memberInfoDto; // MemberInfoDto
  final String? memberInfoId;
  final String? mealDateTime;
  final String? mealLastUpdateDateTime;
  final int? breakfastMealNumber;
  final int? lunchMealNumber;
  final int? dinnerMealNumber;
  final int? totalMealNumber;
  final String? mealStatusEnumKey;
  final String? mealStatusEnumValue;
  final bool? isApprovedByManager;
  final String? mealCreateBy;
  final String? mealCreateById;
  final String? mealCreateByName;
  final bool? enabled;
  final String? createdBy;
  final String? createdDate;

  const MealHistoryDetailsDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.memberInfoDto,
    this.memberInfoId,
    this.mealDateTime,
    this.mealLastUpdateDateTime,
    this.breakfastMealNumber,
    this.lunchMealNumber,
    this.dinnerMealNumber,
    this.totalMealNumber,
    this.mealStatusEnumKey,
    this.mealStatusEnumValue,
    this.isApprovedByManager,
    this.mealCreateBy,
    this.mealCreateById,
    this.mealCreateByName,
    this.enabled,
    this.createdBy,
    this.createdDate,
  });

  factory MealHistoryDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$MealHistoryDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealHistoryDetailsDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealHistoryDetailsDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'MealHistoryDetailsDto(id: $id, mealDateTime: $mealDateTime)';
}
