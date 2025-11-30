import 'package:json_annotation/json_annotation.dart';

part 'notification_summary_dto.g.dart';

/// Notification summary statistics
@JsonSerializable()
class NotificationSummaryDto {
  final int? totalCount;
  final int? unreadCount;
  final int? readCount;
  final String? latestNotificationAt;
  final String? latestUnreadAt;

  const NotificationSummaryDto({
    this.totalCount,
    this.unreadCount,
    this.readCount,
    this.latestNotificationAt,
    this.latestUnreadAt,
  });

  factory NotificationSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSummaryDtoToJson(this);

  /// Check if there are unread notifications
  bool get hasUnread => (unreadCount ?? 0) > 0;

  @override
  String toString() =>
      'NotificationSummaryDto(total: $totalCount, unread: $unreadCount)';
}
