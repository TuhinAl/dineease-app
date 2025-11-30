import 'package:json_annotation/json_annotation.dart';
import 'member_response.dart';

part 'authentication_response.g.dart';

/// Login response DTO
@JsonSerializable()
class AuthenticationResponse {
  final String? id;
  final String? phoneNumber;
  final String? accessToken;
  final String? refreshToken;
  final MemberResponse? memberResponse;
  final int? expiresIn;
  final String? timestamp;
  final String? otp;
  final String? otpResponseBody;
  final String? expiryTime;
  final int? attempts;
  final bool? isPhoneNumberAlreadyRegistered;

  const AuthenticationResponse({
    this.id,
    this.phoneNumber,
    this.accessToken,
    this.refreshToken,
    this.memberResponse,
    this.expiresIn,
    this.timestamp,
    this.otp,
    this.otpResponseBody,
    this.expiryTime,
    this.attempts,
    this.isPhoneNumberAlreadyRegistered,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

  /// Check if token is valid
  bool get hasValidToken => accessToken != null && accessToken!.isNotEmpty;

  /// Check if OTP verification is needed
  bool get needsOtpVerification => otp != null && otp!.isNotEmpty;

  /// Get expiry DateTime
  DateTime? get expiryDateTime {
    if (expiryTime == null) return null;
    try {
      return DateTime.parse(expiryTime!);
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() =>
      'AuthenticationResponse(id: $id, phoneNumber: $phoneNumber, hasToken: $hasValidToken)';
}
