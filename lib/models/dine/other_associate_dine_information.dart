import 'package:json_annotation/json_annotation.dart';

part 'other_associate_dine_information.g.dart';

/// Other associated dine details
@JsonSerializable()
class OtherAssociateDineInformation {
  final String? otherDineId;
  final String? otherDineName;
  final String? isSubscriptionEnabled;
  final String? subscriptionTypeEnumKey;
  final String? subscriptionTypeEnumValue;
  final String? dineStatusEnumKey;
  final String? dineStatusEnumValue;
  final String? subscriptionStartDate;
  final String? subscriptionEndDate;

  const OtherAssociateDineInformation({
    this.otherDineId,
    this.otherDineName,
    this.isSubscriptionEnabled,
    this.subscriptionTypeEnumKey,
    this.subscriptionTypeEnumValue,
    this.dineStatusEnumKey,
    this.dineStatusEnumValue,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
  });

  factory OtherAssociateDineInformation.fromJson(Map<String, dynamic> json) =>
      _$OtherAssociateDineInformationFromJson(json);

  Map<String, dynamic> toJson() => _$OtherAssociateDineInformationToJson(this);

  @override
  String toString() =>
      'OtherAssociateDineInformation(otherDineName: $otherDineName)';
}
