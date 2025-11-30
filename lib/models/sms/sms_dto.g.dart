// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SMSDto _$SMSDtoFromJson(Map<String, dynamic> json) => SMSDto(
  id: json['id'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  otp: json['otp'] as String?,
  otpResponseBody: json['otpResponseBody'] as String?,
  expiryTime: json['expiryTime'] as String?,
  attempts: (json['attempts'] as num?)?.toInt(),
  isPhoneNumberAlreadyRegistered:
      json['isPhoneNumberAlreadyRegistered'] as String?,
);

Map<String, dynamic> _$SMSDtoToJson(SMSDto instance) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'otp': instance.otp,
  'otpResponseBody': instance.otpResponseBody,
  'expiryTime': instance.expiryTime,
  'attempts': instance.attempts,
  'isPhoneNumberAlreadyRegistered': instance.isPhoneNumberAlreadyRegistered,
};
