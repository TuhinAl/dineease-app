// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      dineId: json['dineId'] as String?,
      dineName: json['dineName'] as String?,
      mealId: json['mealId'] as String?,
      expenseId: json['expenseId'] as String?,
      paymentId: json['paymentId'] as String?,
      invitationId: json['invitationId'] as String?,
      memberName: json['memberName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      additionalInfo: json['additionalInfo'] as String?,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'dineId': instance.dineId,
      'dineName': instance.dineName,
      'mealId': instance.mealId,
      'expenseId': instance.expenseId,
      'paymentId': instance.paymentId,
      'invitationId': instance.invitationId,
      'memberName': instance.memberName,
      'amount': instance.amount,
      'additionalInfo': instance.additionalInfo,
    };
