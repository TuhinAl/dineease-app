// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionHistoryDto _$SubscriptionHistoryDtoFromJson(
  Map<String, dynamic> json,
) => SubscriptionHistoryDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  paymentById: json['paymentById'] as String?,
  paymentByName: json['paymentByName'] as String?,
  subscriptionStartDate: json['subscriptionStartDate'] as String?,
  subscriptionEndDate: json['subscriptionEndDate'] as String?,
  MFSNumber: json['MFSNumber'] as String?,
  transactionId: json['transactionId'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  enabled: json['enabled'] as bool?,
  isMFSNumberCorrect: json['isMFSNumberCorrect'] as bool?,
  isAmountCorrect: json['isAmountCorrect'] as bool?,
  isTransactionIdCorrect: json['isTransactionIdCorrect'] as bool?,
  createdBy: json['createdBy'] as String?,
  createdDate: json['createdDate'] as String?,
  subscriptionStatusEnumKey: json['subscriptionStatusEnumKey'] as String?,
  subscriptionStatusEnumValue: json['subscriptionStatusEnumValue'] as String?,
);

Map<String, dynamic> _$SubscriptionHistoryDtoToJson(
  SubscriptionHistoryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'dineInfoDto': instance.dineInfoDto,
  'dineInfoId': instance.dineInfoId,
  'paymentById': instance.paymentById,
  'paymentByName': instance.paymentByName,
  'subscriptionStartDate': instance.subscriptionStartDate,
  'subscriptionEndDate': instance.subscriptionEndDate,
  'MFSNumber': instance.MFSNumber,
  'transactionId': instance.transactionId,
  'amount': instance.amount,
  'enabled': instance.enabled,
  'isMFSNumberCorrect': instance.isMFSNumberCorrect,
  'isAmountCorrect': instance.isAmountCorrect,
  'isTransactionIdCorrect': instance.isTransactionIdCorrect,
  'createdBy': instance.createdBy,
  'createdDate': instance.createdDate,
  'subscriptionStatusEnumKey': instance.subscriptionStatusEnumKey,
  'subscriptionStatusEnumValue': instance.subscriptionStatusEnumValue,
};
