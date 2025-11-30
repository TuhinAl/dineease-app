/// Member types in system
enum MemberTypeEnum {
  normalUser('NORMAL_USER', 'Normal User'),
  superAdmin('SUPER_ADMIN', 'Super Admin'),
  admin('ADMIN', 'Admin');

  final String key;
  final String value;

  const MemberTypeEnum(this.key, this.value);

  /// Get enum from key
  static MemberTypeEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return MemberTypeEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return MemberTypeEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
