import 'package:json_annotation/json_annotation.dart';

part 'dine_monthly_overview.g.dart';

/// Dine-level monthly statistics
@JsonSerializable()
class DineMonthlyOverview {
  final double? totalAmountDeposit;
  final int? totalMealConsumed;
  final double? totalPurchaseCost;
  final double? remainingBalance;
  final double? perMealCost;

  const DineMonthlyOverview({
    this.totalAmountDeposit,
    this.totalMealConsumed,
    this.totalPurchaseCost,
    this.remainingBalance,
    this.perMealCost,
  });

  factory DineMonthlyOverview.fromJson(Map<String, dynamic> json) =>
      _$DineMonthlyOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$DineMonthlyOverviewToJson(this);

  @override
  String toString() =>
      'DineMonthlyOverview(totalDeposit: $totalAmountDeposit, totalMeals: $totalMealConsumed, perMealCost: $perMealCost)';
}
