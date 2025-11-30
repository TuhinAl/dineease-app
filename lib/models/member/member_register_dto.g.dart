// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberRegisterDto _$MemberRegisterDtoFromJson(Map<String, dynamic> json) =>
    MemberRegisterDto(
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      otp: json['otp'] as String?,
      otpResponseBody: json['otpResponseBody'] as String?,
      expiryTime: json['expiryTime'] as String?,
      attempts: (json['attempts'] as num?)?.toInt(),
      isPhoneNumberAlreadyRegistered:
          json['isPhoneNumberAlreadyRegistered'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      address: json['address'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      isAcceptTermsAndCondition: json['isAcceptTermsAndCondition'] as bool?,
    );

Map<String, dynamic> _$MemberRegisterDtoToJson(MemberRegisterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'otp': instance.otp,
      'otpResponseBody': instance.otpResponseBody,
      'expiryTime': instance.expiryTime,
      'attempts': instance.attempts,
      'isPhoneNumberAlreadyRegistered': instance.isPhoneNumberAlreadyRegistered,
      'fullName': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'address': instance.address,
      'isPhoneVerified': instance.isPhoneVerified,
      'isAcceptTermsAndCondition': instance.isAcceptTermsAndCondition,
    };
