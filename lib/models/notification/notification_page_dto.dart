import 'package:json_annotation/json_annotation.dart';
import 'notification_dto.dart';

part 'notification_page_dto.g.dart';

/// Paginated notification list
@JsonSerializable()
class NotificationPageDto {
  final List<NotificationDto>? notifications;
  final int? totalElements;
  final int? totalPages;
  final int? currentPage;
  final int? pageSize;
  final bool? hasNext;
  final bool? hasPrevious;

  const NotificationPageDto({
    this.notifications,
    this.totalElements,
    this.totalPages,
    this.currentPage,
    this.pageSize,
    this.hasNext,
    this.hasPrevious,
  });

  factory NotificationPageDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationPageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPageDtoToJson(this);

  @override
  String toString() =>
      'NotificationPageDto(totalElements: $totalElements, currentPage: $currentPage)';
}
