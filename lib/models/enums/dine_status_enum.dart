/// Dine/Mess status
enum DineStatusEnum {
  active('ACTIVE', 'Active'),
  deactivate('DEACTIVATE', 'Deactivate'),
  deleted('DELETED', 'Deleted');

  final String key;
  final String value;

  const DineStatusEnum(this.key, this.value);

  /// Get enum from key
  static DineStatusEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return DineStatusEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return DineStatusEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
