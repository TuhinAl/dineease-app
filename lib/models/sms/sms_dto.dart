import 'package:json_annotation/json_annotation.dart';

part 'sms_dto.g.dart';

/// SMS and OTP handling
@JsonSerializable()
class SMSDto {
  final String? id;
  final String? phoneNumber;
  final String? otp;
  final String? otpResponseBody;
  final String? expiryTime;
  final int? attempts;
  final String? isPhoneNumberAlreadyRegistered;

  const SMSDto({
    this.id,
    this.phoneNumber,
    this.otp,
    this.otpResponseBody,
    this.expiryTime,
    this.attempts,
    this.isPhoneNumberAlreadyRegistered,
  });

  factory SMSDto.fromJson(Map<String, dynamic> json) => _$SMSDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SMSDtoToJson(this);

  /// Get OTP expiry as DateTime
  DateTime? get expiryDateTime {
    if (expiryTime == null) return null;
    try {
      return DateTime.parse(expiryTime!);
    } catch (e) {
      return null;
    }
  }

  /// Check if OTP is expired
  bool get isExpired {
    final expiry = expiryDateTime;
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  @override
  String toString() =>
      'SMSDto(phoneNumber: $phoneNumber, attempts: $attempts, isExpired: $isExpired)';
}
