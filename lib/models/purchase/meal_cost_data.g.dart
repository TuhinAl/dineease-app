// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_cost_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCostData _$MealCostDataFromJson(Map<String, dynamic> json) => MealCostData(
  itemName: json['itemName'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  itemCost: (json['itemCost'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MealCostDataToJson(MealCostData instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'quantity': instance.quantity,
      'itemCost': instance.itemCost,
    };
