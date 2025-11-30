// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSummaryDto _$NotificationSummaryDtoFromJson(
  Map<String, dynamic> json,
) => NotificationSummaryDto(
  totalCount: (json['totalCount'] as num?)?.toInt(),
  unreadCount: (json['unreadCount'] as num?)?.toInt(),
  readCount: (json['readCount'] as num?)?.toInt(),
  latestNotificationAt: json['latestNotificationAt'] as String?,
  latestUnreadAt: json['latestUnreadAt'] as String?,
);

Map<String, dynamic> _$NotificationSummaryDtoToJson(
  NotificationSummaryDto instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'unreadCount': instance.unreadCount,
  'readCount': instance.readCount,
  'latestNotificationAt': instance.latestNotificationAt,
  'latestUnreadAt': instance.latestUnreadAt,
};
