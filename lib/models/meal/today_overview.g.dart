// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_overview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayOverview _$TodayOverviewFromJson(Map<String, dynamic> json) =>
    TodayOverview(
      lunch: (json['lunch'] as num?)?.toInt(),
      breakfast: (json['breakfast'] as num?)?.toInt(),
      dinner: (json['dinner'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      totalLunch: (json['totalLunch'] as num?)?.toInt(),
      totalBreakfast: (json['totalBreakfast'] as num?)?.toInt(),
      totalDinner: (json['totalDinner'] as num?)?.toInt(),
      todayTotal: (json['todayTotal'] as num?)?.toInt(),
      todayDateTime: json['todayDateTime'] as String?,
    );

Map<String, dynamic> _$TodayOverviewToJson(TodayOverview instance) =>
    <String, dynamic>{
      'lunch': instance.lunch,
      'breakfast': instance.breakfast,
      'dinner': instance.dinner,
      'total': instance.total,
      'totalLunch': instance.totalLunch,
      'totalBreakfast': instance.totalBreakfast,
      'totalDinner': instance.totalDinner,
      'todayTotal': instance.todayTotal,
      'todayDateTime': instance.todayDateTime,
    };
