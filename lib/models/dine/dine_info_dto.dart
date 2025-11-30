import 'package:json_annotation/json_annotation.dart';

part 'dine_info_dto.g.dart';

/// Complete dine/mess information
@JsonSerializable()
class DineInfoDto {
  final String? id;
  final String? dineName;
  final int? totalMember;
  final String? currentAdminId;
  final String? adminPhoneNumber;
  final bool? isSubscriptionEnabled;
  final bool? isInFreeTrial;
  final String? trialStartDate;
  final String? trialEndDate;
  final String? lastSubscriptionEndDate;
  final String? subscriptionTypeEnumValue;
  final String? subscriptionTypeEnumKey;
  final String? dineStatusEnumKey;
  final String? dineStatusEnumValue;
  final String? subscriptionStartDate;
  final String? subscriptionEndDate;
  final bool? enabled;
  final String? createdBy;
  final String? createdDate;
  final List<dynamic>? dineMemberMappingDtoList; // DineMemberMappingDto
  final List<dynamic>? memberInfoDtoList; // MemberInfoDto
  final List<dynamic>? mealHistoryDetailsDtoList; // MealHistoryDetailsDto
  final List<dynamic>? subscriptionHistoryDtoList; // SubscriptionHistoryDto

  const DineInfoDto({
    this.id,
    this.dineName,
    this.totalMember,
    this.currentAdminId,
    this.adminPhoneNumber,
    this.isSubscriptionEnabled,
    this.isInFreeTrial,
    this.trialStartDate,
    this.trialEndDate,
    this.lastSubscriptionEndDate,
    this.subscriptionTypeEnumValue,
    this.subscriptionTypeEnumKey,
    this.dineStatusEnumKey,
    this.dineStatusEnumValue,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.enabled,
    this.createdBy,
    this.createdDate,
    this.dineMemberMappingDtoList,
    this.memberInfoDtoList,
    this.mealHistoryDetailsDtoList,
    this.subscriptionHistoryDtoList,
  });

  factory DineInfoDto.fromJson(Map<String, dynamic> json) =>
      _$DineInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DineInfoDtoToJson(this);

  DineInfoDto copyWith({
    String? id,
    String? dineName,
    int? totalMember,
    String? currentAdminId,
    String? adminPhoneNumber,
    bool? isSubscriptionEnabled,
    bool? isInFreeTrial,
    String? trialStartDate,
    String? trialEndDate,
    String? lastSubscriptionEndDate,
    String? subscriptionTypeEnumValue,
    String? subscriptionTypeEnumKey,
    String? dineStatusEnumKey,
    String? dineStatusEnumValue,
    String? subscriptionStartDate,
    String? subscriptionEndDate,
    bool? enabled,
    String? createdBy,
    String? createdDate,
    List<dynamic>? dineMemberMappingDtoList,
    List<dynamic>? memberInfoDtoList,
    List<dynamic>? mealHistoryDetailsDtoList,
    List<dynamic>? subscriptionHistoryDtoList,
  }) {
    return DineInfoDto(
      id: id ?? this.id,
      dineName: dineName ?? this.dineName,
      totalMember: totalMember ?? this.totalMember,
      currentAdminId: currentAdminId ?? this.currentAdminId,
      adminPhoneNumber: adminPhoneNumber ?? this.adminPhoneNumber,
      isSubscriptionEnabled:
          isSubscriptionEnabled ?? this.isSubscriptionEnabled,
      isInFreeTrial: isInFreeTrial ?? this.isInFreeTrial,
      trialStartDate: trialStartDate ?? this.trialStartDate,
      trialEndDate: trialEndDate ?? this.trialEndDate,
      lastSubscriptionEndDate:
          lastSubscriptionEndDate ?? this.lastSubscriptionEndDate,
      subscriptionTypeEnumValue:
          subscriptionTypeEnumValue ?? this.subscriptionTypeEnumValue,
      subscriptionTypeEnumKey:
          subscriptionTypeEnumKey ?? this.subscriptionTypeEnumKey,
      dineStatusEnumKey: dineStatusEnumKey ?? this.dineStatusEnumKey,
      dineStatusEnumValue: dineStatusEnumValue ?? this.dineStatusEnumValue,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      enabled: enabled ?? this.enabled,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      dineMemberMappingDtoList:
          dineMemberMappingDtoList ?? this.dineMemberMappingDtoList,
      memberInfoDtoList: memberInfoDtoList ?? this.memberInfoDtoList,
      mealHistoryDetailsDtoList:
          mealHistoryDetailsDtoList ?? this.mealHistoryDetailsDtoList,
      subscriptionHistoryDtoList:
          subscriptionHistoryDtoList ?? this.subscriptionHistoryDtoList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DineInfoDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'DineInfoDto(id: $id, dineName: $dineName)';
}
