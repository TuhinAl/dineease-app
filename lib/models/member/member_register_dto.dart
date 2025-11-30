import 'package:json_annotation/json_annotation.dart';
import '../sms/sms_dto.dart';

part 'member_register_dto.g.dart';

/// Member registration data (extends SMSDto)
@JsonSerializable()
class MemberRegisterDto extends SMSDto {
  final String? fullName;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? address;
  final bool? isPhoneVerified;
  final bool? isAcceptTermsAndCondition;

  const MemberRegisterDto({
    // SMSDto properties
    super.id,
    super.phoneNumber,
    super.otp,
    super.otpResponseBody,
    super.expiryTime,
    super.attempts,
    super.isPhoneNumberAlreadyRegistered,
    // MemberRegisterDto properties
    this.fullName,
    this.email,
    this.password,
    this.confirmPassword,
    this.address,
    this.isPhoneVerified,
    this.isAcceptTermsAndCondition,
  });

  factory MemberRegisterDto.fromJson(Map<String, dynamic> json) =>
      _$MemberRegisterDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MemberRegisterDtoToJson(this);

  /// Validate registration data
  bool validate() {
    // Phone number validation
    if (phoneNumber == null || phoneNumber!.length != 11) {
      return false;
    }

    // Name validation
    if (fullName == null || fullName!.isEmpty) {
      return false;
    }

    // Email validation (basic)
    if (email != null && email!.isNotEmpty) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email!)) {
        return false;
      }
    }

    // Password validation
    if (password == null || password!.length < 8) {
      return false;
    }

    // Password match validation
    if (password != confirmPassword) {
      return false;
    }

    // Terms acceptance validation
    if (isAcceptTermsAndCondition != true) {
      return false;
    }

    return true;
  }

  @override
  String toString() =>
      'MemberRegisterDto(fullName: $fullName, phoneNumber: $phoneNumber, email: $email)';
}
