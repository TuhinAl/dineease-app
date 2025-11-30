import 'package:json_annotation/json_annotation.dart';
import 'notification_data.dart';

part 'notification_dto.g.dart';

/// Individual notification details
@JsonSerializable()
class NotificationDto {
  final String? id;
  final String? memberInfoId;
  final String? title;
  final String? message;
  final NotificationData? notificationData;
  final String? actionUrl;
  final String? actionTypeEnumKey;
  final String? actionTypeEnumValue;
  final String? deliveryStatusEnumKey;
  final String? deliveryStatusEnumValue;
  final String? notificationCategoryEnumKey;
  final String? notificationCategoryEnumValue;
  final String? notificationTypeEnumKey;
  final String? notificationTypeEnumValue;
  final String? readStatusEnumKey;
  final String? readStatusEnumValue;
  final String? sentDateTime;
  final String? deliveredDateTime;
  final String? readDateTime;
  final String? archivedDateTime;
  final int? deliveryAttempts;
  final String? lastDeliveryAttemptDateTime;
  final String? deliveryError;
  final String? deletedDateTime;
  final String? expiresDateTime;
  final int? priority;
  final String? readOnDevice;
  final String? updatedDateTime;

  const NotificationDto({
    this.id,
    this.memberInfoId,
    this.title,
    this.message,
    this.notificationData,
    this.actionUrl,
    this.actionTypeEnumKey,
    this.actionTypeEnumValue,
    this.deliveryStatusEnumKey,
    this.deliveryStatusEnumValue,
    this.notificationCategoryEnumKey,
    this.notificationCategoryEnumValue,
    this.notificationTypeEnumKey,
    this.notificationTypeEnumValue,
    this.readStatusEnumKey,
    this.readStatusEnumValue,
    this.sentDateTime,
    this.deliveredDateTime,
    this.readDateTime,
    this.archivedDateTime,
    this.deliveryAttempts,
    this.lastDeliveryAttemptDateTime,
    this.deliveryError,
    this.deletedDateTime,
    this.expiresDateTime,
    this.priority,
    this.readOnDevice,
    this.updatedDateTime,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDtoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'NotificationDto(id: $id, title: $title)';
}
