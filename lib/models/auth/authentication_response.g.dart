// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponse _$AuthenticationResponseFromJson(
  Map<String, dynamic> json,
) => AuthenticationResponse(
  id: json['id'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  memberResponse: json['memberResponse'] == null
      ? null
      : MemberResponse.fromJson(json['memberResponse'] as Map<String, dynamic>),
  expiresIn: (json['expiresIn'] as num?)?.toInt(),
  timestamp: json['timestamp'] as String?,
  otp: json['otp'] as String?,
  otpResponseBody: json['otpResponseBody'] as String?,
  expiryTime: json['expiryTime'] as String?,
  attempts: (json['attempts'] as num?)?.toInt(),
  isPhoneNumberAlreadyRegistered:
      json['isPhoneNumberAlreadyRegistered'] as bool?,
);

Map<String, dynamic> _$AuthenticationResponseToJson(
  AuthenticationResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'phoneNumber': instance.phoneNumber,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'memberResponse': instance.memberResponse,
  'expiresIn': instance.expiresIn,
  'timestamp': instance.timestamp,
  'otp': instance.otp,
  'otpResponseBody': instance.otpResponseBody,
  'expiryTime': instance.expiryTime,
  'attempts': instance.attempts,
  'isPhoneNumberAlreadyRegistered': instance.isPhoneNumberAlreadyRegistered,
};
