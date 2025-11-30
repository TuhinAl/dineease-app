import 'package:json_annotation/json_annotation.dart';

part 'authentication_request.g.dart';

/// Login request DTO
@JsonSerializable()
class AuthenticationRequest {
  final String? phoneNumber;
  final String? password;

  const AuthenticationRequest({this.phoneNumber, this.password});

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationRequestToJson(this);

  /// Validate the request data
  bool validate() {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      return false;
    }
    if (password == null || password!.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  String toString() => 'AuthenticationRequest(phoneNumber: $phoneNumber)';
}
