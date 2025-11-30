// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dine_monthly_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DineMonthlyOverview _$DineMonthlyOverviewFromJson(Map<String, dynamic> json) =>
    DineMonthlyOverview(
      totalAmountDeposit: (json['totalAmountDeposit'] as num?)?.toDouble(),
      totalMealConsumed: (json['totalMealConsumed'] as num?)?.toInt(),
      totalPurchaseCost: (json['totalPurchaseCost'] as num?)?.toDouble(),
      remainingBalance: (json['remainingBalance'] as num?)?.toDouble(),
      perMealCost: (json['perMealCost'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DineMonthlyOverviewToJson(
  DineMonthlyOverview instance,
) => <String, dynamic>{
  'totalAmountDeposit': instance.totalAmountDeposit,
  'totalMealConsumed': instance.totalMealConsumed,
  'totalPurchaseCost': instance.totalPurchaseCost,
  'remainingBalance': instance.remainingBalance,
  'perMealCost': instance.perMealCost,
};
