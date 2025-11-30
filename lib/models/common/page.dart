import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

/// Generic pagination wrapper
@JsonSerializable(genericArgumentFactories: true)
class Page<T> {
  final List<T> content;
  final int totalElements;
  final int totalPages;
  final int size;
  final int number;
  final bool first;
  final bool last;
  final int numberOfElements;
  final bool empty;

  const Page({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.empty,
  });

  factory Page.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PageFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageToJson(this, toJsonT);

  /// Check if there is a next page
  bool get hasNext => !last;

  /// Check if there is a previous page
  bool get hasPrevious => !first;

  @override
  String toString() =>
      'Page(totalElements: $totalElements, totalPages: $totalPages, number: $number)';
}
