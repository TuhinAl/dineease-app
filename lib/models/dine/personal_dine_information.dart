import 'package:json_annotation/json_annotation.dart';

part 'personal_dine_information.g.dart';

/// Personal dine details
@JsonSerializable()
class PersonalDineInformation {
  final String? personalDineId;
  final String? personalDineName;
  final String? phoneNumber;
  final String? isSubscriptionEnabled;
  final String? subscriptionTypeEnumKey;
  final String? subscriptionTypeEnumValue;
  final String? dineStatusEnumKey;
  final String? dineStatusEnumValue;
  final String? subscriptionStartDate;
  final String? subscriptionEndDate;

  const PersonalDineInformation({
    this.personalDineId,
    this.personalDineName,
    this.phoneNumber,
    this.isSubscriptionEnabled,
    this.subscriptionTypeEnumKey,
    this.subscriptionTypeEnumValue,
    this.dineStatusEnumKey,
    this.dineStatusEnumValue,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
  });

  factory PersonalDineInformation.fromJson(Map<String, dynamic> json) =>
      _$PersonalDineInformationFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDineInformationToJson(this);

  @override
  String toString() =>
      'PersonalDineInformation(personalDineName: $personalDineName)';
}
