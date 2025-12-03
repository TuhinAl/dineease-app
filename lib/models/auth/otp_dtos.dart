import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'otp_dtos.g.dart';

/// Request DTO for OTP verification
@JsonSerializable()
class VerifyOtpRequest {
  final String phoneNumber;
  final String otp;
  final String? expiryTime;

  VerifyOtpRequest({
    required this.phoneNumber,
    required this.otp,
    this.expiryTime,
  });

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

/// Response DTO for OTP verification
@JsonSerializable()
class VerifyOtpData {
  final String? id;
  final String phoneNumber;
  final bool? isAdmin;
  final bool? isPhoneVerified;

  VerifyOtpData({
    this.id,
    required this.phoneNumber,
    this.isAdmin,
    this.isPhoneVerified,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpDataToJson(this);
}

/// Request DTO for resending OTP
@JsonSerializable()
class ResendOtpRequest {
  final String phoneNumber;

  ResendOtpRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() => _$ResendOtpRequestToJson(this);
}

/// Response DTO for resend OTP
@JsonSerializable()
class ResendOtpData {
  final String phoneNumber;
  final String? otpExpireTime;
  final String? otp;
  final String? otpResponseBody;
  final String? expiryTime;

  ResendOtpData({
    required this.phoneNumber,
    this.otpExpireTime,
    this.otp,
    this.otpResponseBody,
    this.expiryTime,
  });

  factory ResendOtpData.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpDataToJson(this);
}
