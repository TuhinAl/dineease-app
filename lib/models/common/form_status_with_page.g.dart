// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_status_with_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormStatusWithPage _$FormStatusWithPageFromJson(Map<String, dynamic> json) =>
    FormStatusWithPage(
      loadingMode: json['loadingMode'] as bool?,
      updateMode: json['updateMode'] as bool?,
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt() ?? 10,
      multiSearchProp: json['multiSearchProp'] as String?,
      displayProp: json['displayProp'] as String?,
    );

Map<String, dynamic> _$FormStatusWithPageToJson(FormStatusWithPage instance) =>
    <String, dynamic>{
      'loadingMode': instance.loadingMode,
      'updateMode': instance.updateMode,
      'page': instance.page,
      'size': instance.size,
      'multiSearchProp': instance.multiSearchProp,
      'displayProp': instance.displayProp,
    };
