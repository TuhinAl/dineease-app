// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetRequest _$PasswordResetRequestFromJson(
  Map<String, dynamic> json,
) => PasswordResetRequest(
  phoneNumber: json['phoneNumber'] as String,
  password: json['password'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$PasswordResetRequestToJson(
  PasswordResetRequest instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'password': instance.password,
  'confirmPassword': instance.confirmPassword,
};

PasswordResetData _$PasswordResetDataFromJson(Map<String, dynamic> json) =>
    PasswordResetData(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      address: json['address'] as String?,
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$PasswordResetDataToJson(PasswordResetData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'isPhoneVerified': instance.isPhoneVerified,
      'isAdmin': instance.isAdmin,
      'address': instance.address,
      'enabled': instance.enabled,
    };
