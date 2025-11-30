import 'package:json_annotation/json_annotation.dart';
import 'meal_cost_data.dart';

part 'meal_cost_json_data.g.dart';

/// Meal cost breakdown
@JsonSerializable()
class MealCostJsonData {
  final List<MealCostData>? mealCostDataList;

  const MealCostJsonData({this.mealCostDataList});

  factory MealCostJsonData.fromJson(Map<String, dynamic> json) =>
      _$MealCostJsonDataFromJson(json);

  Map<String, dynamic> toJson() => _$MealCostJsonDataToJson(this);

  /// Calculate total cost from all items
  double get totalCost {
    if (mealCostDataList == null || mealCostDataList!.isEmpty) {
      return 0.0;
    }
    return mealCostDataList!.fold<double>(
      0.0,
      (sum, item) => sum + item.totalCost,
    );
  }

  /// Get total number of items
  int get totalItems => mealCostDataList?.length ?? 0;

  @override
  String toString() =>
      'MealCostJsonData(items: $totalItems, totalCost: $totalCost)';
}
