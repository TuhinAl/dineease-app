import 'package:json_annotation/json_annotation.dart';

part 'member_response.g.dart';

/// User information in auth response
@JsonSerializable()
class MemberResponse {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final List<String>? roles;

  const MemberResponse({this.id, this.name, this.phoneNumber, this.roles});

  factory MemberResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberResponseToJson(this);

  /// Check if user is admin
  bool get isAdmin =>
      roles?.any((role) => role.toUpperCase().contains('ADMIN')) ?? false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberResponse &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'MemberResponse(id: $id, name: $name, phoneNumber: $phoneNumber, roles: $roles)';
}
