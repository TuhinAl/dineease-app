import 'package:json_annotation/json_annotation.dart';
import 'dine_monthly_overview.dart';
import 'member_monthly_overview.dart';

part 'dine_summary_dto.g.dart';

/// Monthly summary for entire dine
@JsonSerializable()
class DineSummaryDto {
  final DineMonthlyOverview? dineOverview;
  final List<MemberMonthlyOverview>? memberMonthlyOverviewList;

  const DineSummaryDto({this.dineOverview, this.memberMonthlyOverviewList});

  factory DineSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$DineSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DineSummaryDtoToJson(this);

  @override
  String toString() => 'DineSummaryDto(dineOverview: $dineOverview)';
}
