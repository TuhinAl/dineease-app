import 'package:json_annotation/json_annotation.dart';
import '../common/form_status_with_page.dart';

part 'dine_payment_history_details_dto.g.dart';

/// Payment transaction details
@JsonSerializable()
class DinePaymentHistoryDetailsDto {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final dynamic memberInfoDto; // MemberInfoDto
  final String? memberInfoId;
  final String? paymentDateTime;
  final String? paymentLastUpdateDateTime;
  final String? paidById;
  final String? paidByName;
  final double? paymentAmount;
  final String? paymentStatusEnumKey;
  final String? paymentStatusEnumValue;
  final bool? isApprovedByManager;
  final String? paymentCreateById;
  final String? paymentCreateByName;
  final bool? enabled;
  final String? createdDate;

  const DinePaymentHistoryDetailsDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.memberInfoDto,
    this.memberInfoId,
    this.paymentDateTime,
    this.paymentLastUpdateDateTime,
    this.paidById,
    this.paidByName,
    this.paymentAmount,
    this.paymentStatusEnumKey,
    this.paymentStatusEnumValue,
    this.isApprovedByManager,
    this.paymentCreateById,
    this.paymentCreateByName,
    this.enabled,
    this.createdDate,
  });

  factory DinePaymentHistoryDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$DinePaymentHistoryDetailsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DinePaymentHistoryDetailsDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DinePaymentHistoryDetailsDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'DinePaymentHistoryDetailsDto(id: $id, paymentAmount: $paymentAmount)';
}

/// Search criteria for payments
@JsonSerializable()
class DinePaymentHistoryDetailsSearchDto extends FormStatusWithPage {
  final String? id;
  final dynamic dineInfoDto; // DineInfoDto
  final String? dineInfoId;
  final dynamic memberInfoDto; // MemberInfoDto
  final String? memberInfoId;
  final String? paymentDateTime;
  final String? paymentDateTimeFrom;
  final String? paymentDateTimeTo;
  final String? paymentLastUpdateDateTime;
  final bool? isApprovedByManager;
  final String? paymentCreateById;
  final String? paymentCreateByName;
  final String? paymentStatusEnumKey;
  final String? paymentStatusEnumValue;
  final List<String>? paymentStatusEnumKeyList;
  final bool? enabled;
  final String? createdDate;

  const DinePaymentHistoryDetailsSearchDto({
    this.id,
    this.dineInfoDto,
    this.dineInfoId,
    this.memberInfoDto,
    this.memberInfoId,
    this.paymentDateTime,
    this.paymentDateTimeFrom,
    this.paymentDateTimeTo,
    this.paymentLastUpdateDateTime,
    this.isApprovedByManager,
    this.paymentCreateById,
    this.paymentCreateByName,
    this.paymentStatusEnumKey,
    this.paymentStatusEnumValue,
    this.paymentStatusEnumKeyList,
    this.enabled,
    this.createdDate,
    // FormStatusWithPage properties
    super.loadingMode,
    super.updateMode,
    super.page,
    super.size,
    super.multiSearchProp,
    super.displayProp,
  });

  factory DinePaymentHistoryDetailsSearchDto.fromJson(
    Map<String, dynamic> json,
  ) => _$DinePaymentHistoryDetailsSearchDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$DinePaymentHistoryDetailsSearchDtoToJson(this);

  @override
  String toString() =>
      'DinePaymentHistoryDetailsSearchDto(dineInfoId: $dineInfoId, memberInfoId: $memberInfoId)';
}
