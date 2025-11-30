// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDto _$NotificationDtoFromJson(
  Map<String, dynamic> json,
) => NotificationDto(
  id: json['id'] as String?,
  memberInfoId: json['memberInfoId'] as String?,
  title: json['title'] as String?,
  message: json['message'] as String?,
  notificationData: json['notificationData'] == null
      ? null
      : NotificationData.fromJson(
          json['notificationData'] as Map<String, dynamic>,
        ),
  actionUrl: json['actionUrl'] as String?,
  actionTypeEnumKey: json['actionTypeEnumKey'] as String?,
  actionTypeEnumValue: json['actionTypeEnumValue'] as String?,
  deliveryStatusEnumKey: json['deliveryStatusEnumKey'] as String?,
  deliveryStatusEnumValue: json['deliveryStatusEnumValue'] as String?,
  notificationCategoryEnumKey: json['notificationCategoryEnumKey'] as String?,
  notificationCategoryEnumValue:
      json['notificationCategoryEnumValue'] as String?,
  notificationTypeEnumKey: json['notificationTypeEnumKey'] as String?,
  notificationTypeEnumValue: json['notificationTypeEnumValue'] as String?,
  readStatusEnumKey: json['readStatusEnumKey'] as String?,
  readStatusEnumValue: json['readStatusEnumValue'] as String?,
  sentDateTime: json['sentDateTime'] as String?,
  deliveredDateTime: json['deliveredDateTime'] as String?,
  readDateTime: json['readDateTime'] as String?,
  archivedDateTime: json['archivedDateTime'] as String?,
  deliveryAttempts: (json['deliveryAttempts'] as num?)?.toInt(),
  lastDeliveryAttemptDateTime: json['lastDeliveryAttemptDateTime'] as String?,
  deliveryError: json['deliveryError'] as String?,
  deletedDateTime: json['deletedDateTime'] as String?,
  expiresDateTime: json['expiresDateTime'] as String?,
  priority: (json['priority'] as num?)?.toInt(),
  readOnDevice: json['readOnDevice'] as String?,
  updatedDateTime: json['updatedDateTime'] as String?,
);

Map<String, dynamic> _$NotificationDtoToJson(NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memberInfoId': instance.memberInfoId,
      'title': instance.title,
      'message': instance.message,
      'notificationData': instance.notificationData,
      'actionUrl': instance.actionUrl,
      'actionTypeEnumKey': instance.actionTypeEnumKey,
      'actionTypeEnumValue': instance.actionTypeEnumValue,
      'deliveryStatusEnumKey': instance.deliveryStatusEnumKey,
      'deliveryStatusEnumValue': instance.deliveryStatusEnumValue,
      'notificationCategoryEnumKey': instance.notificationCategoryEnumKey,
      'notificationCategoryEnumValue': instance.notificationCategoryEnumValue,
      'notificationTypeEnumKey': instance.notificationTypeEnumKey,
      'notificationTypeEnumValue': instance.notificationTypeEnumValue,
      'readStatusEnumKey': instance.readStatusEnumKey,
      'readStatusEnumValue': instance.readStatusEnumValue,
      'sentDateTime': instance.sentDateTime,
      'deliveredDateTime': instance.deliveredDateTime,
      'readDateTime': instance.readDateTime,
      'archivedDateTime': instance.archivedDateTime,
      'deliveryAttempts': instance.deliveryAttempts,
      'lastDeliveryAttemptDateTime': instance.lastDeliveryAttemptDateTime,
      'deliveryError': instance.deliveryError,
      'deletedDateTime': instance.deletedDateTime,
      'expiresDateTime': instance.expiresDateTime,
      'priority': instance.priority,
      'readOnDevice': instance.readOnDevice,
      'updatedDateTime': instance.updatedDateTime,
    };
