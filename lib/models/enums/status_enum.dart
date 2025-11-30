/// General status values
enum StatusEnum {
  running('RUNNING', 'Running'),
  disabled('DISABLED', 'Disabled'),
  pending('PENDING', 'Pending'),
  approved('APPROVED', 'Approved');

  final String key;
  final String value;

  const StatusEnum(this.key, this.value);

  /// Get enum from key
  static StatusEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return StatusEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return StatusEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
