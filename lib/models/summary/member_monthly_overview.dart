import 'package:json_annotation/json_annotation.dart';

part 'member_monthly_overview.g.dart';

/// Member-level monthly statistics
@JsonSerializable()
class MemberMonthlyOverview {
  final dynamic memberInfoDto; // MemberInfoDto
  final dynamic dineInfoDto; // DineInfoDto
  final String? name;
  final int? yourConsumptedMeal;
  final double? yourPaymentAmount;
  final double? perMealCost;
  final double? yourTotalMealCost;
  final double? electricityBills;
  final double? internetBills;
  final double? houseKeeperBill;
  final double? gasBill;
  final double? waterBill;
  final double? dishBill;
  final double? newsPaperBill;
  final double? otherBill;
  final double? extraBill;

  const MemberMonthlyOverview({
    this.memberInfoDto,
    this.dineInfoDto,
    this.name,
    this.yourConsumptedMeal,
    this.yourPaymentAmount,
    this.perMealCost,
    this.yourTotalMealCost,
    this.electricityBills,
    this.internetBills,
    this.houseKeeperBill,
    this.gasBill,
    this.waterBill,
    this.dishBill,
    this.newsPaperBill,
    this.otherBill,
    this.extraBill,
  });

  factory MemberMonthlyOverview.fromJson(Map<String, dynamic> json) =>
      _$MemberMonthlyOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$MemberMonthlyOverviewToJson(this);

  @override
  String toString() =>
      'MemberMonthlyOverview(name: $name, yourConsumptedMeal: $yourConsumptedMeal)';
}
