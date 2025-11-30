// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_cost_json_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealCostJsonData _$MealCostJsonDataFromJson(Map<String, dynamic> json) =>
    MealCostJsonData(
      mealCostDataList: (json['mealCostDataList'] as List<dynamic>?)
          ?.map((e) => MealCostData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealCostJsonDataToJson(MealCostJsonData instance) =>
    <String, dynamic>{'mealCostDataList': instance.mealCostDataList};
