import 'package:json_annotation/json_annotation.dart';

part 'member_info_dto.g.dart';

/// Complete member information
@JsonSerializable()
class MemberInfoDto {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? confirmPassword;
  final String? otp;
  final bool? isPhoneVerified;
  final bool? isAdmin;
  final String? address;
  final String? memberTypeEnumKey;
  final String? memberTypeEnumValue;
  final String? numberOfFreeDineAssociated;
  final List<dynamic>?
  dineInfoDtoList; // Will be DineInfoDto after circular dependency resolved
  final dynamic
  personalDineInfoDto; // Will be DineInfoDto after circular dependency resolved
  final List<dynamic>?
  dineMemberMappingDtoList; // Will be DineMemberMappingDto after circular dependency resolved
  final String? roles;
  final bool? isLeavedFromDine;
  final bool? enabled;
  final bool? isCreatePersonalDine;
  final String? createdBy;
  final String? createdDate;
  final String? otpExpireTime;
  final bool? isAcceptTermsAndCondition;

  const MemberInfoDto({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
    this.otp,
    this.isPhoneVerified,
    this.isAdmin,
    this.address,
    this.memberTypeEnumKey,
    this.memberTypeEnumValue,
    this.numberOfFreeDineAssociated,
    this.dineInfoDtoList,
    this.personalDineInfoDto,
    this.dineMemberMappingDtoList,
    this.roles,
    this.isLeavedFromDine,
    this.enabled,
    this.isCreatePersonalDine,
    this.createdBy,
    this.createdDate,
    this.otpExpireTime,
    this.isAcceptTermsAndCondition,
  });

  factory MemberInfoDto.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MemberInfoDtoToJson(this);

  bool get isAdminRole => roles?.contains('ROLE_ADMIN') ?? (isAdmin ?? false);
  bool get isNormalUser => roles?.contains('ROLE_NORMAL_USER') ?? false;

  MemberInfoDto copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? otp,
    bool? isPhoneVerified,
    bool? isAdmin,
    String? address,
    String? memberTypeEnumKey,
    String? memberTypeEnumValue,
    String? numberOfFreeDineAssociated,
    List<dynamic>? dineInfoDtoList,
    dynamic personalDineInfoDto,
    List<dynamic>? dineMemberMappingDtoList,
    String? roles,
    bool? isLeavedFromDine,
    bool? enabled,
    bool? isCreatePersonalDine,
    String? createdBy,
    String? createdDate,
    String? otpExpireTime,
    bool? isAcceptTermsAndCondition,
  }) {
    return MemberInfoDto(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      otp: otp ?? this.otp,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isAdmin: isAdmin ?? this.isAdmin,
      address: address ?? this.address,
      memberTypeEnumKey: memberTypeEnumKey ?? this.memberTypeEnumKey,
      memberTypeEnumValue: memberTypeEnumValue ?? this.memberTypeEnumValue,
      numberOfFreeDineAssociated:
          numberOfFreeDineAssociated ?? this.numberOfFreeDineAssociated,
      dineInfoDtoList: dineInfoDtoList ?? this.dineInfoDtoList,
      personalDineInfoDto: personalDineInfoDto ?? this.personalDineInfoDto,
      dineMemberMappingDtoList:
          dineMemberMappingDtoList ?? this.dineMemberMappingDtoList,
      roles: roles ?? this.roles,
      isLeavedFromDine: isLeavedFromDine ?? this.isLeavedFromDine,
      enabled: enabled ?? this.enabled,
      isCreatePersonalDine: isCreatePersonalDine ?? this.isCreatePersonalDine,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
      otpExpireTime: otpExpireTime ?? this.otpExpireTime,
      isAcceptTermsAndCondition:
          isAcceptTermsAndCondition ?? this.isAcceptTermsAndCondition,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberInfoDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'MemberInfoDto(id: $id, fullName: $fullName, phoneNumber: $phoneNumber)';
}
