// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_registration_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPhoneRegisteredRequest _$CheckPhoneRegisteredRequestFromJson(
  Map<String, dynamic> json,
) => CheckPhoneRegisteredRequest(phoneNumber: json['phoneNumber'] as String);

Map<String, dynamic> _$CheckPhoneRegisteredRequestToJson(
  CheckPhoneRegisteredRequest instance,
) => <String, dynamic>{'phoneNumber': instance.phoneNumber};

CheckPhoneRegisteredData _$CheckPhoneRegisteredDataFromJson(
  Map<String, dynamic> json,
) => CheckPhoneRegisteredData(
  phoneNumber: json['phoneNumber'] as String,
  id: json['id'] as String?,
  isPhoneNumberAlreadyRegistered:
      json['isPhoneNumberAlreadyRegistered'] as String?,
);

Map<String, dynamic> _$CheckPhoneRegisteredDataToJson(
  CheckPhoneRegisteredData instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'id': instance.id,
  'isPhoneNumberAlreadyRegistered': instance.isPhoneNumberAlreadyRegistered,
};

SendOtpRequest _$SendOtpRequestFromJson(Map<String, dynamic> json) =>
    SendOtpRequest(phoneNumber: json['phoneNumber'] as String);

Map<String, dynamic> _$SendOtpRequestToJson(SendOtpRequest instance) =>
    <String, dynamic>{'phoneNumber': instance.phoneNumber};

SendOtpData _$SendOtpDataFromJson(Map<String, dynamic> json) => SendOtpData(
  id: json['id'] as String?,
  phoneNumber: json['phoneNumber'] as String,
  otp: json['otp'] as String?,
  otpResponseBody: json['otpResponseBody'] as String?,
  expiryTime: json['expiryTime'] as String?,
  otpExpireTime: json['otpExpireTime'] as String?,
  attempts: (json['attempts'] as num?)?.toInt(),
  isPhoneNumberAlreadyRegistered:
      json['isPhoneNumberAlreadyRegistered'] as String?,
);

Map<String, dynamic> _$SendOtpDataToJson(SendOtpData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'otp': instance.otp,
      'otpResponseBody': instance.otpResponseBody,
      'expiryTime': instance.expiryTime,
      'otpExpireTime': instance.otpExpireTime,
      'attempts': instance.attempts,
      'isPhoneNumberAlreadyRegistered': instance.isPhoneNumberAlreadyRegistered,
    };
