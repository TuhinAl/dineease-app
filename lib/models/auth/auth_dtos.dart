// 🔄 DEPRECATED: This file is kept for backward compatibility
// Please use the new DTOs from the models package:
// import 'package:trying_flutter/models/models.dart';

// Re-export new DTOs for backward compatibility
export 'authentication_request.dart';
export 'authentication_response.dart';
export 'member_response.dart';
export 'refresh_token_request.dart';

// ⚠️ OLD DTOs BELOW - DEPRECATED - Use the exported ones above instead

// Authentication Request DTO
class AuthenticationRequestOld {
  final String phoneNumber;
  final String password;

  AuthenticationRequestOld({required this.phoneNumber, required this.password});

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber, 'password': password};
  }
}

// Member Response DTO
class MemberResponseOld {
  final String id;
  final String phoneNumber;
  final String name;
  final String? email;
  final List<String> roles;

  MemberResponseOld({
    required this.id,
    required this.phoneNumber,
    required this.name,
    this.email,
    required this.roles,
  });

  factory MemberResponseOld.fromJson(Map<String, dynamic> json) {
    return MemberResponseOld(
      id: json['id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      roles:
          (json['roles'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'roles': roles,
    };
  }
}

// Authentication Data DTO - OLD VERSION
class AuthenticationDataOld {
  final String accessToken;
  final String refreshToken;
  final MemberResponseOld memberResponse;

  AuthenticationDataOld({
    required this.accessToken,
    required this.refreshToken,
    required this.memberResponse,
  });

  factory AuthenticationDataOld.fromJson(Map<String, dynamic> json) {
    return AuthenticationDataOld(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      memberResponse: MemberResponseOld.fromJson(json['memberResponse'] ?? {}),
    );
  }
}

// Authentication Response DTO - OLD VERSION
class AuthenticationResponseOld {
  final bool status;
  final String message;
  final AuthenticationDataOld? data;
  final int httpStatusCode;
  final String apiResponseCode;

  AuthenticationResponseOld({
    required this.status,
    required this.message,
    this.data,
    required this.httpStatusCode,
    required this.apiResponseCode,
  });

  factory AuthenticationResponseOld.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponseOld(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AuthenticationDataOld.fromJson(json['data'])
          : null,
      httpStatusCode: json['httpStatusCode'] ?? 0,
      apiResponseCode: json['apiResponseCode'] ?? '',
    );
  }
}

// Dine Info Search DTO
class DineInfoSearchDto {
  final String phoneNumber;

  DineInfoSearchDto({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber};
  }
}

// Dine Data DTO
class DineData {
  final String id;
  final String dineName;
  final String createdDate;

  DineData({
    required this.id,
    required this.dineName,
    required this.createdDate,
  });

  factory DineData.fromJson(Map<String, dynamic> json) {
    return DineData(
      id: json['id'] ?? '',
      dineName: json['dineName'] ?? '',
      createdDate: json['createdDate'] ?? '',
    );
  }
}

// Dine Info Response DTO
class DineInfoResponse {
  final bool status;
  final DineData? data;

  DineInfoResponse({required this.status, this.data});

  factory DineInfoResponse.fromJson(Map<String, dynamic> json) {
    return DineInfoResponse(
      status: json['status'] ?? false,
      data: json['data'] != null ? DineData.fromJson(json['data']) : null,
    );
  }
}
