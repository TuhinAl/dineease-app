import 'package:json_annotation/json_annotation.dart';

part 'form_status_with_page.g.dart';

/// Base class for search/pagination DTOs
@JsonSerializable()
class FormStatusWithPage {
  final bool? loadingMode;
  final bool? updateMode;
  final int? page;
  @JsonKey(defaultValue: 10)
  final int? size;
  final String? multiSearchProp;
  final String? displayProp;

  const FormStatusWithPage({
    this.loadingMode,
    this.updateMode,
    this.page,
    this.size = 10,
    this.multiSearchProp,
    this.displayProp,
  });

  factory FormStatusWithPage.fromJson(Map<String, dynamic> json) =>
      _$FormStatusWithPageFromJson(json);

  Map<String, dynamic> toJson() => _$FormStatusWithPageToJson(this);

  @override
  String toString() =>
      'FormStatusWithPage(page: $page, size: $size, loadingMode: $loadingMode)';
}
