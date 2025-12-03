// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      phoneNumber: json['phoneNumber'] as String,
      otp: json['otp'] as String,
      expiryTime: json['expiryTime'] as String?,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'otp': instance.otp,
      'expiryTime': instance.expiryTime,
    };

VerifyOtpData _$VerifyOtpDataFromJson(Map<String, dynamic> json) =>
    VerifyOtpData(
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      isAdmin: json['isAdmin'] as bool?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
    );

Map<String, dynamic> _$VerifyOtpDataToJson(VerifyOtpData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'isAdmin': instance.isAdmin,
      'isPhoneVerified': instance.isPhoneVerified,
    };

ResendOtpRequest _$ResendOtpRequestFromJson(Map<String, dynamic> json) =>
    ResendOtpRequest(phoneNumber: json['phoneNumber'] as String);

Map<String, dynamic> _$ResendOtpRequestToJson(ResendOtpRequest instance) =>
    <String, dynamic>{'phoneNumber': instance.phoneNumber};

ResendOtpData _$ResendOtpDataFromJson(Map<String, dynamic> json) =>
    ResendOtpData(
      phoneNumber: json['phoneNumber'] as String,
      otpExpireTime: json['otpExpireTime'] as String?,
      otp: json['otp'] as String?,
      otpResponseBody: json['otpResponseBody'] as String?,
      expiryTime: json['expiryTime'] as String?,
    );

Map<String, dynamic> _$ResendOtpDataToJson(ResendOtpData instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'otpExpireTime': instance.otpExpireTime,
      'otp': instance.otp,
      'otpResponseBody': instance.otpResponseBody,
      'expiryTime': instance.expiryTime,
    };
