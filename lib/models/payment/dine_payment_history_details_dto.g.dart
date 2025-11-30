// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dine_payment_history_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DinePaymentHistoryDetailsDto _$DinePaymentHistoryDetailsDtoFromJson(
  Map<String, dynamic> json,
) => DinePaymentHistoryDetailsDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  memberInfoDto: json['memberInfoDto'],
  memberInfoId: json['memberInfoId'] as String?,
  paymentDateTime: json['paymentDateTime'] as String?,
  paymentLastUpdateDateTime: json['paymentLastUpdateDateTime'] as String?,
  paidById: json['paidById'] as String?,
  paidByName: json['paidByName'] as String?,
  paymentAmount: (json['paymentAmount'] as num?)?.toDouble(),
  paymentStatusEnumKey: json['paymentStatusEnumKey'] as String?,
  paymentStatusEnumValue: json['paymentStatusEnumValue'] as String?,
  isApprovedByManager: json['isApprovedByManager'] as bool?,
  paymentCreateById: json['paymentCreateById'] as String?,
  paymentCreateByName: json['paymentCreateByName'] as String?,
  enabled: json['enabled'] as bool?,
  createdDate: json['createdDate'] as String?,
);

Map<String, dynamic> _$DinePaymentHistoryDetailsDtoToJson(
  DinePaymentHistoryDetailsDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'dineInfoDto': instance.dineInfoDto,
  'dineInfoId': instance.dineInfoId,
  'memberInfoDto': instance.memberInfoDto,
  'memberInfoId': instance.memberInfoId,
  'paymentDateTime': instance.paymentDateTime,
  'paymentLastUpdateDateTime': instance.paymentLastUpdateDateTime,
  'paidById': instance.paidById,
  'paidByName': instance.paidByName,
  'paymentAmount': instance.paymentAmount,
  'paymentStatusEnumKey': instance.paymentStatusEnumKey,
  'paymentStatusEnumValue': instance.paymentStatusEnumValue,
  'isApprovedByManager': instance.isApprovedByManager,
  'paymentCreateById': instance.paymentCreateById,
  'paymentCreateByName': instance.paymentCreateByName,
  'enabled': instance.enabled,
  'createdDate': instance.createdDate,
};

DinePaymentHistoryDetailsSearchDto _$DinePaymentHistoryDetailsSearchDtoFromJson(
  Map<String, dynamic> json,
) => DinePaymentHistoryDetailsSearchDto(
  id: json['id'] as String?,
  dineInfoDto: json['dineInfoDto'],
  dineInfoId: json['dineInfoId'] as String?,
  memberInfoDto: json['memberInfoDto'],
  memberInfoId: json['memberInfoId'] as String?,
  paymentDateTime: json['paymentDateTime'] as String?,
  paymentDateTimeFrom: json['paymentDateTimeFrom'] as String?,
  paymentDateTimeTo: json['paymentDateTimeTo'] as String?,
  paymentLastUpdateDateTime: json['paymentLastUpdateDateTime'] as String?,
  isApprovedByManager: json['isApprovedByManager'] as bool?,
  paymentCreateById: json['paymentCreateById'] as String?,
  paymentCreateByName: json['paymentCreateByName'] as String?,
  paymentStatusEnumKey: json['paymentStatusEnumKey'] as String?,
  paymentStatusEnumValue: json['paymentStatusEnumValue'] as String?,
  paymentStatusEnumKeyList: (json['paymentStatusEnumKeyList'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  enabled: json['enabled'] as bool?,
  createdDate: json['createdDate'] as String?,
  loadingMode: json['loadingMode'] as bool?,
  updateMode: json['updateMode'] as bool?,
  page: (json['page'] as num?)?.toInt(),
  size: (json['size'] as num?)?.toInt() ?? 10,
  multiSearchProp: json['multiSearchProp'] as String?,
  displayProp: json['displayProp'] as String?,
);

Map<String, dynamic> _$DinePaymentHistoryDetailsSearchDtoToJson(
  DinePaymentHistoryDetailsSearchDto instance,
) => <String, dynamic>{
  'loadingMode': instance.loadingMode,
  'updateMode': instance.updateMode,
  'page': instance.page,
  'size': instance.size,
  'multiSearchProp': instance.multiSearchProp,
  'displayProp': instance.displayProp,
  'id': instance.id,
  'dineInfoDto': instance.dineInfoDto,
  'dineInfoId': instance.dineInfoId,
  'memberInfoDto': instance.memberInfoDto,
  'memberInfoId': instance.memberInfoId,
  'paymentDateTime': instance.paymentDateTime,
  'paymentDateTimeFrom': instance.paymentDateTimeFrom,
  'paymentDateTimeTo': instance.paymentDateTimeTo,
  'paymentLastUpdateDateTime': instance.paymentLastUpdateDateTime,
  'isApprovedByManager': instance.isApprovedByManager,
  'paymentCreateById': instance.paymentCreateById,
  'paymentCreateByName': instance.paymentCreateByName,
  'paymentStatusEnumKey': instance.paymentStatusEnumKey,
  'paymentStatusEnumValue': instance.paymentStatusEnumValue,
  'paymentStatusEnumKeyList': instance.paymentStatusEnumKeyList,
  'enabled': instance.enabled,
  'createdDate': instance.createdDate,
};
