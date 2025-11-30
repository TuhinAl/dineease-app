// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dine_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DineSummaryDto _$DineSummaryDtoFromJson(Map<String, dynamic> json) =>
    DineSummaryDto(
      dineOverview: json['dineOverview'] == null
          ? null
          : DineMonthlyOverview.fromJson(
              json['dineOverview'] as Map<String, dynamic>,
            ),
      memberMonthlyOverviewList:
          (json['memberMonthlyOverviewList'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MemberMonthlyOverview.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$DineSummaryDtoToJson(DineSummaryDto instance) =>
    <String, dynamic>{
      'dineOverview': instance.dineOverview,
      'memberMonthlyOverviewList': instance.memberMonthlyOverviewList,
    };
