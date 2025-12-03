import 'package:json_annotation/json_annotation.dart';

part 'password_reset_dtos.g.dart';

/// Request DTO for password reset
@JsonSerializable()
class PasswordResetRequest {
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  PasswordResetRequest({
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$PasswordResetRequestToJson(this);

  factory PasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestFromJson(json);
}

/// Response DTO for password reset
@JsonSerializable()
class PasswordResetData {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final bool? isPhoneVerified;
  final bool? isAdmin;
  final String? address;
  final bool? enabled;

  PasswordResetData({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.isPhoneVerified,
    this.isAdmin,
    this.address,
    this.enabled,
  });

  factory PasswordResetData.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetDataFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetDataToJson(this);
}
