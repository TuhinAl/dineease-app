// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_monthly_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberMonthlyOverview _$MemberMonthlyOverviewFromJson(
  Map<String, dynamic> json,
) => MemberMonthlyOverview(
  memberInfoDto: json['memberInfoDto'],
  dineInfoDto: json['dineInfoDto'],
  name: json['name'] as String?,
  yourConsumptedMeal: (json['yourConsumptedMeal'] as num?)?.toInt(),
  yourPaymentAmount: (json['yourPaymentAmount'] as num?)?.toDouble(),
  perMealCost: (json['perMealCost'] as num?)?.toDouble(),
  yourTotalMealCost: (json['yourTotalMealCost'] as num?)?.toDouble(),
  electricityBills: (json['electricityBills'] as num?)?.toDouble(),
  internetBills: (json['internetBills'] as num?)?.toDouble(),
  houseKeeperBill: (json['houseKeeperBill'] as num?)?.toDouble(),
  gasBill: (json['gasBill'] as num?)?.toDouble(),
  waterBill: (json['waterBill'] as num?)?.toDouble(),
  dishBill: (json['dishBill'] as num?)?.toDouble(),
  newsPaperBill: (json['newsPaperBill'] as num?)?.toDouble(),
  otherBill: (json['otherBill'] as num?)?.toDouble(),
  extraBill: (json['extraBill'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MemberMonthlyOverviewToJson(
  MemberMonthlyOverview instance,
) => <String, dynamic>{
  'memberInfoDto': instance.memberInfoDto,
  'dineInfoDto': instance.dineInfoDto,
  'name': instance.name,
  'yourConsumptedMeal': instance.yourConsumptedMeal,
  'yourPaymentAmount': instance.yourPaymentAmount,
  'perMealCost': instance.perMealCost,
  'yourTotalMealCost': instance.yourTotalMealCost,
  'electricityBills': instance.electricityBills,
  'internetBills': instance.internetBills,
  'houseKeeperBill': instance.houseKeeperBill,
  'gasBill': instance.gasBill,
  'waterBill': instance.waterBill,
  'dishBill': instance.dishBill,
  'newsPaperBill': instance.newsPaperBill,
  'otherBill': instance.otherBill,
  'extraBill': instance.extraBill,
};
