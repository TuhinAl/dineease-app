import 'package:dio/dio.dart';
import '../config/environment.dart';
import '../models/models.dart';
import '../models/auth/auth_dtos.dart' show DineInfoResponse, DineInfoSearchDto;
import '../models/auth/otp_dtos.dart';
import '../models/auth/phone_registration_dtos.dart';
import '../models/auth/password_reset_dtos.dart';
import '../models/sms/sms_dto.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? apiResponseCode;

  ApiException({required this.message, this.statusCode, this.apiResponseCode});

  @override
  String toString() => message;
}

class AuthService {
  final Dio _dio;

  AuthService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: Environment.contextPath,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  /// Login with phone number and password
  Future<ApiResponse<AuthenticationResponse>> login(
    AuthenticationRequest request,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.memberLogin,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<AuthenticationResponse>.fromJson(
          response.data,
          (data) =>
              AuthenticationResponse.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'Login failed. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        // Handle different error scenarios
        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ?? 'Login failed. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      }

      throw ApiException(message: 'Login failed. Please try again.');
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Fetch dine information for member
  Future<DineInfoResponse> fetchDineInfo(String phoneNumber) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.memberDineAssociate,
        data: DineInfoSearchDto(phoneNumber: phoneNumber).toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DineInfoResponse.fromJson(response.data);
      } else {
        throw ApiException(
          message: 'Failed to fetch dine information.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final message =
              data['message'] as String? ?? 'Failed to fetch dine information.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
          );
        }
      }

      throw ApiException(message: 'Failed to fetch dine information.');
    } catch (e) {
      throw ApiException(message: 'An unexpected error occurred.');
    }
  }

  /// Verify OTP
  Future<ApiResponse<VerifyOtpData>> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.otpVerification,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<VerifyOtpData>.fromJson(
          response.data,
          (data) => VerifyOtpData.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'OTP verification failed. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ??
              'OTP verification failed. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      }

      throw ApiException(message: 'OTP verification failed. Please try again.');
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Resend OTP
  Future<ApiResponse<ResendOtpData>> resendOtp(ResendOtpRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.resendOtp,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<ResendOtpData>.fromJson(
          response.data,
          (data) => ResendOtpData.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'Failed to resend OTP. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final message =
              data['message'] as String? ??
              'Failed to resend OTP. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      }

      throw ApiException(message: 'Failed to resend OTP. Please try again.');
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Check if phone number is already registered
  Future<ApiResponse<CheckPhoneRegisteredData>> checkPhoneRegistered(
    CheckPhoneRegisteredRequest request,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.checkPhoneRegistered,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<CheckPhoneRegisteredData>.fromJson(
          response.data,
          (data) =>
              CheckPhoneRegisteredData.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'Failed to check phone registration. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ??
              'Failed to check phone registration. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message:
              'Unable to connect to server. Please check your internet connection or try again later.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message:
              'Unable to connect to server. Please check your internet connection or try again later.',
        );
      }

      throw ApiException(
        message: 'Failed to check phone registration. Please try again.',
      );
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Send OTP to phone number
  Future<ApiResponse<SendOtpData>> sendOtp(SendOtpRequest request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.sendOtp,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<SendOtpData>.fromJson(
          response.data,
          (data) => SendOtpData.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'Failed to send OTP. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ??
              'Failed to send OTP. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message:
              'Unable to connect to server. Please check your internet connection or try again later.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message:
              'Unable to connect to server. Please check your internet connection or try again later.',
        );
      }

      throw ApiException(message: 'Failed to send OTP. Please try again.');
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Verify OTP for Password Reset Flow
  Future<ApiResponse<MemberInfoDto>> verifyPasswordResetOtp(
    SMSDto request,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.otpVerification,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<MemberInfoDto>.fromJson(
          response.data,
          (data) => MemberInfoDto.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'OTP verification failed. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ??
              'OTP verification failed. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      }

      throw ApiException(message: 'OTP verification failed. Please try again.');
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Resend OTP for Password Reset Flow
  Future<ApiResponse<MemberInfoDto>> resendPasswordResetOtp(
    SMSDto request,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.resendOtp,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<MemberInfoDto>.fromJson(
          response.data,
          (data) => MemberInfoDto.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'Failed to resend OTP. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ??
              'Failed to resend OTP. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message: 'Network error. Please check your connection and try again.',
        );
      }

      throw ApiException(message: 'Failed to resend OTP. Please try again.');
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Reset password with phone number verification
  Future<ApiResponse<PasswordResetData>> resetPassword(
    PasswordResetRequest request,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.updatePassword,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<PasswordResetData>.fromJson(
          response.data,
          (data) => PasswordResetData.fromJson(data as Map<String, dynamic>),
        );
      } else {
        throw ApiException(
          message: 'Failed to reset password. Please try again.',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;

        if (data is Map<String, dynamic>) {
          final apiResponseCode = data['apiResponseCode'] as String?;
          final message =
              data['message'] as String? ??
              'Failed to reset password. Please try again.';

          throw ApiException(
            message: message,
            statusCode: e.response!.statusCode,
            apiResponseCode: apiResponseCode,
          );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException(
          message:
              'Unable to connect to server. Please check your internet connection or try again later.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException(
          message:
              'Unable to connect to server. Please check your internet connection or try again later.',
        );
      }

      throw ApiException(
        message: 'Failed to reset password. Please try again.',
      );
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }
}
