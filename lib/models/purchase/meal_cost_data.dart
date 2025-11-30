import 'package:json_annotation/json_annotation.dart';

part 'meal_cost_data.g.dart';

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

  /// Calculate total cost for this item
  double get totalCost => (quantity ?? 0) * (itemCost ?? 0);

  @override
  String toString() =>
      'MealCostData(itemName: $itemName, quantity: $quantity, itemCost: $itemCost)';
}
