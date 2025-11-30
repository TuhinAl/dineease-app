import 'package:json_annotation/json_annotation.dart';

part 'notification_data.g.dart';

/// Additional notification metadata
@JsonSerializable()
class NotificationData {
  final String? dineId;
  final String? dineName;
  final String? mealId;
  final String? expenseId;
  final String? paymentId;
  final String? invitationId;
  final String? memberName;
  final double? amount;
  final String? additionalInfo;

  const NotificationData({
    this.dineId,
    this.dineName,
    this.mealId,
    this.expenseId,
    this.paymentId,
    this.invitationId,
    this.memberName,
    this.amount,
    this.additionalInfo,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);

  @override
  String toString() =>
      'NotificationData(dineName: $dineName, memberName: $memberName, amount: $amount)';
}
