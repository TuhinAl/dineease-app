import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

/// Token refresh request
@JsonSerializable()
class RefreshTokenRequest {
  final String? refreshToken;

  const RefreshTokenRequest({this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);

  @override
  String toString() => 'RefreshTokenRequest(hasToken: ${refreshToken != null})';
}
