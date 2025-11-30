import 'package:json_annotation/json_annotation.dart';

part 'subscription_history_dto.g.dart';

/// Subscription payment record
@JsonSerializable()
class SubscriptionHistoryDto {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final String? paymentById;
  final String? paymentByName;
  final String? subscriptionStartDate;
  final String? subscriptionEndDate;
  final String? MFSNumber;
  final String? transactionId;
  final double? amount;
  final bool? enabled;
  final bool? isMFSNumberCorrect;
  final bool? isAmountCorrect;
  final bool? isTransactionIdCorrect;
  final String? createdBy;
  final String? createdDate;
  final String? subscriptionStatusEnumKey;
  final String? subscriptionStatusEnumValue;

  const SubscriptionHistoryDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.paymentById,
    this.paymentByName,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.MFSNumber,
    this.transactionId,
    this.amount,
    this.enabled,
    this.isMFSNumberCorrect,
    this.isAmountCorrect,
    this.isTransactionIdCorrect,
    this.createdBy,
    this.createdDate,
    this.subscriptionStatusEnumKey,
    this.subscriptionStatusEnumValue,
  });

  factory SubscriptionHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionHistoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionHistoryDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionHistoryDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'SubscriptionHistoryDto(id: $id, amount: $amount)';
}
