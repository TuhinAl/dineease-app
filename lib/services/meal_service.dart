import 'package:dio/dio.dart';
import '../config/environment.dart';
import '../models/meal/meal_history_details_dto.dart';
import '../models/meal/meal_history_details_search_dto.dart';
import '../models/common/page.dart';
import '../models/common/api_response.dart';
import 'storage_service.dart';

class MealService {
  static final MealService _instance = MealService._internal();
  factory MealService() => _instance;
  MealService._internal();

  final StorageService _storageService = StorageService();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '${Environment.contextPath}/member/meal',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<void> _setAuthToken() async {
    final token = await _storageService.getAccessToken();
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// Create a new meal entry
  Future<ApiResponse<MealHistoryDetailsDto>> createMeal(
    MealHistoryDetailsDto meal,
  ) async {
    try {
      await _setAuthToken();
      final response = await _dio.post('/create', data: meal.toJson());

      return ApiResponse<MealHistoryDetailsDto>.fromJson(
        response.data,
        (json) => MealHistoryDetailsDto.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// Update an existing meal entry
  Future<ApiResponse<MealHistoryDetailsDto>> updateMeal(
    MealHistoryDetailsDto meal,
  ) async {
    try {
      await _setAuthToken();
      final response = await _dio.put('/update', data: meal.toJson());

      return ApiResponse<MealHistoryDetailsDto>.fromJson(
        response.data,
        (json) => MealHistoryDetailsDto.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// Delete a meal entry
  Future<ApiResponse<String>> deleteMeal({
    required String id,
    required String dineId,
    required String memberId,
  }) async {
    try {
      await _setAuthToken();
      final requestBody = {
        'id': id,
        'dineInfoDto': {'id': dineId},
        'memberInfoDto': {'id': memberId},
      };

      final response = await _dio.delete('/delete', data: requestBody);

      return ApiResponse<String>.fromJson(
        response.data,
        (json) => json.toString(),
      );
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// Search personal meal history with pagination
  Future<ApiResponse<Page<MealHistoryDetailsDto>>> searchPersonalMeals(
    MealHistoryDetailsSearchDto searchDto,
  ) async {
    try {
      await _setAuthToken();
      final response = await _dio.post(
        '/search/personal',
        data: searchDto.toJson(),
      );

      return ApiResponse<Page<MealHistoryDetailsDto>>.fromJson(
        response.data,
        (json) => Page<MealHistoryDetailsDto>.fromJson(
          json as Map<String, dynamic>,
          (item) =>
              MealHistoryDetailsDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  /// Handle Dio errors
  ApiResponse<T> _handleDioError<T>(DioException error) {
    String message = 'An error occurred';
    String apiResponseCode = 'ERROR';
    int httpStatusCode = 500;

    if (error.response != null) {
      httpStatusCode = error.response!.statusCode ?? 500;
      final data = error.response!.data;

      if (data is Map<String, dynamic>) {
        message = data['message'] ?? message;
        apiResponseCode = data['apiResponseCode'] ?? apiResponseCode;
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timeout. Please try again.';
    } else if (error.type == DioExceptionType.connectionError) {
      message = 'Network error. Please check your connection.';
    }

    return ApiResponse<T>(
      data: null,
      status: false,
      message: message,
      apiResponseCode: apiResponseCode,
      httpStatusCode: httpStatusCode,
    );
  }
}
