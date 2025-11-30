// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoDto _$MemberInfoDtoFromJson(Map<String, dynamic> json) =>
    MemberInfoDto(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
      otp: json['otp'] as String?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      address: json['address'] as String?,
      memberTypeEnumKey: json['memberTypeEnumKey'] as String?,
      memberTypeEnumValue: json['memberTypeEnumValue'] as String?,
      numberOfFreeDineAssociated: json['numberOfFreeDineAssociated'] as String?,
      dineInfoDtoList: json['dineInfoDtoList'] as List<dynamic>?,
      personalDineInfoDto: json['personalDineInfoDto'],
      dineMemberMappingDtoList:
          json['dineMemberMappingDtoList'] as List<dynamic>?,
      roles: json['roles'] as String?,
      isLeavedFromDine: json['isLeavedFromDine'] as bool?,
      enabled: json['enabled'] as bool?,
      isCreatePersonalDine: json['isCreatePersonalDine'] as bool?,
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] as String?,
      otpExpireTime: json['otpExpireTime'] as String?,
      isAcceptTermsAndCondition: json['isAcceptTermsAndCondition'] as bool?,
    );

Map<String, dynamic> _$MemberInfoDtoToJson(MemberInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'otp': instance.otp,
      'isPhoneVerified': instance.isPhoneVerified,
      'isAdmin': instance.isAdmin,
      'address': instance.address,
      'memberTypeEnumKey': instance.memberTypeEnumKey,
      'memberTypeEnumValue': instance.memberTypeEnumValue,
      'numberOfFreeDineAssociated': instance.numberOfFreeDineAssociated,
      'dineInfoDtoList': instance.dineInfoDtoList,
      'personalDineInfoDto': instance.personalDineInfoDto,
      'dineMemberMappingDtoList': instance.dineMemberMappingDtoList,
      'roles': instance.roles,
      'isLeavedFromDine': instance.isLeavedFromDine,
      'enabled': instance.enabled,
      'isCreatePersonalDine': instance.isCreatePersonalDine,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate,
      'otpExpireTime': instance.otpExpireTime,
      'isAcceptTermsAndCondition': instance.isAcceptTermsAndCondition,
    };
