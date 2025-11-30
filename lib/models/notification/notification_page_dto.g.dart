// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPageDto _$NotificationPageDtoFromJson(Map<String, dynamic> json) =>
    NotificationPageDto(
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      hasNext: json['hasNext'] as bool?,
      hasPrevious: json['hasPrevious'] as bool?,
    );

Map<String, dynamic> _$NotificationPageDtoToJson(
  NotificationPageDto instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
  'hasNext': instance.hasNext,
  'hasPrevious': instance.hasPrevious,
};
