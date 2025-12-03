import 'package:json_annotation/json_annotation.dart';

part 'phone_registration_dtos.g.dart';

/// Request DTO for checking if phone number is already registered
@JsonSerializable()
class CheckPhoneRegisteredRequest {
  final String phoneNumber;

  CheckPhoneRegisteredRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() => _$CheckPhoneRegisteredRequestToJson(this);
}

/// Response data for phone registration check
@JsonSerializable()
class CheckPhoneRegisteredData {
  final String phoneNumber;
  final String? id;
  final String? isPhoneNumberAlreadyRegistered;

  CheckPhoneRegisteredData({
    required this.phoneNumber,
    this.id,
    this.isPhoneNumberAlreadyRegistered,
  });

  factory CheckPhoneRegisteredData.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneRegisteredDataFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPhoneRegisteredDataToJson(this);
}

/// Request DTO for sending OTP
@JsonSerializable()
class SendOtpRequest {
  final String phoneNumber;

  SendOtpRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() => _$SendOtpRequestToJson(this);
}

/// Response data for send OTP
@JsonSerializable()
class SendOtpData {
  final String? id;
  final String phoneNumber;
  final String? otp;
  final String? otpResponseBody;
  final String? expiryTime;
  final String? otpExpireTime;
  final int? attempts;
  final String? isPhoneNumberAlreadyRegistered;

  SendOtpData({
    this.id,
    required this.phoneNumber,
    this.otp,
    this.otpResponseBody,
    this.expiryTime,
    this.otpExpireTime,
    this.attempts,
    this.isPhoneNumberAlreadyRegistered,
  });

  factory SendOtpData.fromJson(Map<String, dynamic> json) =>
      _$SendOtpDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpDataToJson(this);
}
