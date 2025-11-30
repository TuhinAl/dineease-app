// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationRequest _$AuthenticationRequestFromJson(
  Map<String, dynamic> json,
) => AuthenticationRequest(
  phoneNumber: json['phoneNumber'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$AuthenticationRequestToJson(
  AuthenticationRequest instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'password': instance.password,
};
