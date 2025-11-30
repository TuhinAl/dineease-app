import 'package:dio/dio.dart';
import '../config/environment.dart';
import '../models/models.dart';
import '../models/auth/auth_dtos.dart' show DineInfoResponse, DineInfoSearchDto;

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
}
