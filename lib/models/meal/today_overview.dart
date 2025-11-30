import 'package:json_annotation/json_annotation.dart';

part 'today_overview.g.dart';

/// Today's meal overview summary
@JsonSerializable()
class TodayOverview {
  final int? lunch;
  final int? breakfast;
  final int? dinner;
  final int? total;
  final int? totalLunch;
  final int? totalBreakfast;
  final int? totalDinner;
  final int? todayTotal;
  final String? todayDateTime;

  const TodayOverview({
    this.lunch,
    this.breakfast,
    this.dinner,
    this.total,
    this.totalLunch,
    this.totalBreakfast,
    this.totalDinner,
    this.todayTotal,
    this.todayDateTime,
  });

  factory TodayOverview.fromJson(Map<String, dynamic> json) =>
      _$TodayOverviewFromJson(json);

  Map<String, dynamic> toJson() => _$TodayOverviewToJson(this);

  /// Get today's date as DateTime
  DateTime? get todayDate {
    if (todayDateTime == null) return null;
    try {
      return DateTime.parse(todayDateTime!);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() =>
      'TodayOverview(breakfast: $breakfast, lunch: $lunch, dinner: $dinner, total: $total)';
}
