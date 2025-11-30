class MealHistoryDetailsDto {
  final String? id;
  final DateTime? mealDateTime;
  final int? breakfastMealNumber;
  final int? lunchMealNumber;
  final int? dinnerMealNumber;
  final int? total;
  final String? memberInfoId;

  MealHistoryDetailsDto({
    this.id,
    this.mealDateTime,
    this.breakfastMealNumber,
    this.lunchMealNumber,
    this.dinnerMealNumber,
    this.total,
    this.memberInfoId,
  });

  factory MealHistoryDetailsDto.fromJson(Map<String, dynamic> json) {
    return MealHistoryDetailsDto(
      id: json['id'],
      mealDateTime: json['mealDateTime'] != null
          ? DateTime.parse(json['mealDateTime'])
          : null,
      breakfastMealNumber: json['breakfastMealNumber'],
      lunchMealNumber: json['lunchMealNumber'],
      dinnerMealNumber: json['dinnerMealNumber'],
      total: json['total'],
      memberInfoId: json['memberInfoId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealDateTime': mealDateTime?.toIso8601String(),
      'breakfastMealNumber': breakfastMealNumber,
      'lunchMealNumber': lunchMealNumber,
      'dinnerMealNumber': dinnerMealNumber,
      'total': total,
      'memberInfoId': memberInfoId,
    };
  }

  int get totalMeals =>
      (breakfastMealNumber ?? 0) +
      (lunchMealNumber ?? 0) +
      (dinnerMealNumber ?? 0);
}
