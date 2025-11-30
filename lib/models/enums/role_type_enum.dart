/// User role types
enum RoleTypeEnum {
  normalUser('NORMAL_USER', 'Normal User'),
  admin('ADMIN', 'Admin');

  final String key;
  final String value;

  const RoleTypeEnum(this.key, this.value);

  /// Get enum from key
  static RoleTypeEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return RoleTypeEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return RoleTypeEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
