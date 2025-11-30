import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

/// Generic API response wrapper
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final T? data;
  final String? apiResponseCode;
  final int? httpStatusCode;
  final bool? status;
  final String? message;

  const ApiResponse({
    this.data,
    this.apiResponseCode,
    this.httpStatusCode,
    this.status,
    this.message,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  /// Check if the response is successful
  bool get isSuccess => status == true;

  /// Check if the response has data
  bool get hasData => data != null;

  @override
  String toString() =>
      'ApiResponse(status: $status, message: $message, data: $data)';
}
