class TodayOverview {
  final int? breakfast;
  final int? lunch;
  final int? dinner;
  final int? total;
  final int? totalBreakfast;
  final int? totalLunch;
  final int? totalDinner;
  final int? totalMeals;

  TodayOverview({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.total,
    this.totalBreakfast,
    this.totalLunch,
    this.totalDinner,
    this.totalMeals,
  });

  factory TodayOverview.fromJson(Map<String, dynamic> json) {
    return TodayOverview(
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      dinner: json['dinner'],
      total: json['total'],
      totalBreakfast: json['totalBreakfast'],
      totalLunch: json['totalLunch'],
      totalDinner: json['totalDinner'],
      totalMeals: json['totalMeals'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'total': total,
      'totalBreakfast': totalBreakfast,
      'totalLunch': totalLunch,
      'totalDinner': totalDinner,
      'totalMeals': totalMeals,
    };
  }

  // Mock data for testing
  static TodayOverview mock() {
    return TodayOverview(
      breakfast: 2,
      lunch: 1,
      dinner: 2,
      total: 5,
      totalBreakfast: 8,
      totalLunch: 7,
      totalDinner: 9,
      totalMeals: 24,
    );
  }
}

class DineInfoDto {
  final String? id;
  final String? dineName;
  final DateTime? createdDate;

  DineInfoDto({this.id, this.dineName, this.createdDate});

  factory DineInfoDto.fromJson(Map<String, dynamic> json) {
    return DineInfoDto(
      id: json['id'],
      dineName: json['dineName'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dineName': dineName,
      'createdDate': createdDate?.toIso8601String(),
    };
  }
}
